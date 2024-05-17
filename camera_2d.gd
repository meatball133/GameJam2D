extends Camera2D

@onready var player = %Player

@export var snap := 400.0
@export_range(0.0, 1.0) var snap_speed := 1.0
@export var dash = 100.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var x = round(player.global_position.x / snap) * snap
	global_position.x = lerp(global_position.x, clamp(x, - snap, snap), snap_speed)
