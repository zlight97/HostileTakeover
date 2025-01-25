extends EnemyState

var will_attack_again
var i = 0

func enter():
	enemy.can_act = false
	enemy.sprite_change("jab0")
	will_attack_again = randi()%3 == 0
	
func update(delta):
	if enemy.can_attack and will_attack_again and i<2:
		will_attack_again = randi()%3 == 0
		i += 1
		enemy.sprite_change("jab" + str(i))
		
	if enemy.can_act:
		scene_change.emit(self, "flee")
