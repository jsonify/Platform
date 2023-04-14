extends PuzzleObjectBase

signal pink_horn_collected


func _on_body_entered(body):
	if body is Player:
		emit_signal("pink_horn_collected")
		queue_free()
