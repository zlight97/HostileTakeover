extends PlayerState

func enter():
	player.can_act = false
	player.sprite_change("charge_attack_1")

func physics_update(delta):
	player.move(0, delta)
	if player.can_act:
		scene_change.emit(self, "idle")
