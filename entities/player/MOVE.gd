extends "state.gd"

func update(delta):
	Hero.gravity(delta)
	player_movement()
	if Hero.velocity.x == 0:
		return STATES.IDLE
	if Hero.velocity.y > 0:
		return STATES.FALL
	if Hero.jump_input_actuation:
		return STATES.JUMP
	return null
