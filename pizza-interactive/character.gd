extends CharacterBody2D

var max_speed := 600.0
var health = 100
var max_health = 100
func _ready():
	$ProgressBar.value = health

func take_damage(amount):
	health -= amount
	$ProgressBar.value = health
	print("Player health: ", health)
	
	if health <= 0:
		die()
func die():
	print("Player has died!")
	

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move left", "move right", "move up", "move down")
	velocity = direction * max_speed
	move_and_slide()
