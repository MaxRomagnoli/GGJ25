extends Node3D

@export var fire_time := Vector2(2.0, 5.0)
@export var agro_range := float(7000.0) # meters
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
	
	var direction: Vector3 = (self.position - player.position) #.normalized()
	print(direction.length_squared())
	if direction.length_squared() > agro_range:
		return
	
	# TODO Fire sound
	
	print("FIRE")
	var child = saetta.instantiate()
	add_child(child)
	child.look_at(player.position)
