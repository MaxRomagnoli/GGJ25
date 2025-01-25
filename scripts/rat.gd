extends Node3D

signal rat_in_house

@export var default_item := Node
@export var idle_time := float(0.5)
@export var walk_speed := float(5.0)
@export var run_speed := float(15.0)
@export var sound_frequency := Vector2(10.0, 15.0)
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player: CharacterBody3D = %Player

const RAT_1 = preload("res://assets/music/rat/rat1.wav")
const RAT_2 = preload("res://assets/music/rat/rat2.wav")
const RAT_3 = preload("res://assets/music/rat/rat3.wav")
const RAT_4 = preload("res://assets/music/rat/rat4.wav")
const RAT_5 = preload("res://assets/music/rat/rat5.wav")

var follow_player = false
var current_idle_time : float
var current_sound_frequency : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_speed() -> float:
	if follow_player:
		return run_speed
	else:
		return walk_speed

func get_random_sound():
	var rand_int = randi_range(1, 5)
	if rand_int == 1:
		return RAT_1
	if rand_int == 2:
		return RAT_2
	if rand_int == 3:
		return RAT_3
	if rand_int == 4:
		return RAT_4
	if rand_int == 5:
		return RAT_5

func play_sound() -> void:
	current_sound_frequency = randf_range(sound_frequency.x, sound_frequency.y)
	audio_stream_player.stream = get_random_sound()
	audio_stream_player.play()

func get_target() -> Vector3:
	if follow_player:
		return Vector3(
			player.position.x,
			self.position.y,
			player.position.z
		)
	return Vector3(
		default_item.position.x,
		self.position.y,
		default_item.position.z
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	current_sound_frequency -= delta
	if current_sound_frequency <= 0:
		play_sound()
	
	# Time to idle
	if current_idle_time > 0:
		current_idle_time -= delta
		return
	
	# Get target, but if is it too close, stay
	var target = get_target()
	
	if (position - target).length_squared() <= 150.0:
		animation_player.play("Rat_Idle")
		current_idle_time = idle_time
		return
	elif follow_player:
		animation_player.play("Rat_Run")
	else:
		animation_player.play("Rat_Walk")
	
	# Rotation
	look_at(target, Vector3.UP)
	
	# Move forward
	position += (global_transform.basis * Vector3.FORWARD).normalized() * delta * get_speed()

func _on_area_3d_body_entered(body: Node3D) -> void:
	print("Rat collided " + body.name)
	if body.name == "Player": # TODO decomment and body.current_power_up == BubbleType.PowerType.SHIT:
		print("Rat new follower")
		play_sound()
		follow_player = true
	if body.name == "Rat_house":
		rat_in_house.emit()

func _on_area_3d_body_exited(body: Node3D) -> void:
	print("Rat lost as follower")
	if body.name == "Player":
		follow_player = false
