extends PlayerState

@export var player: Player

func enter():
	change_sprite.emit("walk")

func physics_update(delta: float) -> void:
	if player.velocity.x == 0 and player.is_on_floor():
		scene_change.emit(self, "idle")
