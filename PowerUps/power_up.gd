extends Area2D

@onready var computer_animation_player := $ComputerAnimationPlayer
@onready var detection_timer := $DetectionTimer

signal platform_activated


func _on_body_entered(body):
	computer_animation_player.play("detected")
	detection_timer.start()


func _on_timer_timeout():
	emit_signal("platform_activated")
	computer_animation_player.play("destroy")
	

	
