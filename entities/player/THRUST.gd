extends "state.gd"

# TODO: eventually turn this into a signal
@onready var animation_player = $"../../AnimationPlayer"

func update(delta):
	Player.gravity(delta)
	player_movement()
	thrust_movement(delta)
	
	if Player.velocity.y > 0:
		return STATES.FALL
		
	return null

func thrust_movement(delta):
	if Player.jetpack_enabled:
		if Player.fuel_level > 0.0 and Player.thrust_input:
			animation_player.play("thrust")
			Player.apply_thrust()
			Game.fuel_level -= delta
		else:
			return STATES.FALL
		
			


#if jetpack_enabled:
#		if fuel_level > 0.0:
#			animation_player.play("thrust")
#			Game.fuel_level -= delta
#			apply_thrust()
#			update_direction(input)
#			elif input.x != 0:
#				apply_acceleration(input.x)
#		else:
#			state = states.FALL
