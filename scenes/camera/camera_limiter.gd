extends Area2D

class_name CameraLimiter

enum LimitX {NONE, LEFT, RIGHT}
enum LimitY {NONE, TOP, BOTTOM}
const MAX_LIMIT = 10000000

@export var one_way: bool = false
@export var limit_x: LimitX = LimitX.NONE
@export var limit_y: LimitY = LimitY.NONE

@onready var LimitPos = $CamPosition

func _ready():
	body_entered.connect(_on_body_entered.bind())

func is_one_way():
	return one_way

func get_limit_top():
	if limit_y != LimitY.TOP:
		return -MAX_LIMIT
	return LimitPos.global_position.y

func get_limit_bottom():
	if limit_y != LimitY.BOTTOM:
		return MAX_LIMIT
	return LimitPos.global_position.y

func get_limit_left():
	if limit_x != LimitX.LEFT:
		return -MAX_LIMIT
	return LimitPos.global_position.x
	
func get_limit_right():
	if limit_x != LimitX.RIGHT:
		return MAX_LIMIT
	return LimitPos.global_position.x


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.set_camera_limits(self)
