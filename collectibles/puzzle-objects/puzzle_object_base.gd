extends Area2D

class_name PuzzleObjectBase


func _on_body_entered(body):
	if body is Player:
		Events.emit_signal("right_horn_collected")
		queue_free()
