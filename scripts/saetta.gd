extends Node3D

@onready var player: CharacterBody3D = %Player
var speed = 30.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Move forward
	position += (global_transform.basis * Vector3.FORWARD).normalized() * delta * speed
	
	#var look_at_angle = global_transform.looking_at(player.position, Vector3.UP)
	#rotation = lerp(rotation, look_at_angle.position, 1.0)
	
	#rotation = lerp_angle(rotation, (rotation - player.global_position).normalized().angle(), weight)
	
	# Rotate targeting the player
	#var old = transform.basis
	#look_at(player.position)
	#var new = transform.basis
	#transform.basis = lerp(old, new, .1)
