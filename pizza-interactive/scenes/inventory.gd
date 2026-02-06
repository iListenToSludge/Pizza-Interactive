extends GridContainer

func _ready():
	add_item()

func add_item(ID = "0"):
	var item_texture = load("res://assetsitems/" + ItemData.get_texture(ID))
	var item_slot_type = ItemData.get_slot_type(ID)
	var item_ATK = ItemData.get_ATK(ID)
 
	var item_data = {"TEXTURE": item_texture,
					 "ATK": item_ATK,
					 "SLOT_TYPE": item_slot_type}
	
	var index = 0
	for i in get_children():
		if i.filled == false:
			index = i.get_index()
			break
	get_child(index).set_property(item_data)
