class_name PauseMenu extends CanvasLayer

#region /// On ready variables
@onready var pause_screen: Control = %PauseScreen
@onready var system_menu: Control = %SystemMenu
@onready var system_menubutton: Button = %SystemMenubutton
@onready var back_to_map_button: Button = %BackToMapButton
@onready var back_to_title_button: Button = %BackToTitleButton
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SFXSlider
@onready var ui_slider: HSlider = %UISlider
#endregion

var player : Player


func _ready() -> void:
	#grab player
	show_pause_screen()
	system_menubutton.pressed.connect( show_system_menu )
	#audio setup
	#system menu
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	pass
	
func show_pause_screen() -> void:
	pause_screen.visible = true
	system_menu.visible = false
	
	pass


func show_system_menu() -> void:
	pause_screen.visible = false
	system_menu.visible = true
	pass
