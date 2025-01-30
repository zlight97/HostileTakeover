extends EnemyState

var time

func state_timer_triggered():
	
	enemy.sprite_change("charge_attack_1")
	#scene_change.emit(self, "charge_attack_1") #TODO use can_attack or ready to swap states

func exit():
	enemy.disable_hurtbox()
	
func enter():
	enemy.can_act = false
	enemy.sprite_change("charge_attack_0")
	time = randf() * 1.9
	timer.wait_time = time
	timer.start()

func physics_update(delta):
	enemy.move(0, delta)

func update(delta):
	if enemy.can_act:
		scene_change.emit(self, "flee")
