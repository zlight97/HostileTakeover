extends PlayerState

func enter():
	player.blocking = true
	player.sprite_change("block")
func exit():
	player.blocking = false

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		scene_change.emit(self, "airborne")
	elif player.velocity.x != 0 and Input.get_axis("left", "right") != 0:
		if player.running:
			pass
		else:
			scene_change.emit(self, "walk")
	else:
		
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		process_input(delta)
		if Input.is_action_just_released("3"):
			scene_change.emit(self, "idle")
