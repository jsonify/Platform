extends Area2D

signal take_damage(amount)


func _on_area_entered(_area):
	emit_signal("take_damage", 5)
