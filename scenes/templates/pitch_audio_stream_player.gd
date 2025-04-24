extends AudioStreamPlayer
class_name PitchAudioStreamPlayer
@export var pitch_low = .8
@export var pitch_hi = 1.2
var lastPitch = 1
@export var pitch_min_diff = .1
var using_timer = false
var can_play = false

enum volume_type {NONE, SFX, MUSIC}
@export var audio_type: volume_type = volume_type.NONE

#func _ready() -> void:
	#$Timer.timeout.connect(_on_timer_timeout)

func init(low=.8,high=1.2,diff=.1,timeout=1.0) -> void:
	set_pitches(low,high,diff)
	set_timeout(1.0)
	

func set_timeout(time):
	using_timer = true
	can_play = true
	$Timer.wait_time = time

func play_pitched(from_position=0.0):
	var settings = get_node("/root/GlobalSettings")
	if audio_type == volume_type.NONE:
		pass
	elif audio_type == volume_type.SFX:
		volume_db = (40*float(settings.sfx_volume) / 100.)-40
		if settings.sfx_volume == 0:
			return
	elif audio_type == volume_type.MUSIC:
		volume_db = (40*float(settings.music_volume) / 100.)-40
		if settings.music_volume > 0:
			play(from_position)
		return
		
	while abs(lastPitch - pitch_scale) < pitch_min_diff:
		pitch_scale = randf_range(pitch_low, pitch_hi)
	lastPitch = pitch_scale
	play(from_position)
	if not playing and (not using_timer or can_play):
		can_play = false
		if using_timer:
			$Timer.start()

func set_pitches(low=.8,high=1.2,diff=.1):
	pitch_low = low
	pitch_hi = high
	pitch_min_diff = diff

func update_sound():
	stop()
	play_pitched(get_playback_position())
	

func _on_timer_timeout() -> void:
	can_play = true
