@icon( "res://Imports/Icons/switch.svg" )
class_name Switch extends Node2D

signal activated

const DOOR_SWITCH_AUDIO = preload( "res://General/door_&_switch/door_switch.wav" )  

var is_open : bool = false

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D


func _ready() -> void:
	if SaveManager.persistent_data.get_or_add(  )
	pass
