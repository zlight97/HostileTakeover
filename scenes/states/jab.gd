extends PlayerState

@export var animation_name: String
@export var next_animation: String

func enter():
	player.can_act = false
	player.can_attack = false
	player.sprite_change(animation_name)

func physics_update(delta):
	player.move(0, delta)
	if player.can_act:
		scene_change.emit(self,"idle")
	
	elif player.can_attack and Input.is_action_just_pressed("1") and next_animation:
		scene_change.emit(self,next_animation)
