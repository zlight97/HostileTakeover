extends CanvasLayer

var player: Player

func _ready():
	await owner.ready
	player = owner as Player
	$HPBar.max_value = player.MAX_HEALTH
	update_health()

func win():
	$WinScreen.visible = true

func update_health():
	$HPBar.value = player.current_health if player.current_health > 0 else 0

func die():
	$DeadScreen.visible = true

func toggle_pause():
	$Pause.visible = !$Pause.visible
	if !$Pause.visible:
		get_tree().paused = false
		get_tree().call_group("Audio", "update_sound")

func _input(event: InputEvent) -> void:
	if $Pause.visible:
		if Input.is_action_just_pressed("pause"):
			toggle_pause()

func refresh_music_volume():
	var volume = get_node("/root/GlobalSettings").music_volume
	$Pause/MusicVolume/Number.text = str(volume)

func refresh_sfx_volume():
	var volume = get_node("/root/GlobalSettings").sfx_volume
	$Pause/SFXVolume/Number.text = str(volume)

func _on_music_volume_value_changed(value: float) -> void:
	get_node("/root/GlobalSettings").music_volume = value
	refresh_music_volume()

func _on_sfx_volume_value_changed(value: float) -> void:
	get_node("/root/GlobalSettings").sfx_volume = value
	refresh_sfx_volume()

func _on_restart_button_up() -> void:
	get_tree().paused = false
	get_node("/root/SceneManager").restart_zone()


func _on_main_menu_button_up() -> void:
	get_tree().paused = false
	get_node("/root/SceneManager").restart()


func _on_close_button_up() -> void:
	toggle_pause()
