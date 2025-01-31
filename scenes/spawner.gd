extends Node2D

@export var small_dudes = 10
@export var big_dudes = 2
@export var timer = 4.0
@export var speed_up = 0.1
var index = 0
var time
var triggered = false
var done = false
var dudes = []
var bot_left_x
var bot_left_y
var dead_count = 0
var sd = preload("res://scenes/enemies/enemy_oe.tscn")
var bd = preload("res://scenes/enemies/enemy_mdw.tscn")

func entered(x, y):
	if not triggered and not done:
		bot_left_x = x
		bot_left_y = y
		$WaveBoundary.set_collision_layer_value(1, true)
		$WaveBoundary.set_collision_mask_value(1, true)
		triggered = true
		for i in range(small_dudes):
			dudes.append(sd.instantiate())
		for i in range(big_dudes):
			dudes.append(bd.instantiate())
		start_timer()

func start_timer():
	time = timer
	$Timer.wait_time = time
	$Timer.start()
	
func _on_timer_timeout() -> void:
	if done or index >= len(dudes):
		return
	dudes[index].position = Vector2(randi_range(1900,2700), -20)
	dudes[index].player = get_parent().player
	get_parent().add_child(dudes[index])
	index+=1
	time -= speed_up
	$Timer.wait_time = time
	$Timer.start()

func _process(delta: float) -> void:
	var count_dead = 0
	for dude in dudes:
		if not dude.alive:
			count_dead += 1
	if count_dead > dead_count:
		dead_count = count_dead
		if dead_count >= small_dudes+big_dudes:
			done = true
			$WaveBoundary.set_collision_layer_value(1, false)
			$WaveBoundary.set_collision_mask_value(1, false)
			
