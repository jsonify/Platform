extends Area2D

#signal jetpack_collected

@onready var animation_player := $AnimationPlayer

var jetpack_enabled = false

func _on_body_entered(body):
	if body is Player:
		jetpack_enabled = true
#		emit_signal("powerup_collected")
		animation_player.play("Destroy")
