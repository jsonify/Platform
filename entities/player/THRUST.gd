extends "state.gd"

# TODO: eventually turn this into a signal
@onready var animation_player = $"../../AnimationPlayer"

func update(delta):
	animation_player.play("thrust")
	Player.gravity(delta)
	Player.apply_thrust()
	player_movement()
	
	if Player.velocity.y > 0:
		return STATES.FALL
		
	return null
