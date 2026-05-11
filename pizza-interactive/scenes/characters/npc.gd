extends CharacterBody2D

const speed = 30 
var current_state = IDLE

var direction = Vector2.RIGHT
var start_pos

var is_roaming = true
var is_chatting = false

var player
var player_in_chat_zone = false
 

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

func ready_():
	randomize()
	start_pos = position 

func _process(_delta):
	if current_state == 0  or current_state == 1:
		$AnimatedSprite2D.play("front_idle")
