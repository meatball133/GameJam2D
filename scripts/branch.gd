extends StaticBody2D

@export var leaves = 3
@onready var music = %Music

func distance_to_beat():
	return music.distance_to_beat()

func leaf_momento():
	leaves -= 1
	
	if leaves <= 0:
		$Sprite2D.texture = preload("res://textures/branch_1.png")
		print("Yippi")
