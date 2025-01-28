extends Node2D

@onready var player: Player = $Player

func _ready():
	get_tree().paused = false
