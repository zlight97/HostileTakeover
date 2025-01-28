extends PlayerState

func enter():
	player.sprite_change("dead")

func physics_update(delta: float) -> void:
	player.move(0, delta)
