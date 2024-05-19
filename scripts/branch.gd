extends StaticBody2D

@export var leaves = 3
@onready var music = %Music

const db_diff = 8

@onready var db = music.volume_db

func leaf_momento():
	leaves -= 1
	
	if leaves <= 0:
		db = music.volume_db
		music.volume_db -= db_diff
		$AudioStreamPlayer2D.play()
		#$CPUParticles2D.emitting = true
		$Timer.start()
		$Sprite2D.texture = preload("res://textures/branch_1.png")

func _on_timer_timeout() -> void:
	music.volume_db = db
