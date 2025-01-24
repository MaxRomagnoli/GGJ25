class_name BubbleType

enum PowerType { NONE, FIRE, SHIT, POISON, SPEED }

static func get_color(selected_power_type: PowerType) -> Color:
	if selected_power_type == PowerType.FIRE:
		return Color.RED
	elif selected_power_type == PowerType.SHIT:
		return Color.SADDLE_BROWN
	elif selected_power_type == PowerType.POISON:
		return Color.GREEN
	elif selected_power_type == PowerType.SPEED:
		return Color.BLUE
	else:
		return Color.WHITE

static func get_material(selected_power_type: PowerType) -> Material:
	#if selected_power_type == PowerType.FIRE:
		#return Color.RED
	#if selected_power_type == PowerType.SHIT:
		#return Color.SADDLE_BROWN
	if selected_power_type == PowerType.POISON:
		return load("res://materials/bubble_poison.tres")
	elif selected_power_type == PowerType.SPEED:
		return load("res://materials/bubble_speed.tres")
	else:
		return load("res://materials/bubble.tres")
