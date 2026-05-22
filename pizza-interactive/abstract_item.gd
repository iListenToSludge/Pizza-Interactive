extends Sprite2D

 
@export var ID = 0
 
func _ready():
	self.texture = ItemData.get_texture(ID) 
 

func _on_body_entered(_body):
	var item_resource = ItemData.get_item(ID)
	get_parent().find_child("Inventory").add_item(item_resource)
	queue_free()
