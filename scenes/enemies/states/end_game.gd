extends EnemyState

func enter():
	enemy.sprite_change("hurt")
	enemy.current_health = 1

func exit():
	enemy.player.win()
