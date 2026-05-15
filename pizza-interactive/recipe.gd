extends HBoxContainer

@onready var cook: Button = $Cook

@export var item: ItemResource = null
@onready var recipe = item.recipe 


func _ready():
	if item == null:
		return

	cook.icon = item.item_texture

	for i in range(item.recipe.size()):
		get_child(i).item = item.recipe[i]


func check():
	var flag = []

	for i in range(item.recipe.size()):
		flag.append(get_child(i).check())

	cook.disabled = false in flag


func _on_cook_pressed() -> void:
	var inventory = get_tree().current_scene.find_child("Inventory")

	# make sure all ingredients exist
	for ingredient in item.recipe:
		if !inventory.is_available(ingredient):
			return

	# remove ingredients
	for ingredient in item.recipe:
		inventory.remove_item(ingredient)

	# add crafted item
	inventory.add_item(item)

	check()
