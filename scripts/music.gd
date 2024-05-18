extends AudioStreamPlayer

@export var beats = 4
@export var time_before_start = 0.0
@export var measures = 30
@export var bpm = 120

var seconds_per_beat = 60 / bpm

var song_position := 0.0

func _process(delta: float) -> void:
	var song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
	song_position -= AudioServer.

func distance_to_beat():
	var song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
	song_position _= AudioServer
