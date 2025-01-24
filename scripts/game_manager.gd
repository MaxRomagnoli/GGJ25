extends Node3D

@onready var player: CharacterBody3D = %Player
@onready var main_camera: PhantomCamera3D = $PhantomCamera3D
@onready var menu_camera: PhantomCamera3D = $PhantomCamera3DMenu

func start_game() -> void:
	main_camera.priority = 1
	menu_camera.priority = 0
	player.start()
