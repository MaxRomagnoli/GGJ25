extends Node3D

@onready var player: CharacterBody3D = %Player
@onready var main_camera: PhantomCamera3D = $PhantomCamera3D
@onready var menu_camera: PhantomCamera3D = $PhantomCamera3DMenu
@onready var caduta_libri_camera: PhantomCamera3D = $PhantomCamera3DCadutaLibri
@onready var books_animation: AnimationPlayer = $Libri/AnimationPlayer
@onready var trigger_books_animation: Area3D = $Libri/Area3D
@onready var ammazzazanzare: Node3D = $Libri/Ammazzazanzare

func start_game() -> void:
	main_camera.priority = 1
	menu_camera.priority = 0
	caduta_libri_camera.priority = 0
	player.start()

func fall_animation(body: Node3D) -> void:
	if player.current_power_up == BubbleType.PowerType.SPEED:
		player.set_power_up(BubbleType.PowerType.NONE, 0)
		player.wait()
		ammazzazanzare.in_animation = true
		menu_camera.priority = 0
		main_camera.priority = 0
		caduta_libri_camera.priority = 1
		trigger_books_animation.queue_free()
		books_animation.play("caduta_libri")
