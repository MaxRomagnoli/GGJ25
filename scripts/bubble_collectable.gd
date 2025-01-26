extends Area3D

@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var timer: Timer = $Timer
@onready var game_manager: Node3D = $"."

func _on_body_entered(body: Node3D) -> void:
	if body.name == "PLayer":
		audio.play()
		timer.start()
		#get_root().add_bubble_score()

func _on_timer_timeout() -> void:
	queue_free()
