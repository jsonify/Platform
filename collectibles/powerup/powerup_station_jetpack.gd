extends Area2D

var is_powerup_acquired := false

func _on_body_entered(body):
	if body is Player:
		powerup_acquired(is_powerup_acquired)


func powerup_acquired(_bool):
	if not Game.jetpack:
#		computer_animation_player.play("detected")
#		collision_shape.set_deferred("disabled", true)
#		detection_timer.start()
		Events.emit_signal("platform_jetpack_activated")
		is_powerup_acquired = true
	else:
		pass
#		computer_animation_player.play("detected")
