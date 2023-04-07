extends "state.gd"


func update(delta):
	Hero.gravity(delta)
	if Hero.movement_input.x != 0:
		return STATES.MOVE
	if Hero.jump_input_actuation:
		return STATES.JUMP
	if Hero.velocity.y >0:
		return STATES.FALL
	return null
func enter_state():
	pass
#	Hero.can_dash = true
