extends Control

@onready var back_button: Button = $VBoxContainer3/BackButton

"""func _set(property: StringName, value: Variant) -> bool:
	if property == "visible" and value == true:
		back_button.grab_focus()
	return true"""

func reload_game() -> void:
	get_tree().reload_current_scene()
