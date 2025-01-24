extends Node3D

@onready var player: CharacterBody3D = %Player
@onready var main_camera: PhantomCamera3D = $PhantomCamera3D
@onready var menu_camera: PhantomCamera3D = $PhantomCamera3DMenu
@onready var books_animation: AnimationPlayer = $Libri/AnimationPlayer

func start_game() -> void:
	main_camera.priority = 1
	menu_camera.priority = 0
	player.start()

func fall_animation(body: Node3D) -> void:
	# print("fall animation")
	if player.current_power_up == BubbleType.PowerType.SPEED:
		books_animation.play("caduta_libri")
