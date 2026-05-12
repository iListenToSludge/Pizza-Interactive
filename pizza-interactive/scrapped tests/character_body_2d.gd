extends CharacterBody2D
signal died
var speed = 200.0
var player_chase = false
var player: Node2D = null
var can_attack = true
var player_in_attack_range = false
@export var health := 100
@export var max_health := 100

@export var possible_drops: Array[int] = [0, 1, 2, 3, 4]
@export var drop_scene: PackedScene

func _physics_process(delta):
	# 1. Safety check
	if player == null or player.player_alive == false:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	# 2. Handle Movement
	var distance = global_position.distance_to(player.global_position)
	var direction = (player.global_position - global_position).normalized()

	if player_chase:
		if distance > 25: # Stay a tiny bit away
			velocity = direction * speed
		else:
			velocity = Vector2.ZERO # Stop to swing
	else:
		velocity = Vector2.ZERO

	# 3. Handle Attacking (Independent of movement)
	if player_in_attack_range and can_attack:
		attack()

	# 4. Apply movement
	move_and_slide()
func attack():
	print("--- ENEMY ATTACKED! ---")
	can_attack = false
	$hitbox/attack_timer.start()
	
	if player.has_method("take_damage"):
		player.take_damage(7)
	# Here is where you would call a function on the player like:
	# player.take_damage(10)

func _on_attack_timer_timeout():
	can_attack = true
	print("--- Timer finished: Enemy can attack again ---")
func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"): 
		print("Player's collision layer is: ", body.collision_layer)
		player = body
		player_chase = true 


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == player:
		print("Player left the zone")
		player = null
		player_chase = false
	

func _ready():
	can_attack = true
	print("Enemy is ready to fight!")
	$ProgressBar.max_value = max_health
	$ProgressBar.value = health

func take_damage(amount: int, _position = Vector2.ZERO):
	health -= amount
	$ProgressBar.value = health   # ← THIS is what you're missing
	
	print("Enemy health:", health)

	if health <= 0:
		die()

func drop_random_item():
	if possible_drops.is_empty():
		return

	var random_index = randi() % possible_drops.size()
	var item_id = possible_drops[random_index]

	var item = drop_scene.instantiate()
	item.ID = str(item_id)

	get_parent().add_child(item)
	item.global_position = global_position
	


func die():
	print("Enemy died")
	emit_signal("died")
	drop_random_item()
	queue_free()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_attack_range = true
		print("Player entered range")


func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_attack_range = false
		print("Player left range")
