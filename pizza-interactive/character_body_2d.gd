extends CharacterBody2D

var speed = 200.0
var player_chase = false
var player: Node2D = null

func _physics_process(delta):
	if player_chase and player != null:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()


func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true 


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
		player_chase = false
	
