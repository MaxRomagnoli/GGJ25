extends Area3D

@onready var timer: Timer = $Timer
@onready var mesh: MeshInstance3D = $MeshInstance3D

var current_speed: float
var current_power_up_time: float
var bubble_type: BubbleType.PowerType
var material: Material

func _ready() -> void:
	material = mesh.get_active_material(0)

func start(speed:float, wait_time:float, scale_random:Vector3, power_up_time:float, new_bubble_type: BubbleType.PowerType) -> void:
	current_speed = speed
	current_power_up_time = power_up_time
	timer.wait_time = wait_time
	self.scale = scale_random
	bubble_type = new_bubble_type
	material.albedo_color = BubbleType.get_color(new_bubble_type)
	mesh.set_surface_override_material(0, material)
	timer.start()

func _process(delta: float) -> void:
	position.y += current_speed * delta

func _on_body_entered(body: Node3D) -> void:
	body.set_power_up(bubble_type, current_power_up_time) 
	queue_free() # Delete

func _on_timer_timeout() -> void:
	print("pop")
	queue_free() # Delete
