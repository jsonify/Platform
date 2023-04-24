extends Area2D

signal player_detected

func _on_body_entered(body):
	emit_signal("player_detected")
