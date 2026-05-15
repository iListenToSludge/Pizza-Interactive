extends PanelContainer


var item : ItemResource = null:
	set(value):
		item = value

		if value != null:
			$TextureRect.texture = value.item_texture
		else:
			$TextureRect.texture = null

func enable(value = true):
	$Panel.show_behind_parent = value
	return value

func check():
	var inventory = get_tree().current_scene.find_child("Inventory")

	if item != null:
		return enable(inventory.is_available(item))

	return enable(false)
