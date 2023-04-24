extends BaseEnemy



func _on_detection_area_player_detected(body):
	speed_multiplier = 5
	direction = (body.global_position - global_position).normalized()


func _on_detection_area_player_undetected(body):
	speed_multiplier = 1
