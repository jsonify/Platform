extends Area2D


func _on_body_entered(body):
	if body is Player:
		Game.fuel_level += 5.0
		queue_free()
