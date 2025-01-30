extends HSlider


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = get_node("/root/GlobalSettings").music_volume
