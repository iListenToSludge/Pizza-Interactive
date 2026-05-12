extends CharacterBody2D

const speed = 30 
var current_state = IDLE

var dir = Vector2.RIGHT
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
		$AnimatedSprite2D.play("npcfront_idle")
	elif current_state == 2 and !is_chatting:
		if dir.x == -1:
			$AnimatedSprite2D.play("npcright_walk")
		if dir.x == 1:
			$AnimatedSprite2D.play("npcright_walk")
		if dir.y == -1:
			$AnimatedSprite2D.play("npcfront_walk")
		if dir.y == 1:
			$AnimatedSprite2D.play("npcback_walk")
			
	
		if is_roaming:
			match current_state:
				IDLE:
					pass
				NEW_DIR:
					dir = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN])
				MOVE:
					move(_delta)

func choose(array):
	array.shuffle()
	return array.front()

func move(delta):
	if not !is_chatting:
		position += dir * speed * delta


func _on_chat_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player = body
		player_in_chat_zone = true


func _on_chat_detection_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_chat_zone = false

func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])
