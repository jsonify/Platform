extends Area2D

signal take_damage(amount)


func _on_area_entered(area):
	emit_signal("take_damage", 5)
