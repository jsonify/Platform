extends BaseEnemy

@onready var animation_player := $AnimationPlayer

func _physics_process(delta):
	patrol()
	detect_turn_around()
	move_and_slide()

func patrol():
	animation_player.play("walk")
	velocity = direction * normal_speed

func _on_detection_area_body_entered(body):
	if body is Player:
		player = body
		player_chase = true


func _on_detection_area_body_exited(body):
	if body is Player:
		player = null
		player_chase = false
