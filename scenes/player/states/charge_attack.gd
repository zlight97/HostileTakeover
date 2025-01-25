extends PlayerState

func enter():
	player.sprite_change("charge_attack_0")

func physics_update(delta):
	player.move(0, delta)
	if not Input.is_action_pressed("2") or player.can_act:
		scene_change.emit(self, "charge_attack1")
	if not player.is_on_floor():
		scene_change.emit(self, "airborne")
