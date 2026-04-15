extends CharacterBody2D

var bullet_path=preload("res://bullet2.tscn")

var enemy_inattack_range = false
var enemy_attack_cooldown = true 
var player_alive = true
var max_speed := 600.0
var health = 100
var max_health = 100
var dash_speed := 1400.0
var dash_duration := 0.15
var dash_cooldown := 0.8

var is_dashing := false
var can_dash := true
var dash_direction := Vector2.ZERO
var dash_timer := 0.0
@export var melee_damage := 25
var can_melee := true


func _ready():
	$ProgressBar.value = health
	collision_layer = 2  # This forces the player onto Layer 2 in code
	print("Player Layer confirmed as: ", collision_layer)
func take_damage(amount):
	health -= amount
	health = clamp(health, 0, max_health)
	$ProgressBar.value = health
	print("Player health: ", health)
	
	if health <= 0:
		die()
func die():
	player_alive = false
	print("Player has died!")
	velocity = Vector2.ZERO
	$CollisionShape2D.set_deferred("disabled", true)
	self.visible = false
func _physics_process(delta: float) -> void:
	if !player_alive:
		return

	look_at(get_global_mouse_position())

	# Start dash
	if Input.is_action_just_pressed("dash") and can_dash:
		start_dash()
	
	
	if is_dashing:
		dash_timer -= delta
		velocity = dash_direction * dash_speed

		if dash_timer <= 0:
			is_dashing = false
			
	else:
		var direction := Input.get_vector("move left", "move right", "move up", "move down")
		velocity = direction * max_speed

	# Shooting (now works again)
	if Input.is_action_just_pressed("shoot"):
		fire()
	if Input.is_action_just_pressed("melee") and can_melee:
		melee()

	move_and_slide()

func melee():
	print("Melee button pressed!")
	can_melee = false
	$MeleeTimer.start() # Start the cooldown
	
	# Get all overlapping bodies in the MeleeRange Area2D
	var targets = $MeleeRange.get_overlapping_bodies()
	print("Found targets: ", targets)
	for target in targets:
		# Ensure we aren't hitting ourselves and the target can take damage
		if target != self and target.has_method("take_damage"):
			target.take_damage(melee_damage)
			print("Hit enemy for: ", melee_damage)
func _on_melee_timer_timeout() -> void:
	can_melee = true


func fire():
	var bullet = bullet_path.instantiate()
	bullet.direction = (get_global_mouse_position() - global_position).normalized()
	bullet.global_position = global_position + bullet.direction * 40
	bullet.rotation = bullet.direction.angle()
	get_parent().add_child(bullet)

func player():
	pass

func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inattack_range = true


func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inattack_range = false

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)


func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true
	

func start_dash():
	can_dash = false
	is_dashing = true
	dash_timer = dash_duration

	var input_dir = Input.get_vector("move left", "move right", "move up", "move down")

	if input_dir != Vector2.ZERO:
		dash_direction = input_dir.normalized()
	else:
		dash_direction = (get_global_mouse_position() - global_position).normalized()

	

	# Cooldown timer (this one can still use await safely)
	await get_tree().create_timer(dash_cooldown).timeout
	can_dash = true
