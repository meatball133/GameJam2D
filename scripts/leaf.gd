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
@onready var on_time = $ParticlesOnTime
@onready var off_time = $ParticlesOffTime
@onready var completed_time = $ParticlesComplete
@onready var sound_effect_click = $AudioStreamPlayer2D

var health = 0

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("beat") and health < health_goal:
		self.on_click()

func on_click():
	if abs(music.distance_to_beat()) < time_range:
		health += 1
		# particles and sound effect
		on_time.emitting = true
		sound_effect_click.playing = true
	else:
		health = 0
		# fail particles
		off_time.emitting = true

	material_leaf.set_shader_parameter("leaf", textures[health])

	if health >= health_goal:
		# completed particles
		completed_time.emitting = true
		pass
