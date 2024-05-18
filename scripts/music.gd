extends AudioStreamPlayer

@export var beats = 4
@export var time_offset = 0.0
@export var measures = 30
@export var seconds_per_beat = 60.0 / 120.0

var song_position := 0.0
var song_position_in_beats = 0.0

func _process(delta: float) -> void:
	song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
	song_position -= AudioServer.get_output_latency() + time_offset
	
	print(distance_to_beat())

func distance_to_beat():
	var in_beats : float = round(song_position / seconds_per_beat)
	return song_position - in_beats * seconds_per_beat
