extends Area3D

@onready var timer: Timer = $Timer

func _on_body_entered(body) -> void:
	body.die()
