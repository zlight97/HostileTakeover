extends PlayerState

@export var animation_name: String
@export var next_animation: String

func enter():
	player.can_act = false
	player.can_attack = false
	player.sprite_change(animation_name)

func physics_update(delta):
	player.move(0, delta)
	player.animation.speed_scale = player.attack_speed
	if player.can_act:
		scene_change.emit(self,"idle")
	
	elif player.can_attack:
		if Input.is_action_just_pressed("1") and next_animation:
			scene_change.emit(self,next_animation)
		elif Input.is_action_just_pressed("2"):
			scene_change.emit(self,"charge_attack0")
