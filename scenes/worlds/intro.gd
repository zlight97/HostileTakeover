extends CanvasLayer

var scene = 1
@onready var scenes = [$Scene1, $Scene2, $Scene3, $Scene4, $Scene5]
# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#scenes[scene].visible = true
	#scene += 1
	#$Timer.start


func _on_timer_timeout() -> void:
	if scene > 4:
		get_node("/root/SceneManager").load_next_zone()
		return
	scenes[scene-1].visible = false
	scenes[scene].visible = true
	scene += 1
	
