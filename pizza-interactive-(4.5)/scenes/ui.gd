extends Control
class_name RootUIControl
## This controls the visibility of the inventory screen.


func _input(event):
	if event.is_action_pressed("inventory"):
		self.visible = !self.visible
