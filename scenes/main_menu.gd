extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func refresh_music_volume():
	var volume = get_node("/root/GlobalSettings").music_volume
	$MusicVolume/Number.text = str(volume)

func refresh_sfx_volume():
	var volume = get_node("/root/GlobalSettings").sfx_volume
	$SFXVolume/Number.text = str(volume)

func _on_music_volume_value_changed(value: float) -> void:
	get_node("/root/GlobalSettings").music_volume = value
	refresh_music_volume()

func _on_sfx_volume_value_changed(value: float) -> void:
	get_node("/root/GlobalSettings").sfx_volume = value
	refresh_sfx_volume()

func _on_start_button_button_up() -> void:
	get_node("/root/SceneManager").load_next_zone("res://scenes/test_world.tscn")
