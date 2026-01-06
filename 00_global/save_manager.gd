# save manager script
extends Node


var current_slot : int = 0
var save_data : Dictionary
var discovered_area : Array = []
var persistent_data : Dictionary = {}




func _ready() -> void:
	pass
	
	
func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_F5:
			save_game()
		elif event.keycode == KEY_F7:
			load_game()
	pass	


func create_new_save_game() -> void:
	discovered_area.clear()
	persistent_data.clear()
	var new_game_scene : String = "uid://u4tw1sy12qpy"
	discovered_area.append( new_game_scene )
	save_data = {
		"scene_path" : new_game_scene,
		"x" : 275,
		"y" : 263,
		"hp" : 20,
		"max_hp" : 20,
		"dash" : false,
		"double_jump" : false,
		"ground_slam" : false,
		"morph_roll" : false,
		"discovered_area": discovered_area,
		"persistent_data": persistent_data, 
 	}
	# Save game Data
	var save_file = FileAccess.open( "user://save.sav", FileAccess.WRITE )
	save_file.store_line( JSON.stringify( save_data ))
	pass



func save_game() -> void:
	print("Saved Game!")
	var player : Player = get_tree().get_first_node_in_group( "Player" )
	save_data = {
		"scene_path" : SceneManager.current_scene_uid,
		"x" : player.global_position.x,
		"y" : player.global_position.y,
		"hp" : player.hp,
		"max_hp" : player.max_hp,
		"dash" : player.dash,
		"double_jump" : player.double_jump,
		"ground_slam" : player.ground_slam,
		"morph_roll" : player.morph_roll,
		"discovered_area": discovered_area,
		"persistent_data": persistent_data, 
 	}
	var save_file = FileAccess.open( "user://save.sav", FileAccess.WRITE )
	save_file.store_line( JSON.stringify( save_data ))
	pass


func load_game() -> void:
	print("Load Game!")
	
	if not FileAccess.file_exists( "user://save.sav" ):
		return
		
	var save_file = FileAccess.open( "user://save.sav", FileAccess.READ )
	save_data = JSON.parse_string( save_file.get_line() )
	
	persistent_data = save_data.get( "persistent_data", {} )
	discovered_area = save_data.get( "discovered_area", [] )
	var scene_path : String = save_data.get( "scene_path", "uid://u4tw1sy12qpy" )
	SceneManager.transition_scene( scene_path, "", Vector2.ZERO, "up" )
	await SceneManager.new_scene_ready
	setup_player()
	pass



func setup_player() -> void:
	var player : Player = null
	while not player:
		player = get_tree().get_first_node_in_group( "Player" )
		await get_tree().process_frame
		
	player.max_hp = save_data.get( "max_hp", 20)
	player.hp = save_data.get( "hp", 20)
	
	player.dash = save_data.get( "dash", false )
	player.double_jump = save_data.get( "double_jump", false )
	player.ground_slam = save_data.get( "ground_slam", false )
	player.morph_roll = save_data.get( "morph_ball", false )
	
	player.global_position = Vector2(
			save_data.get( "x", 0 ),
			save_data.get( "y", 0 )
		)
	
	pass
