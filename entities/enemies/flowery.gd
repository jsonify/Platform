extends BaseEnemy



func _ready():
	$DetectionArea.player_detected.connect(player_was_detected)
	$DetectionArea.player_undetected.connect(player_now_undetected)
	
	
func player_was_detected():
	normal_speed = 50

func player_now_undetected():
	normal_speed = 10
