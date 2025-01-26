extends CanvasLayer

var player: Player

func _ready():
	await owner.ready
	player = owner as Player
	$HPBar.max_value = player.MAX_HEALTH
	update_health()

func update_health():
	$HPBar.value = player.current_health if player.current_health > 0 else 0
