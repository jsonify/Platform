extends "state.gd"

# TODO: eventually turn this into a signal
@onready var animation_player = $"../../AnimationPlayer"

func update(delta):
	animation_player.play("run")
	Player.gravity(delta)
	player_movement()
	if Player.velocity.x == 0:
		return STATES.IDLE
		
	if Player.velocity.y > 0:
		return STATES.FALL
		
	if Player.jump_input_actuation:
		return STATES.JUMP
		
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	return null


func enter_state():
	Player.can_dash = true
