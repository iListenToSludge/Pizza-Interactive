extends Area2D

@export var heal_amount := 25

var player_in_range = false
var player_reference = null

@onready var prompt_label = $Label


func _ready():
	prompt_label.visible = false
	print("HealthPack ready")


func _process(_delta):
	

	if player_in_range and Input.is_action_just_pressed("pickup"):
		print("Pickup pressed")

		if player_reference != null:
			print("Healing player")
			player_reference.heal(heal_amount)
			queue_free()


func _on_body_entered(body):
	

	if body.has_method("heal"):
		

		player_in_range = true
		player_reference = body
		prompt_label.visible = true


func _on_body_exited(body):
	

	if body == player_reference:
		player_in_range = false
		player_reference = null
		prompt_label.visible = false
