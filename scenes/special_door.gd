extends Node2D

signal stop_movement

var count = 0
var moving = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Smash.play_pitched()
	$Timer.start()
	stop_movement.emit(true)

func _physics_process(delta: float) -> void:
	if moving:
		$Door1.position.x = move_toward($Door1.position.x, 10000, delta*1000)
		$Door1.rotation = move_toward($Door1.rotation, 1000, delta* 10)
		

func _on_timer_timeout() -> void:
	if count > 2:
		moving = true
		$Crush.play_pitched()
		$Timer.stop()
		stop_movement.emit(false)
		return
	count += 1
	
	$Smash.play_pitched()
