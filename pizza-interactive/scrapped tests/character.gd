extends CharacterBody2D

var bullet_path=preload("res://bullet2.tscn")
var last_direction: Vector2 = Vector2.RIGHT

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

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
@export var max_ammo := 8
@export var reload_time := 5

var current_ammo := max_ammo
var is_reloading := false


func _ready():
	$ProgressBar.value = health
	collision_layer = 2  # This forces the player onto Layer 2 in code
	print("Player Layer confirmed as: ", collision_layer)
func take_damage(amount, _source_pos = Vector2.ZERO): 
	health -= amount
	health = clamp(health, 0, max_health)
	$ProgressBar.value = health
	
	if health <= 0:
		die()

func heal(amount):
	health += amount
	health = clamp(health, 0, max_health)
	$ProgressBar.value = health
	
	print("Healed:", amount)
	print("Current Health:", health)

func die():
	player_alive = false
	print("Player has died!")
	velocity = Vector2.ZERO
	$CollisionShape2D.set_deferred("disabled", true)
	self.visible = false
	get_tree().paused = true
	get_parent().get_node("DeathScreen").show()
	



func _physics_process(delta: float) -> void:
	if !player_alive:
		return

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
		
		
		if direction != Vector2.ZERO:
			last_direction=direction
			
		

	
	if Input.is_action_just_pressed("shoot"):
		if current_ammo > 0 and !is_reloading:
			fire()
		elif current_ammo <= 0:
			reload()
			
	if Input.is_action_just_pressed("melee") and can_melee:
		melee()
		
	if Input.is_action_just_pressed("reload"):
		reload()
	process_animation()
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
	current_ammo -= 1
	print("Ammo:", current_ammo)

	var bullet = bullet_path.instantiate()
	bullet.direction = (get_global_mouse_position() - global_position).normalized()
	bullet.global_position = $BulletSpawn.global_position
	bullet.rotation = bullet.direction.angle()
	get_parent().add_child(bullet)

	# Auto reload when empty
	if current_ammo <= 0:
		reload()

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

func reload():
	if is_reloading:
		return

	is_reloading = true
	print("Reloading...")

	await get_tree().create_timer(reload_time).timeout

	current_ammo = max_ammo
	is_reloading = false
	print("Reloaded!")
func process_animation() -> void:
	if velocity != Vector2.ZERO:
		play_animation("walking", last_direction)
	else:
		play_animation("idle", last_direction)


func play_animation(prefix: String, dir: Vector2) -> void:
	# Decide dominant direction (prevents flickering)
	if abs(dir.x) > abs(dir.y):
		# Horizontal movement
		animated_sprite_2d.flip_h = dir.x > 0
		animated_sprite_2d.play(prefix + "_left")
	else:
		# Vertical movement
		if dir.y < 0:
			animated_sprite_2d.play(prefix + "_back")
		else:
			animated_sprite_2d.play(prefix + "_front")
