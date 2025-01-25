extends StaticBody3D

@export var variant := int(1)
@onready var libro_1: Node = $LIBRO_1
@onready var libro_2: Node = $LIBRO_2
@onready var libro_3: Node = $LIBRO_3
@onready var libro_4: Node = $LIBRO_4
@onready var libro_5: Node = $LIBRO_5
@onready var libro_6: Node = $LIBRO_6

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_libro_active(variant)

func set_libro_active(libro: int) -> void:
	if libro != 1:
		libro_1.queue_free()
	if libro != 2:
		libro_2.queue_free()
	if libro != 3:
		libro_3.queue_free()
	if libro != 4:
		libro_4.queue_free()
	if libro != 5:
		libro_5.queue_free()
	if libro != 6:
		libro_6.queue_free()
