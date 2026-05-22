extends Control

@onready var image = $ComicImage
@onready var text = $ComicText

var pages = [
	{
		"image": preload("res://assets/backstory/backstory1.png"),
		"text": "Around seven years ago, there was a senior cat named Senior munch who used to own a local legend called Munchie's."
	},
	{
		"image": preload("res://assets/backstory/backstory 4.png"),
		"text": "There were complaints about a juvenile kitten that roamed around the area, 
		it's said that the locals usually fed it scraps and leftovers.. and that's why
		 it was always lurking around there. It would be loud, 
		it would steal food and it would just be annoying to all the other customers trying to dine."
	},
	{
		"image": preload("res://assets/backstory/backstory 5.png"),
		"text": "Senior Munch was getting old though, so he had a wild idea to take the kitty in and
		 named it after a childhood nickname.. Munchie. His whole idea was to 
		pass down his work to someone he could trust, but of course - he had 
		nobody. In a desperate attempt to not have all of his progress go to waste, he taught little Munchie the ways of the kitchen. "
	},
	{
		"image": preload("res://assets/backstory/backstory2.png"),
		"text": "There was an odd door where Senior Munch slept. Senior Munch  claimed that it was just a regular basement, 
		but still urged Munchie not to go in there. There was a certain vibe to it that made it.. 
		unapproachable anyway."
	},
	{
		"image": preload("res://assets/backstory/backstory3.png"),
		"text": "The last time Senior Munch was ever seen, was two 
		years ago in May nearby this mysterious door. It was since then, 
		that they started going against their mentor's wishes, and explored 
		the basement tirelessly for years just to find Senior Munch. Since then,
		 they finally understood how and where Senior Munch got his ingredients from."
	},
	{
	}
]

var current_index = 0

func _ready():
	update_page()

func update_page():
	image.texture = pages[current_index]["image"]
	text.text = pages[current_index]["text"]


func _on_next_button_pressed() -> void:
	current_index += 1

	if current_index >= pages.size():
		get_tree().change_scene_to_file("res://title_screen.tscn")
	else:
		update_page()
	
