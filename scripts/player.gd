extends RigidBody3D

var is_attacking := false
@export var idle_velocity := 1
@export var attacking_velocity := 2
@export var rotation_velocity := 5.0

@onready var player: RigidBody3D = $"."
@onready var zanzara: Node3D = $Zanzara
@onready var animation_player: AnimationPlayer = $Zanzara/AnimationPlayer
@onready var main_camera: PhantomCamera3D = $"../PhantomCamera3D"

func _input(event) -> void:
	if event.is_action_pressed("move_forward_controller"):
		attack(true, true)
	if event.is_action_pressed("move_forward"):
		attack(true, false)
	if event.is_action_released("move_forward_controller"):
		attack(false, true)
	if event.is_action_released("move_forward"):
		attack(false, false)

func attack(attack: bool, vibrate: bool) -> void:
	if attack:
		is_attacking = true
		animation_player.play("Mosquito_Attack")
		if vibrate:
			Input.start_joy_vibration(0, 0.5, 0, 0.2)
	else:
		is_attacking = false
		animation_player.play("Mosquito_Idle")
		if vibrate:
			Input.stop_joy_vibration(0)
	
func _physics_process(delta: float) -> void:
	#var input := zanzara.global_position
	#input.x = Input.get_axis("move_right", "move_left")
	#input.y = Input.get_axis("move_down", "move_up")
	var velocity = 1200.0 * delta
	if is_attacking:
		velocity *= attacking_velocity
	else:
		velocity *= idle_velocity
	
	#var forward: Vector3 = self.transform.looking_at() #get_global_transform().basis #Vector3.BACK
	var forward: Vector3 = Vector3.BACK
	self.apply_force(forward * velocity, Vector3.ZERO)
	#var move = global_transform.basis * Vector3(0, 0, -velocity)
	#var move = global_transform.origin * velocity
	#move_and_collide(move * 1200.0 * delta)
	#apply_central_force(velocity * 1200.0 * delta)
	
	# Rotate horizontally
	var y_rotation = Input.get_axis("move_right", "move_left")
	rotate_y(y_rotation * rotation_velocity * delta)
	#main_camera.rotation_degrees.y = 180 + player.rotation_degrees.y
	
	# Rotate vertically
	var x_rotation = Input.get_axis("move_down", "move_up")
	if (zanzara.rotation_degrees.x > -30 and x_rotation < 0) or (zanzara.rotation_degrees.x < 30 and x_rotation > 0):
		zanzara.rotate_x(x_rotation * rotation_velocity * delta)
		zanzara.rotation_degrees.x = clamp(zanzara.rotation_degrees.x, -30, 30)
