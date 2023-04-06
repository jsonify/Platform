extends Node

var STATES = null
var Hero = null

func enter_state():
	pass
	
func exit_state():
	pass
	
func update(delta):
	return null

func player_movement():
	if Hero.movement_input.x > 0:
		Hero.velocity.x = Hero.SPEED
	elif Hero.movement_input.x < 0:
		Hero.velocity.x = -Hero.SPEED
