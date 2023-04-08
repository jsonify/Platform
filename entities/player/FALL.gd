extends "state.gd"

# TODO: eventually turn this into a signal
@onready var animation_player = $"../../AnimationPlayer"

func update(delta):
	animation_player.play("fall")
	Player.gravity(delta)
	player_movement()
	if Player.is_on_floor():
		return STATES.IDLE
		
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
		
	return null
	
