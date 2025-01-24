extends Area3D

signal destroy_killzone

@export var vulnerability := BubbleType.PowerType.NONE
@onready var timer: Timer = $Timer

func _on_body_entered(body) -> void:
	if vulnerability != BubbleType.PowerType.NONE and body.current_power_up == vulnerability:
		destroy_killzone.emit()
	else:
		body.die()
