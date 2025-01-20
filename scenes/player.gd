extends CharacterBody2D
class_name Player

const MAX_SPEED = 300.0

var jump_velocity = -400.0
var stop_speed = 25
var speed = 10 
var running = false

@onready var sprite = $Sprite

func _ready():
	for child in $StateMachine.get_children():
		child.change_sprite.connect(sprite_change)

func sprite_change(sprite_name: String):
	$Sprite.animation = sprite_name
	$Sprite.frame = 0

func set_camera_limits(limiter: CameraLimiter):
	$Camera.set_limits(limiter)

func _physics_process(delta: float) -> void:
	#process_camera(delta)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if is_on_floor(): # cannot change movement while airborne
		if direction:
			velocity.x = move_toward(velocity.x, direction * MAX_SPEED, speed)
		else:
			velocity.x = move_toward(velocity.x, 0, speed if speed < stop_speed else stop_speed)
	

	move_and_slide()
