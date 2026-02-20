extends CharacterBody2D

var speed = 200.0
var player_chase = false
var player: Node2D = null
var can_attack = true


func _physics_process(delta):
	if player_chase and player != null:
		var direction = (player.global_position - global_position).normalized()
		
		if global_position.distance_to(player.global_position) > 10:
			velocity = direction * speed
		else:
			velocity = Vector2.ZERO # Stop if we are close enough to "touch"
			
		# Check for attack
		if $hitbox.overlaps_body(player) and can_attack:
			attack()

			velocity = Vector2.ZERO
	
	move_and_slide()
func attack():
	if player != null and player.has_method("take_damage"):
		player.take_damage(10)
	print("Enemy attacks the player!")
	can_attack = false
	$hitbox/attack_timer.start()
	# Here is where you would call a function on the player like:
	# player.take_damage(10)

func _on_attack_timer_timeout():
	can_attack = true

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true 


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
		player_chase = false
	
