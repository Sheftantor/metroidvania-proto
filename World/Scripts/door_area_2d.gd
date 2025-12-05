extends Area2D

@export var ConnectedRoom: String
@export var PlayerPos: Vector2
@export var PlayerJumpOnEnter : bool = false


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		RoomChangeGlobal.Activate = true
		RoomChangeGlobal.PlayerPos = PlayerPos
		RoomChangeGlobal.PlayerJumpOnEnte = PlayerJumpOnEnter
		get_tree().call_deferred("change_scene_to_file", ConnectedRoom)
	pass # Replace with function body.
