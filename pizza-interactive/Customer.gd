extends CharacterBody2D

var patience = randf_range(5.0, 15.0)


enum State {
	ENTER,
	BROWSE,
	WAIT,
	SERVE,
	EXIT
}

var current_state = State.ENTER
var speed = 100
var target_position: Vector2

func _process(delta):
	match current_state:
		State.ENTER:
			move_to_target(delta)
			if is_at_target():
				change_state(State.BROWSE)

		State.BROWSE:
			# Simulate thinking time
			await get_tree().create_timer(2.0).timeout
			change_state(State.WAIT)

		State.WAIT:
			# Waiting in line logic
			pass

		State.SERVE:
			# Interaction logic
			await get_tree().create_timer(1.5).timeout
			change_state(State.EXIT)

		State.EXIT:
			move_to_target(delta)
			if is_at_target():
				queue_free()

func change_state(new_state):
	current_state = new_state

	match new_state:
		State.ENTER:
			target_position = Vector2(100, 100)

		State.BROWSE:
			# Pick random spot
			target_position = Vector2(randf_range(50, 200), randf_range(50, 200))

		State.WAIT:
			target_position = Vector2(300, 100)

		State.SERVE:
			pass

		State.EXIT:
			target_position = Vector2(-50, 100)

func move_to_target(delta):
	var direction = (target_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

func is_at_target() -> bool:
	return global_position.distance_to(target_position) < 5
