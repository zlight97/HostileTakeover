extends EnemyState

func enter():
	enemy.sprite_change("hook")
func exit():
	enemy.disable_hurtbox()

func update(delta):
	if enemy.can_act:
		if randi()%4 == 0:
			scene_change.emit(self,"hook")
		else:
			scene_change.emit(self,"flee")
	
func process_physics(delta: float) -> void:
	enemy.move(0, delta*2)
