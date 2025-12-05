@icon( "res://Imports/Icons/state.svg" )
class_name PlayerStateRun extends PlayerState




# what happens when the state is initialized
func Init() -> void:
	pass
	
#what happens when we eneter the state
func Enter() -> void:
	player.animation_player.play("Run")
	pass
	
#what hapeens when we exixt the state
func Exit() -> void:
	pass

# what happens when an input is pressed	
func handle_input( _event : InputEvent ) -> PlayerState:
	if _event.is_action_pressed("jump"):
		return jump
	return next_state


func process (_delta: float) -> PlayerState:
	if player.direction.x == 0:
		return idle
	elif player.direction.y > 0.5:
		return crouch
	return next_state
	
func physics_process (_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed
	if player.is_on_floor() == false:
		return fall
	return next_state
