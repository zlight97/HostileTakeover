extends EnemyState

func enter():
	enemy.sprite_change("dash_attack")
	enemy.velocity.x = sign(enemy.player.global_position.x - enemy.global_position.x) * enemy.DASH_SPEED
func exit():
	enemy.disable_hurtbox()

func update(delta):
	if enemy.can_act:
		if randi()%2 == 0:
			scene_change.emit(self,"hook")
		else:
			scene_change.emit(self,"flee")
	
func process_physics(delta: float) -> void:
	enemy.move(0, delta*2)
