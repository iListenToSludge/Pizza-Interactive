extends GridContainer
class_name Inventory

signal item_changed

##region Testing
#@export var ITEM : ItemResource
#@export var ITEM2 : ItemResource

#func _ready():
	#await get_tree().create_timer(2).timeout
	#add_item(ITEM)
	#await get_tree().create_timer(2).timeout
	#add_item(ITEM2)
##endregion


func add_item(item: ItemResource):
	print("ADDING:", item.item_name)

	var item_data = {
		"RESOURCE": item,
		"TEXTURE": item.item_texture,
		"NAME": item.item_name,
		"ATK": item.item_atk_power,
		"SLOT_TYPE": item.item_slot_type
	}

	for slot in get_children():
		if slot.item_data == null:
			slot.set_property(item_data)
			item_changed.emit()
			return true

	print("NO EMPTY SLOT FOUND")
	return false


func remove_item(item_resource: ItemResource):
	for slot in get_children():
		if slot.filled and slot.item_data["RESOURCE"] == item_resource:
			slot.clear_slot()
			item_changed.emit()
			return true

	return false


func is_available(item_resource: ItemResource):
	for slot in get_children():
		if slot.filled and slot.item_data["RESOURCE"] == item_resource:
			return true

	return false
