extends CharacterBody2D


func _on_hurttboxx_area_entered(area):
	queue_free()
