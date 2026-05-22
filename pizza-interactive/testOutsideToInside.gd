extends Area2D

var player_inside = null

func _process(_delta: float) -> void:
	if player_inside and Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://inside_rest.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inside = body

func _on_body_exited(body: Node2D) -> void:
	if body == player_inside:
		player_inside = null
