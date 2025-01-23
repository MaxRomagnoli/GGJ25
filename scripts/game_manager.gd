extends Node3D

@onready var player: CharacterBody3D = %Player
@onready var main_camera: PhantomCamera3D = $PhantomCamera3D
@onready var menu_camera: PhantomCamera3D = $PhantomCamera3DMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_game() -> void:
	main_camera.priority = 1
	menu_camera.priority = 0
	player.start()
