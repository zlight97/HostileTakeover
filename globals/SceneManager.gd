extends Node

var current_scene = null
var dialogue_scene = null
var player = null

var next_map_index = 0
var maps = ["res://scenes/main_menu.tscn",
			"res://scenes/worlds/into.tscn",
			"res://scenes/worlds/world0.tscn",
			"res://scenes/worlds/world1.tscn",
			"res://scenes/worlds/world2.tscn",
			"res://scenes/worlds/world3.tscn",
			"res://scenes/worlds/world4.tscn",
			"res://scenes/worlds/end_room.tscn"]
	
func _deferred_clear_dialogue():
	# Immediately free the current scene,
	# there is no risk here.
	if dialogue_scene:
		dialogue_scene.free()
		dialogue_scene = null
	
func move_zone(from_name,entry_point=0):
	var path = get_node("/root/MapTables").get_map_dest(from_name, entry_point)
	call_deferred("_deferred_move_zone", path[0], path[1])

func load_next_zone():
	call_deferred("_deferred_load_zone")
	
func restart_zone():
	call_deferred("_deferred_load_zone", true)

func restart():
	next_map_index = 0
	load_next_zone()

func _deferred_load_zone(restartZone:=false):
	if current_scene:
		current_scene.free()

	# Instance the new scene.
	if restartZone:
		current_scene = load(maps[next_map_index-1 if next_map_index > 0 else 0]).instantiate()
	else:
		current_scene = load(maps[next_map_index]).instantiate()
		next_map_index += 1
	var root = get_tree().get_root()
	var scene = root.get_node("Main")
	scene.add_child(current_scene)

func _deferred_move_zone(path,exit_point):
	if current_scene:
		current_scene.free()

	# Instance the new scene.
	current_scene = load(path).instantiate()
	var ch = current_scene.get_entry_choords(exit_point)
	
	var root = get_tree().get_root()
	var scene = root.get_node("Main")
	player = scene.get_node("Player")
	scene.remove_child(player)
	scene.add_child(current_scene)
	player.set_choords(ch)
	player.set_camera_bounds(get_node("/root/MapTables").cameraBounds[current_scene.name])
	scene.add_child(player)
	
	get_tree().set_current_scene(scene)

	
func create_dialogue(dialogue,speaker_name=null,sprite=null,sprite_position=null):
	# Load new scene.
	dialogue_scene = preload("res://scenes/DialogueBox.tscn").instantiate()
	# Instance the new scene.
	#dialogue_scene = s.instance()
	dialogue_scene.newDialogue(dialogue,speaker_name,sprite,sprite_position)
	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(dialogue_scene)

	# Optional, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(dialogue_scene)


func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function from the running scene.
	# Deleting the current scene at this point might be
	# a bad idea, because it may be inside of a callback or function of it.
	# The worst case will be a crash or unexpected behavior.

	# The way around this is deferring the load to a later time, when
	# it is ensured that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# Immediately free the current scene,
	# there is no risk here.
	if current_scene:
		current_scene.free()

	# Load new scene.
	var s = load(path).instantiate()

	# Instance the new scene.
	current_scene = s

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optional, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)

func clear_crafting():
	call_deferred("_deferred_clear_crafting")
	
func clear_dialogue():
	call_deferred("_deferred_clear_dialogue")
	
func _on_dialogue_box_hidden():
	clear_dialogue()
