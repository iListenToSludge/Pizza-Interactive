extends Resource
class_name ItemResource

enum ItemSlotType {
	NONE = 0,
	HEAD = 1,
	BODY = 2,
	LEG = 3,
	ACTIVE = 4,
}

@export var item_texture : Texture2D 
@export var item_name : String = ""
@export var item_slot_type : ItemSlotType = ItemSlotType.NONE
@export var item_atk_power : int = 0
