extends Node
# Autoload: ItemData

var content : Dictionary
var item_database_resource : ItemResourceDatabase


func _ready():
	item_database_resource = load("res://resources/main_item_database.tres")
	#var file = FileAccess.open("res://Autoload/database.json",FileAccess.READ)
 
	content = item_database_resource.item_resource_dictionary #JSON.parse_string(file.get_as_text())
 
	#file.close()

func get_texture(ID : int = 0) -> Texture2D:
	return (content[ID] as ItemResource).item_texture
 
func get_ATK(ID : int = 0):
	return (content[ID] as ItemResource).item_atk_power
 
func get_slot_type(ID : int = 0):
	return (content[ID] as ItemResource).item_slot_type
