extends Node3D

@export var fire_time := Vector2(2.0, 5.0)
@onready var player: CharacterBody3D = %Player

var current_fire_time: float
var saetta = preload("res://scenes/saetta.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_fire_time -= delta
	if (current_fire_time <= 0):
		current_fire_time = randf_range(fire_time.x, fire_time.y)
		fire()

func fire() -> void:
	print("FIRE")
	var child = saetta.instantiate()
	var direction: Vector3 = (self.position - player.position).normalized()
	child.basis = Basis.looking_at(direction)
	child.position += Vector3.DOWN * 20
	add_child(child)
