extends Node

var count = 4

func leffe_moment():
	count -= 1
	
	if count == 0:
		%Tree.texture = preload("res://textures/tree.png")
		get_node("/root/Main/Camera2D").end()
