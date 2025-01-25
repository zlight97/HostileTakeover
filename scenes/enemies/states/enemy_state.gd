extends State
class_name EnemyState

var enemy: Enemy
var timer: Timer

func get_distance_to_player():
	return abs(enemy.position.x - enemy.player.position.x)

func get_dir_to_player():
	return 1. if enemy.player.position.x > enemy.position.x else -1.

func state_timer_triggered():
	pass

func _ready():
	await owner.ready
	enemy = owner as Enemy
	
	assert(enemy != null)
	timer = enemy.state_timer
