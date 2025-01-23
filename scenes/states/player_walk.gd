extends PlayerState

func enter():
	player.sprite_change("walk")

func exit():
	player.animation.stop()

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		scene_change.emit(self, "airborne")
	elif player.velocity.x == 0:
		scene_change.emit(self, "idle")
	else:
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("left", "right")
		player.move(direction)
		
		if Input.is_action_just_pressed("1"):
			scene_change.emit(self,"jab0")

		elif Input.is_action_just_pressed("jump") and player.is_on_floor():
			scene_change.emit(self, "jump")
