extends Node3D

@onready var player: CharacterBody3D = %Player

# Cameras
@onready var main_camera: PhantomCamera3D = $PhantomCamera3D
@onready var menu_camera: PhantomCamera3D = $PhantomCamera3DMenu
@onready var caduta_libri_camera: PhantomCamera3D = $PhantomCamera3DCadutaLibri
@onready var rat_camera: PhantomCamera3D = $PhantomCamera3DRat
@onready var game_over_camera: PhantomCamera3D = $PhantomCamera3DFinal

@onready var books_animation: AnimationPlayer = $Libri/AnimationPlayer
@onready var trigger_books_animation: Area3D = $Libri/Area3D
@onready var ammazzazanzare: Node3D = $Libri/Ammazzazanzare
@onready var audio_libri: AudioStreamPlayer = $AudioStreamPlayerLibri
@onready var menu_game_over: Control = $Menu_Game_Over

func start_game() -> void:
	main_camera.priority = 1
	menu_camera.priority = 0
	caduta_libri_camera.priority = 0
	rat_camera.priority = 0
	game_over_camera.priority = 0
	player.start()

func fall_animation(_body: Node3D) -> void:
	
	if player.current_power_up != BubbleType.PowerType.SPEED:
		return
	
	audio_libri.play()
	player.set_power_up(BubbleType.PowerType.NONE, 0)
	player.wait()
	ammazzazanzare.in_animation = true
	menu_camera.priority = 0
	main_camera.priority = 0
	caduta_libri_camera.priority = 1
	rat_camera.priority = 0
	game_over_camera.priority = 0
	trigger_books_animation.queue_free() # Remove area for trigger again
	books_animation.play("caduta_libri")

func rat_animation() -> void:
	print("TODO Rat animation")
	menu_camera.priority = 0
	main_camera.priority = 0
	caduta_libri_camera.priority = 0
	rat_camera.priority = 1
	game_over_camera.priority = 0

func game_over() -> void:
	player.set_power_up(BubbleType.PowerType.NONE, 0)
	player.wait()
	menu_game_over.visible = true
	menu_camera.priority = 0
	main_camera.priority = 0
	caduta_libri_camera.priority = 0
	rat_camera.priority = 0
	game_over_camera.priority = 1
