extends Area2D

signal player_detected(body)
signal player_undetected(body)

func _on_body_entered(body):
	emit_signal("player_detected", body)



func _on_body_exited(body):
	emit_signal("player_undetected", body)
