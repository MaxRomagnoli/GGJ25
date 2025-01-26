extends Node3D

@onready var player: CharacterBody3D = %Player

# Cameras
@onready var main_camera: PhantomCamera3D = $PhantomCamera3D
@onready var menu_camera: PhantomCamera3D = $PhantomCamera3DMenu
@onready var caduta_libri_camera: PhantomCamera3D = $PhantomCamera3DCadutaLibri
@onready var rat_camera: PhantomCamera3D = $PhantomCamera3DRat
@onready var game_over_camera: PhantomCamera3D = $PhantomCamera3DFinal
@onready var rat_camera_timer: Timer = $PhantomCamera3DRat/Timer

@onready var books_animation: AnimationPlayer = $Libri/AnimationPlayer
@onready var trigger_books_animation: Area3D = $Libri/Area3D
@onready var ammazzazanzare: Node3D = $Libri/Ammazzazanzare
@onready var menu_game_over: Control = $Menu_Game_Over

@onready var audio_libri: AudioStreamPlayer = $AudioStreamPlayerLibri
@onready var audio_agony: AudioStreamPlayer = $AudioStreamPlayerAgony
@onready var label_bubbles: Label = %LabelBubbles

var is_rat_in_house = false
var is_game_over = false
var bubbles : int = 0

func add_bubble_score() -> void:
	bubbles += 1
	label_bubbles.text = "BUBBLES → " + str(bubbles)

func start_game() -> void:
	
	if is_game_over:
		return
	
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
	trigger_books_animation.queue_free() # Remove area for trigger again
	books_animation.play("caduta_libri")
	
	menu_camera.priority = 0
	main_camera.priority = 0
	caduta_libri_camera.priority = 1
	rat_camera.priority = 0
	game_over_camera.priority = 0

func rat_animation() -> void:
	player.set_power_up(BubbleType.PowerType.NONE, 0)
	player.wait()
	rat_camera_timer.start()
	
	menu_camera.priority = 0
	main_camera.priority = 0
	caduta_libri_camera.priority = 0
	rat_camera.priority = 1
	game_over_camera.priority = 0

func rat_animation_timeout() -> void:
	is_rat_in_house = true
	start_game()

func game_over() -> void:
	
	if not is_rat_in_house:
		return
	
	if is_game_over:
		return
	else:
		is_game_over = true
	
	audio_agony.play()
	player.set_power_up(BubbleType.PowerType.NONE, 0)
	player.wait()
	menu_game_over.visible = true
	
	menu_camera.priority = 0
	main_camera.priority = 0
	caduta_libri_camera.priority = 0
	rat_camera.priority = 0
	game_over_camera.priority = 1
