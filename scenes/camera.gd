extends Camera2D

class_name Camera

@export var lock_camera: bool = false

#Location vars
var camera_max_x
var camera_min_x
var camera_max_y
var camera_min_y
var diff_x
var diff_y

#Limit vars
const MAX_LIMIT = 10000000
var camera_limit_left_target = -MAX_LIMIT
var camera_limit_right_target = MAX_LIMIT
var camera_limit_bottom_target = MAX_LIMIT
var camera_limit_top_target = -MAX_LIMIT

func set_limits(limiter: CameraLimiter):
	camera_limit_left_target = limiter.get_limit_left()
	camera_limit_bottom_target = limiter.get_limit_bottom()
	camera_limit_right_target = limiter.get_limit_right()
	camera_limit_top_target = limiter.get_limit_top()
	print(camera_limit_bottom_target)
	print(camera_limit_top_target)
	if not limiter.is_one_way():
		if limiter.limit_x == limiter.LimitX.LEFT:
			camera_limit_right_target = camera_limit_left_target + (camera_max_x - camera_min_x)
		else:
			camera_limit_left_target = camera_limit_right_target - (camera_max_x - camera_min_x)
		if limiter.limit_y == limiter.LimitY.TOP:
			camera_limit_bottom_target = camera_limit_top_target + (camera_max_y - camera_min_y)
		else:
			camera_limit_top_target = camera_limit_bottom_target - (camera_max_y - camera_min_y)

func _ready():
	var view_rect = get_viewport_rect()
	camera_max_x = view_rect.end.x
	camera_max_y = view_rect.end.y
	camera_min_x = view_rect.position.x
	camera_min_y = view_rect.position.y
	diff_x = int((camera_max_x - camera_min_x)/2)
	diff_y = int((camera_max_y - camera_min_y)/2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var camera_top = global_position.y - diff_y - (drag_top_margin * diff_y)
	var camera_bottom = global_position.y + diff_y + (drag_bottom_margin * diff_y)
	var camera_left = global_position.x - diff_x - (drag_left_margin * diff_x)
	var camera_right = global_position.x + diff_x + (drag_right_margin * diff_x)
	limit_left = clamp_movement(camera_limit_left_target, camera_left, limit_left)
	limit_right = clamp_movement(camera_limit_right_target, camera_right, limit_right) 
	limit_top = clamp_movement(camera_limit_top_target, camera_top, limit_top )
	limit_bottom = clamp_movement(camera_limit_bottom_target, camera_bottom, limit_bottom)

func clamp_movement(dest, loc, real_cam_loc):
	return loc if abs(dest-loc) < abs(dest-real_cam_loc) else real_cam_loc
