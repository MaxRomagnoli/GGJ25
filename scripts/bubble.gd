extends Area3D

@onready var timer: Timer = $Timer

@export var pop_time: Vector2 = Vector2(5.0, 10.0)
@export var speed_range: Vector2 = Vector2(1.0, 3.0)
var current_speed

func _ready() -> void:
	current_speed = randf_range(speed_range.x, speed_range.y)
	timer.wait_time = randf_range(pop_time.x, pop_time.y)
	timer.start()

func _process(delta: float) -> void:
	position.y += current_speed * delta

func _on_body_entered(body: Node3D) -> void:
	print("pop")
	queue_free() # Delete

func _on_timer_timeout() -> void:
	print("pop")
	queue_free() # Delete
