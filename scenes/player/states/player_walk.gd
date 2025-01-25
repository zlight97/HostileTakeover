extends PlayerState

func enter():
	player.sprite_change("walk")

func exit():
	player.animation.speed_scale = 1.0

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		scene_change.emit(self, "airborne")
	elif player.velocity.x == 0:
		scene_change.emit(self, "idle")
	else:
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		process_input(delta)
		player.animation.speed_scale = abs(player.velocity.x) / player.MAX_SPEED
		if Input.is_action_just_pressed("run"):
			scene_change.emit(self,"run")
