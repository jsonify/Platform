extends Node2D
class_name PowerUpPlatform

@onready var platform_warp_animated_sprite := $PlatformWarpAnimatedSprite


func activate_warp():
	platform_warp_animated_sprite.play("activated")


func _on_power_up_platform_activated():
	activate_warp()
