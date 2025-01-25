extends CharacterBody3D

enum PlayerState { WAIT, PLAY, PAUSE, DEATH, WIN }

@export var idle_velocity := 5.0
@export var attacking_velocity := 15.0
@export var superspeed_velocity := 35.0
@export var rotation_velocity := 5.0
@export var vertical_velocity := 15.0
@export var player_shake_force := Vector2(-5, 5) # meters
@export var player_shake_frequency := Vector2(0.5, 5) # seconds

@onready var zanzara: Node3D = $Zanzara
@onready var mesh: MeshInstance3D = $Zanzara/Mosquito_Rig/Skeleton3D/Mosquito
@onready var animation_player: AnimationPlayer = $Zanzara/AnimationPlayer
#@onready var main_camera: PhantomCamera3D = $"../PhantomCamera3D"
@onready var camera_target: Node3D = $CameraTarget
@onready var death_timer: Timer = $Timer
@onready var audio_death: AudioStreamPlayer = $AudioDeath
@onready var menu: Control = $"../Menu"

var current_player_shake_frequency := 0.0
var current_player_state = PlayerState.WAIT
var is_attacking := false
var material: Material
var current_power_up: BubbleType.PowerType = BubbleType.PowerType.NONE
var current_power_up_time: float
var player_input: Vector2

func _ready() -> void:
	material = mesh.get_active_material(0)

func start() -> void:
	menu.visible = false
	Engine.time_scale = 1.0
	current_player_state = PlayerState.PLAY

func wait() -> void:
	current_player_state = PlayerState.WAIT

func pause() -> void:
	menu.visible = true
	menu.set_focus_on_start()
	Engine.time_scale = 0.0
	current_player_state = PlayerState.PAUSE

func die() -> void:
	
	# Non infierire
	if current_player_state == PlayerState.DEATH:
		return
	
	current_player_state = PlayerState.DEATH
	animation_player.play("Mosquito_Shock" + str(randi_range(1, 3)))
	set_power_up(BubbleType.PowerType.NONE, 0) # reset power up
	audio_death.play()
	death_timer.start()

func _on_death_timer_timeout() -> void:
	get_tree().reload_current_scene()

func _process(delta: float) -> void:
	
	# Do nothing if player is waiting
	if current_player_state != PlayerState.PLAY:
		return
	
	if current_power_up != BubbleType.PowerType.NONE:
		current_power_up_time -= delta
		
		# Reset power up
		if current_power_up_time <= 0:
			set_power_up(BubbleType.PowerType.NONE, 0)

func _input(event) -> void:
	
	if event.is_action_pressed("toogle_pause"):
		if current_player_state == PlayerState.PAUSE:
			start()
		else:
			pause()
	
	# Do nothing if player is waiting
	if current_player_state != PlayerState.PLAY:
		return
	
	player_input = Vector2(
		Input.get_axis("move_right", "move_left"),
		Input.get_axis("move_down", "move_up")
	)
	
	animate()
	
	if event.is_action_pressed("move_forward_controller"):
		attack(true, true)
	if event.is_action_pressed("move_forward"):
		attack(true, false)
	if event.is_action_released("move_forward_controller"):
		attack(false, true)
	if event.is_action_released("move_forward"):
		attack(false, false)

func attack(attacking: bool, vibrate: bool) -> void:
	if attacking:
		is_attacking = true
		if vibrate:
			Input.start_joy_vibration(0, 0.5, 0, 0.2)
	else:
		is_attacking = false
		if vibrate:
			Input.stop_joy_vibration(0)

func set_power_up(power_up: BubbleType.PowerType, power_up_time: float) -> void:
	current_power_up = power_up
	current_power_up_time = power_up_time
	material.albedo_color = BubbleType.get_color(power_up)
	mesh.set_surface_override_material(0, material)

func get_forward_velocity() -> float:
	if is_attacking:
		if current_power_up == BubbleType.PowerType.SPEED:
			return superspeed_velocity
		return attacking_velocity
	else:
		return idle_velocity

func _physics_process(delta: float) -> void:
	
	# Do nothing if player is waiting
	if current_player_state != PlayerState.PLAY:
		return
	
	# Rotate horizontally
	var y_rotation = player_input.x
	rotate_y(y_rotation * rotation_velocity * delta)
	
	# Move vertically
	var vertical_movement = player_input.y * delta * vertical_velocity
	
	var forward: Vector3 = global_transform.basis * Vector3(
		0,
		vertical_movement,
		delta * get_forward_velocity()
	)
	move_and_collide(forward)

func animate() -> void:
	# Animation
	if is_attacking:
		animation_player.play("Mosquito_Attack_Loop")
		camera_target.position = Vector3(0.0, 3.0, -3.0)
	elif player_input.x > 0:
		animation_player.play("Mosquito_FlyRight_Loop")
		camera_target.position = Vector3(0.0, 3.0, -4.0)
	elif player_input.x < 0:
		animation_player.play("Mosquito_FlyLeft_Loop")
		camera_target.position = Vector3(0.0, 3.0, -4.0)
	elif player_input.y > 0:
		animation_player.play("Mosquito_Backward")
		camera_target.position = Vector3(0.0, 1.0, -4.0)
	elif player_input.y < 0:
		animation_player.play("Mosquito_Forward")
		camera_target.position = Vector3(0.0, 5.0, -4.0)
	else:
		animation_player.play("Mosquito_Idle")
		camera_target.position = Vector3(0.0, 3.0, -4.0)
