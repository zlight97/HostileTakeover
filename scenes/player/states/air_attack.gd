extends PlayerState

func enter():
	player.can_act = false
	player.attack_damage = 10
	player.attack_knockback = 2
	player.sprite_change("air_attack")

func physics_update(delta):
	player.attack_damage += 2*delta
	player.attack_knockback = 4*delta
	
	if player.is_on_floor():
		scene_change.emit(self, "idle")
	elif player.can_act:
		scene_change.emit(self, "airborne")
