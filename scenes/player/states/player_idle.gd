extends PlayerState

func enter():
	player.sprite_change("idle")

func physics_update(delta: float) -> void:
	if player.stop_movement:
		return
	if not player.is_on_floor():
		scene_change.emit(self, "airborne")
	elif player.velocity.x != 0:
		if player.running:
			pass
		else:
			scene_change.emit(self, "walk")
	else:
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		process_input(delta)
