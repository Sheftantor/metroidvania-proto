class_name Player extends CharacterBody2D

const DEBUG_JUMP_INDICATOR = preload("uid://dteqid1tkfoxw")

#region /// OnReady Variables
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_stand: CollisionShape2D = $CollisionStand
@onready var collision_crouch: CollisionShape2D = $CollisionCrouch
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var one_way_platform_shape_cast: ShapeCast2D = $OneWayPlatformShapeCast
@onready var foots_steps_cave: AudioStreamPlayer = $FootsSteps_Cave
@onready var post_jump_cave: AudioStreamPlayer = $PostJump_Cave

#endregion

#region /// export variable
@export var move_speed : float = 100
@export var max_fall_velocity : float = 600.0
#endregion


#region /// State Machine Variables
var states : Array [ PlayerState ]
var current_state : PlayerState :
	get : return states.front()
var previous_state : PlayerState :
	get : return states[ 1 ]
#endregion

#region /// Standard Variables Class
var direction : Vector2 = Vector2.ZERO
var gravity : float = 980
var gravity_multiplier : float = 1.0
#endregion

func _ready() -> void:
	if get_tree().get_first_node_in_group("Player") != self:
		self.queue_free()
	Initialize_States()
	self.call_deferred( "reparent", get_tree().root )
	pass
	
func _unhandled_input( event: InputEvent) -> void:
	ChangeState( current_state.handle_input( event ) )
	
func _physics_process( _delta : float ) -> void:
	velocity.y += gravity * _delta * gravity_multiplier
	velocity.y = clampf( velocity.y, -1000.0, max_fall_velocity )
	move_and_slide()
	ChangeState( current_state.physics_process( _delta ) )
	pass
	
func _process( _delta : float) -> void:
	update_direction()
	ChangeState( current_state.process( _delta ) )
	pass
	

func Initialize_States() -> void:
	states = []
	# gather all the states
	for c in $States.get_children():
		if c is PlayerState:
			states.append( c )
			c.player = self
		pass
	
	# returns the code to the beginning prematurly 
	if states.size() == 0:
		return		
			
	# Intialize all states
	for state in states:
		state.Init()
		
	ChangeState( current_state )
	current_state.Enter()
	$Label.text = current_state.name
	pass	


func ChangeState( new_state : PlayerState ) -> void:
	if new_state == null:
		return
	elif new_state == current_state:
		return
			
	if current_state:
		current_state.Exit()
		
	states.push_front( new_state )
	current_state.Enter()
	states.resize( 3 )
	$Label.text = current_state.name
	pass
	
func foot_steo_audio () -> void:
	foots_steps_cave.pitch_scale = randf_range( .8, 4)
	foots_steps_cave.play()

func update_direction() -> void:
	var prev_direction : Vector2 = direction
	#direction = Input.get_vector("left","right","up","down")
	var x_axis = Input.get_axis("left", "right")
	var y_axis = Input.get_axis("up", "down")
	direction = Vector2(x_axis, y_axis)
	
	if prev_direction.x != direction.x:
		if direction.x < 0:
			sprite.flip_h = true
		elif direction.x > 0:
			sprite.flip_h = false
	pass
	
func add_debug_indicator( color : Color = Color.RED) -> void:
	var d : Node2D = DEBUG_JUMP_INDICATOR.instantiate()
	get_tree().root.add_child(d)
	d.global_position = global_position
	d.modulate = color
	await get_tree().create_timer( 3.0 ). timeout
	d.queue_free()
	pass
