extends CharacterBody2D
class_name Enemy

const DASH_SPEED = 600
const MAX_SPEED = 300.0
var MAX_HEALTH = 25
var attack_distance = 100
var special_distance = 100
@export var attack_damage = 10.
@export var attack_knockback = 2
@export var can_act: bool = true
@export var can_attack: bool = false
var player: Player
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
var alive = true
var run_mult = 2.0
var detection_range = 500

var last_animation = null
var last_animation_time = 0


@onready var sprite: AnimatedSprite2D = $Sprite
@onready var animation: AnimationPlayer = $Animation
@onready var state_timer: Timer = $StateTimer

func _ready() -> void:
	if not player:
		await owner.ready
		player = owner.player
	if player.global_position.x < global_position.x:
		facingRight = false
		scale.x = -1
	init()


func init():
	pass

func apply_damage(damage):
	current_health -= damage
	if current_health > 0:
		last_animation_time = $Animation.current_animation_position
		sprite_change("hurt")
		$Hit.play_pitched()
		$DamageTimer.start()
	

func get_facing_dir():
	return velocity.x > 0 if velocity.x != 0 and not knockedBack else facingRight
	
func sprite_change(sprite_name: String):
	animation.play(sprite_name)

func set_camera_limits(limiter: CameraLimiter):
	$Camera.set_limits(limiter)

func jump(time, direction: float):
	velocity.y = jump_velocity * time * jump_mult
	velocity.x = velocity.x + (direction * MAX_SPEED/2) if abs(velocity.x) < MAX_SPEED/2 else direction * MAX_SPEED/2

func move(direction, delta):
	if is_on_floor(): # cannot change movement while airborne
		if direction:
			velocity.x = move_toward(velocity.x, direction * MAX_SPEED, speed * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, speed * delta if speed < stop_speed else stop_speed * delta)

func die():
	alive = false
	$StateMachine.on_state_change($StateMachine.current_state, "dead")
	$Death.play_pitched()

func _process(delta: float) -> void:
	if current_health <= 0 and alive:
		die()
	elif not alive and $Animation.current_animation != "dead" and $Animation.current_animation:
		$StateMachine.on_state_change($StateMachine.current_state, "dead")

func _physics_process(delta: float) -> void:
	if facingRight!=get_facing_dir():
		facingRight = !facingRight
		scale.x = -1
	if not is_on_floor():
		velocity += get_gravity() * delta


	move_and_slide()

func apply_knockback(knockback):#TODO
	pass


func disable_hurtbox():
	$AttackHitbox/CollisionShape2D.disabled = true
	
func _on_hurtbox_apply_damage(damage, knockback) -> void:
	if not alive:
		return
	apply_damage(damage)
	apply_knockback(knockback)


func _on_state_timer_timeout() -> void:
	if $StateMachine.current_state:
		$StateMachine.current_state.state_timer_triggered()


func _on_attack_hitbox_area_entered(area: Area2D) -> void:
	if area is PlayerHurtbox:
		area.hurt(attack_damage, attack_knockback)


func _on_damage_timer_timeout() -> void:
	if last_animation:
		sprite_change(last_animation)
		$Animation.seek(last_animation_time, true)
		last_animation_time = 0
	else:
		$StateMachine.on_state_change($StateMachine.current_state, "idle")


func _on_animation_animation_changed(old_name: StringName, new_name: StringName) -> void:
	if new_name == "hurt" and not old_name == "hurt":
		last_animation = old_name
	elif old_name == "hurt":
		last_animation = null
