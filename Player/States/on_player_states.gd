class_name PlayerState extends Node

var player: Player
var next_state: PlayerState

#region /// state refernces
@onready var idle: PlayerStateIdle = %Idle
@onready var run: PlayerStateRun = %Run
@onready var jump: PlayerStateJump = %Jump
@onready var fall: PlayerStateFall = %Fall
@onready var crouch: PlayerStateCrouch = %Crouch
@onready var attack_1: PlayerStateAttack1 = %Attack1

#endregion

# what happens when the state is initialized
func Init() -> void:
	pass
	
#what happens when we eneter the state
func Enter() -> void:
	pass
	
#what hapeens when we exixt the state
func Exit() -> void:
	pass

# what happens when an input is pressed	
func handle_input( _event : InputEvent ) -> PlayerState:
	return next_state


func process (_delta: float) -> PlayerState:
	return next_state
	
func physics_process (_delta: float) -> PlayerState:
	return next_state
