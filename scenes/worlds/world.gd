extends Node2D

@onready var player: Player = $Player

func _ready():
	get_tree().paused = false
	$music.play_pitched()


func _on_load_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		get_node("/root/SceneManager").load_next_zone()

func entered(x,y):
	$Spawner.entered(x,y)
