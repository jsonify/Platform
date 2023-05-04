extends Area2D

class_name HitBox

@export var damage := 10


func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			child.hit(damage)
