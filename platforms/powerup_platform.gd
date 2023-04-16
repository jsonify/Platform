extends Node2D

const Jetpack = preload("res://collectibles/powerup/jetpack/jetpack.tscn")

func _ready():
	Events.platform_jetpack_activated.connect(_on_jetpack_power_up_platform_activated)


func _on_jetpack_power_up_platform_activated():
	var jetpack = Jetpack.instantiate()
	var platform_position = $AnimatedSprite2D.position
	jetpack.position = platform_position
	jetpack.position.y += 10
	call_deferred("add_child", jetpack)
