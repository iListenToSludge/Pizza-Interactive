extends GridContainer
class_name Inventory


func add_item(ID : int = 0):
	var item_texture = ItemData.get_texture(ID) #load("res://assets/curated/" + ItemData.get_texture(ID))
	var item_slot_type = ItemData.get_slot_type(ID)
	var item_ATK = ItemData.get_ATK(ID)
 
	var item_data = {"TEXTURE": item_texture,
					 "ATK": item_ATK,
					 "SLOT_TYPE": item_slot_type}
	
	var index = 0
	# Iterating through slots
	for i in get_children():
		if i.filled == false:
			# Fill the first empty slot we encounter
			index = i.get_index()
			break
	get_child(index).set_property(item_data)
