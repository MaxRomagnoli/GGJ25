extends Area3D

signal kill

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var web: MeshInstance3D = $web

func die() -> void:
	collision_shape_3d.disabled = true
	web.queue_free()
	animation_player.play("Spider_Death")
	rotation = Vector3.ZERO

func _on_body_entered(body: Node3D) -> void:
	animation_player.play("Spider_Attack")
	body.position = self.position - (Vector3.UP * 3)
	body.die()
