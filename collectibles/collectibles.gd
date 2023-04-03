extends Node2D


var Jetpack = preload("res://collectibles/powerup/jetpack/jetpack.tscn")


func _on_timer_timeout():
	var jetpack_temp = Jetpack.instantiate()
	var rng = RandomNumberGenerator.new()
	var randint = randi_range(50, 550)
	jetpack_temp.position = Vector2(randint, 365)
	add_child(jetpack_temp)
	
