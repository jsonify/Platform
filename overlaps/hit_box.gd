extends Area2D

signal player_hit(amount)

@export var damage := 1

func _on_body_entered(body):
	emit_signal("player_hit", damage)
