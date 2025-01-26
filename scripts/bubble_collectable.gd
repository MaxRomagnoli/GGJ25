extends Area3D

@export var game_manager: Node3D

@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var timer: Timer = $Timer
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var mesh: MeshInstance3D = $BOLLA

var bubbles : int = 0

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		audio.play()
		timer.start()
		collision_shape_3d.queue_free()
		mesh.queue_free()
		game_manager.add_bubble_score()
	
func _on_timer_timeout() -> void:
	queue_free()
