extends "state.gd"

# TODO: eventually turn this into a signal
@onready var animation_player = $"../../AnimationPlayer"


func update(delta):
	# print("Fuel level: ", Player.fuel_level)
	Player.gravity(delta)
	player_movement()
	thrust_movement(delta)

	if Player.velocity.y > 0:
		return STATES.FALL
	
	if Player.velocity.y == 0:
		return STATES.IDLE

	return null


func thrust_movement(delta):
	if Player.jetpack_enabled:
		if Player.can_thrust:
			if Player.fuel_level > 0.01 and Player.thrust_input:
				animation_player.play("thrust")
				Player.apply_thrust()
				Game.fuel_level -= delta
			else:
				return STATES.FALL
		if Player.fuel_level <= 0:
			Player.can_thrust = false
			print("Player can thrust: ", Player.can_thrust)
