extends BaseEnemy
class_name Spidey

@onready var animation_player := $AnimationPlayer
@onready var timer := $Timer

func _ready():
	$DetectionArea.player_detected.connect(player_was_detected)


func player_was_detected():
	timer.start(2)
	normal_speed = 50

func _process(delta):
	animation_player.play("walk")
	

func _on_timer_timeout():
	normal_speed = 10
