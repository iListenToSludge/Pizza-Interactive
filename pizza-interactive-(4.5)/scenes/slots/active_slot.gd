extends Slot
class_name ActiveSlot

func _can_drop_data(_pos, data):
	return data is TextureRect and data.slot_type == slot_type

func _drop_data(_pos, data):
	super._drop_data(_pos, data)
 
	get_parent().owner.find_child("player").set_speed(texture_rect.ATK)
