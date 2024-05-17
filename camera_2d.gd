extends Camera2D

@onready var player = %Player

@export var snap_x = 500.0
@export var x_switch = 750
@export_range(0.0, 1.0) var snap_speed := 1.0
@export var dash = 100.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var x = 0.0
	if abs(player.global_position.x) < x_switch:
		x = 0.0
	elif player.global_position.x < 0:
		x = - snap_x
	else:
		x = snap_x
	
	global_position.x = lerp(global_position.x, x, snap_speed)
