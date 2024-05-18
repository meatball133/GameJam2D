extends Area2D

const time_range = 0.1
const health_goal = 4

var textures = [
	preload("res://textures/Leaf-hp0-gamejam.svg"),
	preload("res://textures/Leaf-hp1-gamejam.svg"),
	preload("res://textures/Leaf-hp2-gamejam.svg"),
	preload("res://textures/Leaf-hp3-gamejam.svg"),
	preload("res://textures/Leaf-hp4-gamejam.svg")
	]

@onready var material_leaf = $Sprite2D.material
@onready var sprite = $Sprite2D
@onready var on_time = $ParticlesOnTime
@onready var off_time = $ParticlesOffTime
@onready var completed_time = $ParticlesComplete
@onready var sound_effect_click = $AudioStreamPlayer2D

var health = 0

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("beat") and health < health_goal:
		self.on_click()

func on_click():
	if abs(get_parent().distance_to_beat()) < time_range:
		health += 1
		# particles and sound effect
		on_time.emitting = true
		sound_effect_click.playing = true
	else:
		health = 0
		# fail particles
		off_time.emitting = true

	sprite.texture = textures[health]

	if health >= health_goal:
		# completed particles
		completed_time.emitting = true
		#$CompletionSound.play()
		get_parent().leaf_momento()
