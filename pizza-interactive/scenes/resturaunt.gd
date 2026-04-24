extends Node2D
@onready var pause_menu: Control = $CanvasLayer/PauseMenu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_menu.visible = false
	pass # Replace with function body.


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_menu"):
		print("pausing")
		toggle_pause()



func toggle_pause():
	get_tree().paused = !get_tree().paused
	pause_menu.visible = get_tree().paused
