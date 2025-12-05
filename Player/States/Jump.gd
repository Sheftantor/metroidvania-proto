@icon( "res://Imports/Icons/state.svg" )
class_name PlayerStateJump extends PlayerState
@export var jump_velocity : float = 450.0

# what happens when the state is initialized
func Init() -> void:
	pass
	
#what happens when we eneter the state
func Enter() -> void:
	player.animation_player.play("Jump")
	player.animation_player.pause()
	player.add_debug_indicator( Color.LIME_GREEN )
	player.velocity.y = -jump_velocity
	pass
	
#what hapeens when we exixt the state
func Exit() -> void:
	player.add_debug_indicator( Color.YELLOW )
	pass

# what happens when an input is pressed	
func handle_input( _event : InputEvent ) -> PlayerState:
	if _event.is_action_released("jump"):
		player.velocity.y *= 0.5
		return fall
	return next_state


func process (_delta: float) -> PlayerState:
	set_jump_frame()
	return next_state
	
func physics_process (_delta: float) -> PlayerState:
	if player.is_on_floor():
		return idle
	elif player.velocity.y >= 0:
		return fall
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
	
func set_jump_frame() -> void:
	var frame : float = remap( player.velocity.y, -jump_velocity, 0.0, 0.0, 0.5 )
	player.animation_player.seek( frame, true )
	pass
