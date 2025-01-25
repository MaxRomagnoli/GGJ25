extends Control

@onready var start_button: Button = $VBoxContainer/StartButton
@onready var back_button: Button = $VBoxContainer2/BackButton
@onready var back_button_2: Button = $VBoxContainer3/BackButton
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var v_box_container_2: VBoxContainer = $VBoxContainer2
@onready var v_box_container_3: VBoxContainer = $VBoxContainer3

signal game_start

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_back_button_button_up()

func set_focus_on_start() ->void:
	_on_back_button_button_up()

func _on_start_button_button_up() -> void:
	game_start.emit()

func _on_options_button_button_up() -> void:
	v_box_container.visible = false
	v_box_container_2.visible = true
	back_button.grab_focus()

func _on_credits_button_button_up() -> void:
	v_box_container.visible = false
	v_box_container_3.visible = true
	back_button_2.grab_focus()

func _on_quit_button_button_up() -> void:
	get_tree().quit()

func _on_back_button_button_up() -> void:
	v_box_container.visible = true
	v_box_container_2.visible = false
	v_box_container_3.visible = false
	start_button.grab_focus()
