extends Area3D

signal rat_in_house

var alredy_entered = false

func _on_body_entered(body: Node3D) -> void:
	print(body.name + " entered rat house")
	if alredy_entered == true:
		return
	if body.name == "rat":
		alredy_entered = true
		rat_in_house.emit()
		print("Rat house emitted")
