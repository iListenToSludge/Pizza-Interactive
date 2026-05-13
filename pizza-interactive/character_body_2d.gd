extends CharacterBody2D

@export var speed = 30
@export var limit = 0.5 
@export var endPoint: Marker2D

@onready var animations = $AnimatedSprite2D

var startPosition
var endPosition

func _ready():
	startPosition = position
	endPosition = endPoint.global_position

func changeDireciton():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd


func updateVelocity():
	var moveDirection = endPosition - position
	if moveDirection.length() < limit: 
		changeDireciton()
		
	velocity = moveDirection.normalized()*speed
	

func updateAnimation():
	var animationString = "enemy_w"
	if velocity.y > 0:
		animationString = "enemy_s"
		
	animations.play(animationString)

func _physics_process(_delta):
	updateVelocity()
	move_and_slide() 
	updateAnimation()
