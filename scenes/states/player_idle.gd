extends PlayerState

func enter():
	player.sprite_change("idle")

func physics_update(delta: float) -> void:
	if player.velocity.x != 0:
		if player.running:
			pass
		else:
			scene_change.emit(self, "walk")
