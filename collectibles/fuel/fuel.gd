extends Area2D


func _on_body_entered(body):
	if body is Player:
		Game.fuel += 10
		queue_free()
