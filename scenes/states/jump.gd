extends PlayerState

var mult: float = 0.

func enter():
	mult = 0
	player.sprite_change("jump")

func physics_update(delta):
	player.move(0)
	mult += delta
	if mult > player.max_jump_charge:
		mult = player.max_jump_charge
	if Input.is_action_just_released("jump"):
		player.jump(mult)
	if not player.is_on_floor():
		scene_change.emit(self, "airborne")

func exit():
	player.jump(mult)
