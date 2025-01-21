extends RigidBody3D

var is_attacking := false
@export var idle_velocity := 500
@export var attacking_velocity := 1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event) -> void:
	if event.is_action_pressed("move_forward"):
		is_attacking = true
	if event.is_action_released("move_forward"):
		is_attacking = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input := Vector3.ZERO
	input.x = Input.get_axis("move_left", "move_right")
	input.y = Input.get_axis("move_up", "move_down")
	if is_attacking:
		input.z = attacking_velocity
	else:
		input.z = idle_velocity
	apply_central_force(input * 1200.0 * delta)
