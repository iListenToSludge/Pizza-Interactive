extends Sprite2D

@onready var sprite: Sprite2D = $Sprite2D

@export var ID: int = 0
 
func _ready():
	sprite.texture = ItemData.get_texture(ID)


func _on_body_entered(body: Node2D) -> void:
	print("TOUCHED:", body.name)
	if body.is_in_group("player"):
		get_parent().find_child("Inventory").add_item(int(ID))
		queue_free()
