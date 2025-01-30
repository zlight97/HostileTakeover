extends EnemyState

var action
var dist

func enter():
	enemy.sprite_change("run")
	action = "attack" if randi()%3 == 0 else "special"
	dist = enemy.attack_distance if "attack" in action else enemy.special_distance

func physics_update(delta: float) -> void:
	enemy.move(get_dir_to_player(), delta)
	
func update(delta: float):
	if get_distance_to_player() < dist:
		scene_change.emit(self, action)
