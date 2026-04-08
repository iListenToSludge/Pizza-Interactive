extends Sprite2D

 
@export var ID = "0"
 
func _ready():
	self.texture = ItemData.get_texture() #load("res://assets/curated/" + ItemData.get_texture(ID))
 
 
func _on_body_entered(_body):
	get_parent().find_child("Inventory").add_item(ID)
	queue_free()
 
