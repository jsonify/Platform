extends "state.gd"

func update(delta):
	Hero.gravity()
	player_movement()
	if Hero.velocity.x == 0:
		return STATES.IDLE
	
	if Hero.velocity.y > 0:
		return STATES.FALL
	
	if Hero.jump_input:
		return STATES.JUMP
	
	
	return null
