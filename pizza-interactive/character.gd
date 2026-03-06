extends CharacterBody2D

var bullet_path=preload("res://bullet2.tscn")

var enemy_inattack_range = false
var enemy_attack_cooldown = true 
var player_alive = true
var max_speed := 600.0
var health = 100
var max_health = 100
func _ready():
	$ProgressBar.value = health

func take_damage(amount):
	health -= amount
	$ProgressBar.value = health
	print("Player health: ", health)
	
	if health <= 0:
		die()
func die():
	print("Player has died!")
	

func _physics_process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot"):
		fire()
	enemy_attack()
	var direction := Input.get_vector("move left", "move right", "move up", "move down")
	velocity = direction * max_speed
	move_and_slide()

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
