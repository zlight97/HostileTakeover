extends PlayerState

func enter():
	player.can_act = false
	player.sprite_change("charge_attack_1")

func exit():
	player.disable_hurtbox()

func physics_update(delta):
	player.move(0, delta)
	if player.can_act:
		if player.velocity.x != 0:
			scene_change.emit(self,"walk")
		process_input(delta)
