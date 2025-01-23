extends CharacterBody3D

@export var idle_velocity := 10
@export var attacking_velocity := 15
@export var rotation_velocity := 5.0

@onready var zanzara: Node3D = $Zanzara
@onready var mesh: MeshInstance3D = $Zanzara/Mosquito_Rig/Skeleton3D/Mosquito
@onready var animation_player: AnimationPlayer = $Zanzara/AnimationPlayer
@onready var main_camera: PhantomCamera3D = $"../PhantomCamera3D"

var is_attacking := false
var mesh_zanzara = preload("res://assets/Zanzara_Mosquito_D_256-Mosquito_A_256.png")
var mesh_zanzara_red = preload("res://assets/Zanzara_Mosquito_D_256-Mosquito_A_256_red.png")

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
		if vibrate:
			Input.start_joy_vibration(0, 0.5, 0, 0.2)
	else:
		is_attacking = false
		if vibrate:
			Input.stop_joy_vibration(0)
	
func _physics_process(delta: float) -> void:
	
	var velocity = delta
	if is_attacking:
		velocity *= attacking_velocity
	else:
		velocity *= idle_velocity
	
	# Rotate horizontally
	var y_rotation = Input.get_axis("move_right", "move_left")
	rotate_y(y_rotation * rotation_velocity * delta)
	
	# Move vertically
	var vertical_movement = Input.get_axis("move_down", "move_up") * delta
	
	var forward: Vector3 = global_transform.basis * Vector3(
		0,
		vertical_movement,
		velocity
	)
	move_and_collide(forward)
	
	# Animation
	if is_attacking:
		animation_player.play("Mosquito_Attack_Loop")
		#mesh.material_override = mesh_zanzara_red # NOT WORKING
	elif y_rotation > 0:
		animation_player.play("Mosquito_FlyRight_Loop")
	elif y_rotation < 0:
		animation_player.play("Mosquito_FlyLeft_Loop")
	elif vertical_movement > 0:
		animation_player.play("Mosquito_Backward")
	elif vertical_movement < 0:
		animation_player.play("Mosquito_Forward")
	else:
		animation_player.play("Mosquito_Idle")
		#mesh.set_surface_override_material(0, mesh_zanzara) # NOT WORKING
