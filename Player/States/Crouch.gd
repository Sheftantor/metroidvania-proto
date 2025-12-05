@icon( "res://Imports/Icons/state.svg" )
class_name PlayerStateCrouch extends PlayerState

@export var deceleration_rate : float = 10

# what happens when the state is initialized
func Init() -> void:
	pass
	
#what happens when we eneter the state
func Enter() -> void:
	player.animation_player.play("Crouch")
	player.collision_stand.disabled = true
	player.collision_crouch.disabled = false
	pass
	
#what hapeens when we exixt the state
func Exit() -> void:
	player.collision_stand.disabled = false
	player.collision_crouch.disabled = true
	pass

# what happens when an input is pressed	
func handle_input( _event : InputEvent ) -> PlayerState:
	if _event.is_action_pressed("jump"):
		player.one_way_platform_shape_cast.force_shapecast_update()
		if player.one_way_platform_shape_cast.is_colliding() == true:
			player.position.y += 4
			return fall
		return jump
	return next_state


func process ( _delta: float ) -> PlayerState:
	if player.direction.y <= 0.5:
		return idle
	return next_state
	
	
func physics_process (_delta: float) -> PlayerState:
	player.velocity.x -=player.velocity.x * deceleration_rate * _delta
	if player.is_on_floor() == false:
		return fall
	return next_state
