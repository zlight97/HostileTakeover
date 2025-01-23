extends CharacterBody2D
class_name Player

const MAX_SPEED = 300.0

@export var attack_damage = 10.
@export var attack_knockback = 2
@export var can_act: bool = true
@export var can_attack: bool = false

var jump_velocity = -400.0
var stop_speed = 25
var speed = 10 
var running = false
var max_jump_charge = 2 #in seconds
var jump_mult = 1.0

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var animation: AnimationPlayer = $Animation

func sprite_change(sprite_name: String):
	animation.play(sprite_name)

func set_camera_limits(limiter: CameraLimiter):
	$Camera.set_limits(limiter)

func jump(time):
	velocity.y = jump_velocity * time * jump_mult
	var direction := Input.get_axis("left", "right")
	velocity.x = velocity.x + (direction * MAX_SPEED/2) if velocity.x < MAX_SPEED/2 else direction * MAX_SPEED/2

func move(direction):
	if is_on_floor(): # cannot change movement while airborne
		if direction:
			velocity.x = move_toward(velocity.x, direction * MAX_SPEED, speed)
		else:
			velocity.x = move_toward(velocity.x, 0, speed if speed < stop_speed else stop_speed)
	

func _physics_process(delta: float) -> void:
	#process_camera(delta)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	

	move_and_slide()
