extends Control

@onready var image = $ComicImage
@onready var text = $ComicText

var pages = [
	{
		"image": preload("res://assets/curated/jetpack cat overwatch.webp"),
		"text": "Page1"
	},
	{
		"image": preload("res://assets/curated/jetpackCat2.jpeg"),
		"text": "Page2"
	},
	{
		"image": preload("res://assets/curated/jetpackCat3.jpeg"),
		"text": "Page3"
	},
	{
		"image": preload("res://assets/curated/jetpackCat4.jpeg"),
		"text": "Page4"
	},
	{
		"image": preload("res://assets/curated/jetpackCat5.jpeg"),
		"text": "Page5"
	},
	{
		"image": preload("res://assets/curated/jetpackCat.jpeg"),
		"text": "Page6"
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
