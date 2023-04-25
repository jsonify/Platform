extends BaseEnemy
class_name Spidey

@onready var animation_player := $AnimationPlayer
@onready var timer := $Timer


func _process(delta):
	animation_player.play("walk")
	

func _on_timer_timeout():
	speed_multiplier = 1


func _on_detection_area_player_detected(body):
	speed_multiplier = 5


func _on_detection_area_player_undetected(body):
	timer.start()



func _on_hurt_box_area_entered(area):
	queue_free()
