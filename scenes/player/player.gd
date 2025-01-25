extends CharacterBody2D
class_name Player

const MAX_SPEED = 300.0
var MAX_HEALTH = 100
@export var attack_damage = 10.
@export var attack_knockback = 2
@export var can_act: bool = true
@export var can_attack: bool = false

var current_health = MAX_HEALTH
var jump_velocity = -400.0
var stop_speed = 400
var speed = 600 
var running = false
var max_jump_charge = 2 #in seconds
var jump_mult = 1.0
var attack_speed = 1.0 # % attack speed (faster = shorter hitbox duration)
var facingRight = true
var knockedBack = false
var run_mult = 2.0
var alive = true

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var animation: AnimationPlayer = $Animation

func apply_damage(damage):
	current_health -= damage

func get_facing_dir():
	return velocity.x > 0 if velocity.x != 0 and not knockedBack else facingRight
	
func sprite_change(sprite_name: String):
	animation.play(sprite_name)

func set_camera_limits(limiter: CameraLimiter):
	$Camera.set_limits(limiter)

func jump(time):
	velocity.y = jump_velocity * time * jump_mult
	var direction := Input.get_axis("left", "right")
	velocity.x = velocity.x + (direction * MAX_SPEED/2) if abs(velocity.x) < MAX_SPEED/2 else direction * MAX_SPEED/2

func move(direction, delta):
	if is_on_floor(): # cannot change movement while airborne
		if direction:
			velocity.x = move_toward(velocity.x, direction * MAX_SPEED, speed * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, speed * delta if speed < stop_speed else stop_speed * delta)

func die():#TODO add death animation, fade to black, a death screen etc.
	alive = false
	$StateMachine.on_state_change($StateMachine.current_state, "dead")

func _process(delta: float) -> void:
	if current_health <= 0 and alive:
		die()

func _physics_process(delta: float) -> void:
	if facingRight!=get_facing_dir():
		facingRight = !facingRight
		scale.x = -1
	if not is_on_floor():
		velocity += get_gravity() * delta


	move_and_slide()


func _on_attack_hitbox_area_entered(area: Area2D) -> void:
	if area is EnemyHurtbox:
		area.hurt(attack_damage, attack_knockback)


func apply_knockback(knockback):#TODO
	pass

func _on_hurtbox_apply_damage(damage, knockback) -> void:	
	if not alive:
		return
	current_health -= damage
	apply_knockback(knockback)
