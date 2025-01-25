extends Node3D

var speed = 50.0
var is_shrinking = false
var shrink_time = 0.5 # Seconds
var shrink_to_reduce: float

func _init() -> void:
	if shrink_time > 0:
		shrink_to_reduce = scale.x / shrink_time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# If is shrinking, reduce until disappear
	if is_shrinking:
		scale -= Vector3.ONE * shrink_to_reduce * delta
		# print(scale)
		if scale.x <= 0:
			queue_free() # Destroy
	
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

func _on_timer_timeout() -> void:
	is_shrinking = true

func _on_body_entered(body: Node3D) -> void:
	# print("Colpito " + body.name)
	if body.name == "Player" or body.name == "Spider":
		body.die()
	queue_free()
