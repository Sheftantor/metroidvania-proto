@icon( "res://Imports/Icons/player_spawn.svg" )
class_name PlayerSpawn extends Node2D



func _ready() -> void:
	visible = false
	await get_tree().process_frame
	
	if get_tree().get_first_node_in_group( "Player" ):
		#We have a player!
		print("We have a player")
		return
	print( "No Player found" )
	# check to see if we already have a player
		# if we have a player, do nothing
	
	# Instantiate a new instance of our player scene
	var player : Player = load("uid://2g0qrobqowur").instantiate()
	get_tree().root.add_child( player )
	# position the player scene
	player.global_position = self.global_position
	pass
