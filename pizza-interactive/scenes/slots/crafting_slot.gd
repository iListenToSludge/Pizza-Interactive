extends Node
class_name CraftingSlot

@export var item_resource : ItemResource = null


func read_from_other_slot(slot : Slot):
	self.item_resource = slot.item_resource


func craft():
	return
