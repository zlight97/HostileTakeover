extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("/root/SceneManager").load_next_zone()
