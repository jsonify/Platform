extends BaseEnemy

@onready var animation_player := $AnimationPlayer

func _on_detection_area_player_detected(body):
	speed_multiplier = 5
	direction = (body.global_position - global_position).normalized()


func _on_detection_area_player_undetected(body):
	speed_multiplier = 1




func hit_effect():
	speed = 0
	animation_player.play("hit")
	await animation_player.animation_finished
#	speed = 1
	animation_player.play("death")
	await animation_player.animation_finished
	queue_free()
	
	


func _on_hurt_box_take_damage(amount):
#	hit_effect()
	pass
