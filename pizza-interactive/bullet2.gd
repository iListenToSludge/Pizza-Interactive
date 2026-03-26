extends Area2D

@export var speed = 1200
var direction = Vector2.ZERO

func _physics_process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(10,global_position)
	queue_free()


func _on_area_entered(area):
	queue_free()
func _ready():
	await get_tree().create_timer(2).timeout
	queue_free()
