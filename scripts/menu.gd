extends Control

@onready var start_button: Button = $VBoxContainer/StartButton

signal game_start

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button.grab_focus()

func _on_start_button_button_up() -> void:
	game_start.emit()
	self.visible = false

func _on_options_button_button_up() -> void:
	pass # TODO

func _on_credits_button_button_up() -> void:
	pass # TODO

func _on_quit_button_button_up() -> void:
	get_tree().quit()
