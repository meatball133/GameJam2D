extends Camera2D

@onready var player = %Player

@export var snap_x = 500.0
@export var x_switch = 750
@export var y_limit = 200
@export var y_limit_low = 190
@export var y_diff = 300
@export_range(0.0, 1.0) var snap_speed := 1.0
@export var dash = 100.0

var target := global_position
var max_y := global_position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if abs(player.global_position.x) < x_switch:
		target.x = 0.0
	elif player.global_position.x < 0:
		target.x = - snap_x
	else:
		target.x = snap_x
	
	if player.global_position.y - global_position.y < - y_limit:
		target.y -= y_diff
	if player.global_position.y - global_position.y > y_limit_low:
		target.y += y_diff
	
	# no
	target.y = clamp(target.y, -1000000, max_y)
	
	global_position = lerp(global_position, target, snap_speed)
