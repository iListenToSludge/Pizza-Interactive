extends PanelContainer
class_name Slot

var item_data = null

@onready var texture_rect: TextureRect = $TextureRect

@export var slot_type : int
var filled : bool = false


func _get_drag_data(_at_position):
	set_drag_preview(get_preview())
	return texture_rect


func _can_drop_data(_pos, data):
	return data is TextureRect


func _drop_data(_pos, data):
	var other_slot = data.get_parent()

	var temp = item_data
	item_data = other_slot.item_data
	other_slot.item_data = temp

	_update_slot()
	other_slot._update_slot()


func get_preview():
	var preview_texture = TextureRect.new()
	preview_texture.texture = texture_rect.texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(30, 30)

	var preview = Control.new()
	preview.add_child(preview_texture)
	return preview


func set_property(data):
	item_data = data

	if data == null or data["TEXTURE"] == null:
		item_data = null
		filled = false
		texture_rect.texture = null
		return

	texture_rect.texture = data["TEXTURE"]
	filled = true


func clear_slot():
	item_data = null
	filled = false
	texture_rect.texture = null

func _update_slot():
	if item_data == null or item_data["TEXTURE"] == null:
		texture_rect.texture = null
		filled = false
	else:
		texture_rect.texture = item_data["TEXTURE"]
		filled = true
