extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("/root/SceneManager").load_next_zone("res://scenes/main_menu.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
