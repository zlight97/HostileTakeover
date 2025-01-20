extends PlayerState

@export var player: Player

func enter():
	change_sprite.emit("idle")

func physics_update(delta: float) -> void:
	if player.velocity.x != 0:
		if player.running:
			pass
		else:
			scene_change.emit(self, "walk")
