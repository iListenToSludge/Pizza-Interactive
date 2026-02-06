extends Control

@onready var atk: Label = %ATK

func calculate():
	var sum = 0
 
	for i in get_children():
		sum += i.get_ATK()
 
	atk.text = str(sum)

 
