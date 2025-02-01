extends EnemyState

func enter():
	enemy.sprite_change("hurt")
	enemy.current_health = 1

func exit():
	get_node("/root/SceneManager").load_next_zone()
