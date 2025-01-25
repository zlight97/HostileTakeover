extends EnemyState

func enter():
	enemy.sprite_change("dead")
	enemy.set_collision_layer_value(1, false)
	enemy.set_collision_mask_value(1, false)


func physics_update(delta: float) -> void:
	enemy.move(0, delta)
