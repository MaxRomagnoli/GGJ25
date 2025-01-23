extends Node3D

@export var spawn_time: Vector2 = Vector2(0.1, 1.0)
@export var spawn_area: Vector2 = Vector2(2.5, 2.0)
@export var spawn_scale: Vector2 = Vector2(0.5, 2.0)
var current_spawn_time: float

var bubble = preload("res://scenes/bubble.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn()
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
	child.scale = Vector3(scale_random, scale_random, scale_random)
	add_child(child)
