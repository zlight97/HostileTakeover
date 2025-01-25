extends EnemyState

func enter():
	enemy.sprite_change("run")

func physics_update(delta: float) -> void:
	enemy.move(get_dir_to_player(), delta)
	
func update(delta: float):
	if get_distance_to_player() < 100:
		var r = randi() % 3
		if r == 0:
			scene_change.emit(self, "jab")
		else:
			scene_change.emit(self, "charge_attack")
