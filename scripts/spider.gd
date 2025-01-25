extends Area3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var web: MeshInstance3D = $web
@onready var sfx: AudioStreamPlayer = $AudioStreamPlayer
@onready var audio_death: AudioStreamPlayer = $AudioStreamPlayerDeath

func die() -> void:
	collision_shape_3d.disabled = true
	web.queue_free()
	animation_player.play("Spider_Death")
	rotation = Vector3.ZERO
	audio_death.play()

func _on_body_entered(body: Node3D) -> void:
	animation_player.play("Spider_Attack")
	body.position = self.position - (Vector3.UP * 3)
	body.die()
	sfx.play()
