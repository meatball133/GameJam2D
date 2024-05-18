extends Area2D

const time_range = 0.1
const health_goal = 4

var textures = [
	load("res://textures/Leaf-hp0-gamejam.svg"),
	load("res://textures/Leaf-hp1-gamejam.svg"),
	load("res://textures/Leaf-hp2-gamejam.svg"),
	load("res://textures/Leaf-hp3-gamejam.svg"),
	load("res://textures/Leaf-hp4-gamejam.svg")
	]

@onready var music = %Music
@onready var material_leaf = $Sprite2D.material

var health = 0

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("beat") and health < health_goal:
		self.on_click()

func on_click():
	if abs(music.distance_to_beat()) < time_range:
		health += 1
		#TODO! N¨ågon effekt som visar att du gjorde rätt, typ partiklar, ljud effekt osv.
	else:
		health = 0
		#TODO! Lägg till något som tydligt visar att du missade takten

	material_leaf.set_shader_parameter("leaf", textures[health])

	if health >= health_goal:
		#TODO! Gör någon ljud effekt och partiklar eller något
		pass
