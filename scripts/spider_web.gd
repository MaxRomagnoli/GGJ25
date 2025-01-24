extends Node3D

func _on_killzone_destroy_killzone() -> void:
	queue_free()
