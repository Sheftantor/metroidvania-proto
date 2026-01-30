#Audio Global Script
extends Node


enum REVERB_TYPE { NONE, SMALL, MEDUIM, LARGE }

@export var ui_focus_audio : AudioStream
@export var ui_select_audio : AudioStream
@export var ui_cancel_audio : AudioStream
@export var ui_success_audio : AudioStream
@export var ui_error_audio : AudioStream

var current_track : int = 0
var music_tweens : Array[ Tween ]
var ui_audio_player : AudioStreamPlaybackPolyphonic

@onready var music_1: AudioStreamPlayer = %Music1
@onready var music_2: AudioStreamPlayer = %Music2
@onready var ui: AudioStreamPlayer = %UI


func _ready() -> void:
	ui.play()
	ui_audio_player = ui.get_stream_playback()
	pass
	
func play_ui_audio( audio : AudioStream ) -> void:
	if ui_audio_player:
		ui_audio_player.play_stream( audio )
	pass	
	
func setup_button_audio( node : Node ) -> void:
	for c in node.find_children( "*", "Button" ):
		c.pressed.connect( ui) 
	pass

	
#region /// UI functions
func ui_focus_change() -> void:
	play_ui_audio( ui_focus_audio )
	pass
	
func ui_select_change() -> void:
	play_ui_audio( ui_select_audio )
	pass	
	
func ui_cancel_change() -> void:
	play_ui_audio( ui_cancel_audio )
	pass	
	
func ui_succeess_change() -> void:
	play_ui_audio( ui_success_audio )
	pass	
	
func ui_error_change() -> void:
	play_ui_audio( ui_cancel_audio )
	pass	
#endregion	
