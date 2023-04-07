extends "state.gd"


func update(delta):
	Hero.gravity(delta)
	player_movement()
	if Hero.velocity.y > 0:
		return STATES.FALL
	return null
func enter_state():
	Hero.velocity.y = Hero.JUMP_VELOCITY
