extends "state.gd"


func update(delta):
	Hero.gravity(delta)
	if Hero.movement_input.x != 0:
		return STATES.MOVE
	if Hero.jump_input_actuation == true:
		return STATES.JUMP
	if Hero.velocity.y >0:
		return STATES.FALL
	if Hero.dash_input and Hero.can_dash:
		return STATES.DASH
	return null
func enter_state():
	Hero.can_dash = true
