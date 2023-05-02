extends BaseEnemy

@onready var animation_player := $AnimationPlayer

func _on_detection_area_player_detected(body):
	speed_multiplier = 5
	direction = (body.global_position - global_position).normalized()


func _on_detection_area_player_undetected(_body):
	speed_multiplier = 1

	

