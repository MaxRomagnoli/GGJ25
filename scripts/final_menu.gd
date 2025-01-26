extends Control

@onready var back_button: Button = $VBoxContainer3/BackButton

"""func _set(property: StringName, value: Variant) -> bool:
	if property == "visible" and value == true:
		back_button.grab_focus()
	return true"""

func reload_game() -> void:
	get_tree().reload_current_scene()

func _on_quit_button_button_up() -> void:
	get_tree().quit()
