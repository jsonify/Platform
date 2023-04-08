extends "state.gd"

# TODO: eventually turn this into a signal
@onready var animation_player = $"../../AnimationPlayer"

func update(delta):
	animation_player.play("jump")
	Player.gravity(delta)
	player_movement()
	if Player.velocity.y > 0:
		return STATES.FALL
		
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	
	return null
func enter_state():
	Player.velocity.y = Player.JUMP_VELOCITY
