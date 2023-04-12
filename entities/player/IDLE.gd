extends "state.gd"

@onready var animation_player = $"../../AnimationPlayer"

func update(delta):
	animation_player.play("idle")
	Player.gravity(delta)
	if Player.movement_input.x != 0:
		return STATES.MOVE

	if Player.jump_input_actuation:
		return STATES.JUMP

	if Player.velocity.y >0:
		return STATES.FALL
	
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
		
	if Player.thrust_input and Player.can_thrust:
		return STATES.THRUST
	
	return null


func enter_state():
	Player.can_dash = true
