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
var is_end = false
var is_scene = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_end or is_scene:
		pass
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
	
	if Input.is_key_pressed(KEY_0):
		end()
	
	# no
	target.y = clamp(target.y, -1000000, max_y)
	
	global_position = lerp(global_position, target, snap_speed)


func cutscene():
	is_scene = true
	$AudioStreamPlayer2.playing = true
	$AnimationPlayer.play("scene")

func end():
	is_end = true
	%Music.stop()
	$AudioStreamPlayer.play()
	$AnimationPlayer.play("end")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if not is_scene:
		get_tree().quit()
	else:
		is_scene = false
		zoom = Vector2(1.75, 1.75)
		$AnimationPlayer.stop()
		%Music.play()
