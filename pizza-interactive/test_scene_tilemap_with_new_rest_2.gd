extends Node2D

@onready var canvas_modulate = $CanvasModulate

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_inventory_gui_closed() -> void:
	get_tree().paused = false

func _on_inventory_gui_opened() -> void:
	get_tree().paused = true
