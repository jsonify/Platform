extends PuzzleObjectBase

func _on_body_entered(body):
	if body is Player:
		Events.emit_signal("pink_horn_collected")
		queue_free()
