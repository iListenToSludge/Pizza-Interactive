extends Sprite2D

 
@export var ID = "0"
 
func _ready():
	self.texture = ItemData.get_texture(int(ID)) 
 
func _on_body_entered(_body):
	get_parent().find_child("Inventory").add_item(int(ID))
	queue_free()
