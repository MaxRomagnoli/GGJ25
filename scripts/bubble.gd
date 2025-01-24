extends Area3D

@onready var mesh: MeshInstance3D = $MeshInstance3D

var current_speed: float
var current_power_up_time: float
var bubble_type: BubbleType.PowerType
var shrink_time = 0.5

func start(speed:float, scale_random:Vector3, power_up_time:float, new_bubble_type: BubbleType.PowerType) -> void:
	current_speed = speed
	current_power_up_time = power_up_time
	self.scale = scale_random
	bubble_type = new_bubble_type
	#var new_material = mesh.get_active_material(0)
	#new_material.albedo_color = BubbleType.get_color(new_bubble_type)
	mesh.set_surface_override_material(0, BubbleType.get_material(new_bubble_type))
	#mesh.set_surface_override_material(0, new_material)
	#mesh.mat(0, new_material)

func _process(delta: float) -> void:
	position.y += current_speed * delta
	self.scale -= Vector3.ONE * shrink_time * delta
	if self.scale.x <= 0:
		queue_free() # Delete

func _on_body_entered(body: Node3D) -> void:
	body.set_power_up(bubble_type, current_power_up_time) 
	queue_free() # Delete
