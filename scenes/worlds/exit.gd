extends CanvasLayer

var a = true

func _on_timer_timeout() -> void:
	if a:
		$S1.visible = false
		$S2.visible = true
		a = false
	else:
		$End.visible = true
	

func _on_restart_button_up() -> void:
	get_tree().paused = false
	get_node("/root/SceneManager").restart_zone()


func _on_main_menu_button_up() -> void:
	get_tree().paused = false
	get_node("/root/SceneManager").restart()
