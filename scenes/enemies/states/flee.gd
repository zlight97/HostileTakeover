extends EnemyState
func state_timer_triggered():
	scene_change.emit(self, "idle")

func enter():
	enemy.sprite_change("run")
	timer.wait_time = randi()%2
	timer.start()


func physics_update(delta: float) -> void:
	enemy.move(-1. if enemy.player.position.x > enemy.position.x else 1., delta)
