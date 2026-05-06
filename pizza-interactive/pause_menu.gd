extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass


func _on_resume_pressed() -> void:
	get_tree().paused = false
	visible = false


func _on_quit_pressed() -> void:
	get_tree().quit()

#set Engine.time_scale as = 0 to pause the entire game and not just the scripts, 
#set Engine.time_scale = 1 to let the game start up again

func toggle_pause():
	get_tree().paused = !get_tree().paused
	visible = get_tree().paused

func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()
