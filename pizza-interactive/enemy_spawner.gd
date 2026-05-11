extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_interval := 2.0
@export var max_kills := 5
@export var max_active := 3
var active_enemies := 0
var kills := 0

@onready var timer := Timer.new()

func _ready():
	add_child(timer)
	timer.wait_time = spawn_interval
	timer.timeout.connect(_spawn_enemy)
	timer.start()

func _spawn_enemy():
	if active_enemies >= max_active:
		return

	var enemy = enemy_scene.instantiate()
	get_parent().add_child(enemy)
	enemy.global_position = global_position

	active_enemies += 1
	enemy.died.connect(_on_enemy_died)

func _on_enemy_died():
	kills += 1
	active_enemies -= 1

	if kills >= max_kills:
		queue_free()
