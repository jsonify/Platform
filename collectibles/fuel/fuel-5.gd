extends Area2D

@export var affected_by_light: bool

func _ready():
	$Sprite2D.light_mask = 0 if !affected_by_light else 1

func _on_body_entered(body):
	if body is Player:
		Game.fuel_level += 5.0
		queue_free()
