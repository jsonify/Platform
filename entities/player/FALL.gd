extends "state.gd"


func update(delta):
	Hero.gravity(delta)
	player_movement()
	if Hero.is_on_floor():
		return STATES.IDLE
		
	
	return null
	
