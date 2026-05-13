extends GridContainer
class_name Inventory

signal item_changed

#region Testing
@export var ITEM : ItemResource
@export var ITEM2 : ItemResource

func _ready():
	await get_tree().create_timer(2).timeout
	add_item(ITEM)
	await get_tree().create_timer(2).timeout
	add_item(ITEM2)
#endregion

func add_item(item: ItemResource):
	var item_data = {
		"TEXTURE": item.item_texture,
		"NAME": item.item_name,
		"ATK": item.item_atk_power,
		"SLOT_TYPE": item.item_slot_type
	}

	for slot in get_children():
		if slot.filled == false:
			slot.set_property(item_data)
			item_changed.emit()
			return true

	return false

	return false

func remove_item(ID : int):
	for slot in get_children():
		if slot.filled and slot.item_data["ID"] == ID:
			slot.clear_slot()
			item_changed.emit()
			return true

	return false

func is_available(ID : int):
	for slot in get_children():
		if slot.filled and slot.item_data["ID"] == ID:
			return true

	return false
