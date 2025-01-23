extends Node3D

@export var spawner_type := BubbleType.PowerType.FIRE
@export var power_up_time := float(5.0)
@export var spawn_time := Vector2(0.01, 0.5)
@export var spawn_area := Vector2(1.0, 1.0)
@export var spawn_scale := Vector2(2.0, 3.0)
@export var speed_range := Vector2(0.5, 2.0)

var current_spawn_time: float

var bubble = preload("res://scenes/bubble.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setNewSpawnTime()

func setNewSpawnTime() -> void:
	current_spawn_time = randf_range(spawn_time.x, spawn_time.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_spawn_time -= delta
	if current_spawn_time <= 0:
		spawn()
		setNewSpawnTime()

func spawn() -> void:
	var child = bubble.instantiate()
	child.position += Vector3(
		randf_range(-spawn_area.x, spawn_area.x),
		0,
		randf_range(-spawn_area.y, spawn_area.y)
	)
	var scale_random = randf_range(spawn_scale.x, spawn_scale.y)
	var speed = randf_range(speed_range.x, speed_range.y)
	add_child(child)
	child.start(speed, Vector3.ONE * scale_random, power_up_time, spawner_type)
