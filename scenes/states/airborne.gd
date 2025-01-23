extends PlayerState

func enter():
	player.sprite_change("airborne")

func physics_update(delta):
	if player.is_on_floor():
		if player.velocity.x == 0:
			scene_change.emit(self, "idle")
		elif player.running:
			pass
		else:
			scene_change.emit(self, "walk")
