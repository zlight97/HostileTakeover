extends EnemyState

var pos

func state_timer_triggered():
	scene_change.emit(self, "idle")

func enter():
	enemy.sprite_change("walk")
	timer.wait_time = randi()%3
	timer.start()
	pos = randf()*2 - 1

func update(delta: float):
	if get_distance_to_player() < 100:
		scene_change.emit(self, "attack")

func physics_update(delta: float) -> void:
	enemy.move(pos, delta)
