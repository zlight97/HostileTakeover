extends State
class_name PlayerState

var player: Player

func _ready():
	await owner.ready
	player = owner as Player
	
	assert(player != null)

func process_input(delta: float, running = false):
	var direction := Input.get_axis("left", "right")
	player.move(direction if not running else direction * player.run_mult, delta)
	if Input.is_action_just_pressed("1"):
		scene_change.emit(self,"jab0")
	elif Input.is_action_just_pressed("jump") and player.is_on_floor():
		scene_change.emit(self, "jump")
	elif Input.is_action_just_pressed("2"):
		scene_change.emit(self,"charge_attack0")
	elif Input.is_action_just_pressed("3"):
		scene_change.emit(self,"block")
