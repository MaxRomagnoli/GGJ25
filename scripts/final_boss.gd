extends Area3D

signal game_over

@onready var animation_player: AnimationPlayer = $AnimationPlayer
#@onready var mesh: MeshInstance3D = $"Human Armature/Skeleton3D/Human_Mesh"
#var sick_mat: Material
#var normal_mat: Material

var can_die = true # TODO Need the rat

#func _init() -> void:
	#sick_mat = mesh.get_active_material(4)
	#normal_mat = Material.new()

func set_can_die(is_it: bool) -> void:
	can_die = is_it

func _on_body_entered(body: Node3D) -> void:
	if can_die:
		game_over.emit()
		animation_player.play("Die")
	else:
		animation_player.play("SleepMosquito")
	#mesh.set_surface_override_material(4, sick_mat)

func _on_body_exited(body: Node3D) -> void:
	animation_player.play("SleepOnly")
	#mesh.set_surface_override_material(4, normal_mat)
