extends EnemyState

func state_timer_triggered():
	scene_change.emit(self, "walk")

func enter():
	enemy.sprite_change("idle")
	timer.wait_time = randi()%10
	timer.start()

func physics_update(delta: float) -> void:
	enemy.move(0, delta)
	
func update(delta: float):
	if abs(enemy.position.x - enemy.player.position.x) < enemy.detection_range:
		scene_change.emit(self, "run")
