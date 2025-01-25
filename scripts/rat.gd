extends Node3D

@export var idle_speed := float(5.0)
@export var run_speed := float(15.0)
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player: CharacterBody3D = %Player
var follow_player = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_speed() -> float:
	if follow_player:
		return run_speed
	else:
		return idle_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Move forward
	position += (global_transform.basis * Vector3.BACK).normalized() * delta * get_speed()

func _on_area_3d_body_entered(body: Node3D) -> void:
	print("Rat collided " + body.name)
	if body.name == "Player" and body.current_power_up == BubbleType.PowerType.SHIT:
		print("Rat new follower")
	follow_player = true
	animation_player.play("Rat_Run")

func _on_area_3d_body_exited(body: Node3D) -> void:
	print("Rat lost as follower")
	follow_player = false
	animation_player.play("Rat_Walk")
