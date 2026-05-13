extends PanelContainer
class_name Slot

var item_data = null

@onready var texture_rect: TextureRect = $TextureRect
@export var item_id : String = "0"
@export var item_resource : ItemResource = null

@export_enum("NONE:0","HEAD:1","BODY:2","LEG:3", "ACTIVE:4") var slot_type : int

@export var item : ItemResource = null:
	set(value):
		item = value
 
		if value != null:
			$TextureRect.texture = value.icon
		else:
			$TextureRect.texture = null

var filled : bool = false


func _get_drag_data(_at_position):
	set_drag_preview(get_preview())
	return texture_rect

 
func _can_drop_data(_pos, data):
	return data is TextureRect


func _drop_data(_pos, data):
	var other_slot = data.get_parent()

	# swap item data between slots
	var temp = item_data
	item_data = other_slot.item_data
	other_slot.item_data = temp

	# update visuals
	if item_data != null:
		texture_rect.texture = item_data["TEXTURE"]
		filled = true
	else:
		texture_rect.texture = null
		filled = false

	if other_slot.item_data != null:
		other_slot.texture_rect.texture = other_slot.item_data["TEXTURE"]
		other_slot.filled = true
	else:
		other_slot.texture_rect.texture = null
		other_slot.filled = false

func get_preview():
	var preview_texture = TextureRect.new()
 
	preview_texture.texture = texture_rect.texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(30,30)
 
	var preview = Control.new()
	preview.add_child(preview_texture)
 
	return preview


func get_ATK():
	return texture_rect.ATK


func set_property(data):
	item_data = data

	if data == null or data["TEXTURE"] == null:
		texture_rect.texture = null
		filled = false
		printerr("<Slot>: Invalid item data")
	else:
		texture_rect.texture = data["TEXTURE"]
		filled = true
 

func set_item_resource_data(resource_data : ItemResource):
	self.item_resource = resource_data

func clear_slot():
	item_data = null
	texture_rect.texture = null
	filled = false
