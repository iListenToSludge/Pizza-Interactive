extends CharacterBody2D

var max_speed := 600.0

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move left", "move right", "move up", "move down")
	velocity = direction * max_speed
	move_and_slide()
