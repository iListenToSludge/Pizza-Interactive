extends CharacterBody2D

var last_direction: Vector2 = Vector2.RIGHT

const SPEED = 300.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
#variables
#------------------------------

func _physics_process(_delta: float) -> void:
	process_movement() 
	move_and_slide()
	
	
#------------------------------------
# MOVEMENT ANIMATION v
#------------------------------------
func process_movement() -> void:
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left", "right", "up", "down")

	if direction !=  Vector2.ZERO:
		velocity = direction * SPEED
		last_direction = direction
	else:
		velocity = Vector2.ZERO
	
	process_animation(last_direction)

func process_animation(direction) -> void:
	if velocity != Vector2.ZERO:
		play_animation("walking", direction)
	else:
		play_animation("idle", direction)
func play_animation(prefix: String, dir: Vector2) -> void:
	if dir.x != 0:
		animated_sprite_2d.flip_h = dir.x > 0
		animated_sprite_2d.play(prefix + "_left")
	elif dir.y < 0:
		animated_sprite_2d.play(prefix + "_back")
	elif dir.y > 0:
		animated_sprite_2d.play(prefix + "_front")
#----------------------------------------
#MOVEMENT ANIMATION ^
#----------------------------------------
