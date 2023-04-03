extends Node2D

const Jetpack = preload("res://collectibles/powerup/jetpack/jetpack.tscn")
@onready var powerup_platform = $PowerupPlatform

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.platform_jetpack_activated.connect(_on_power_up_platform_activated)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_power_up_platform_activated():
	print("Platform activated")
	var jetpack = Jetpack.instantiate()
	var platform_position = powerup_platform.position
	jetpack.position = platform_position
	jetpack.position.y -= 5
	add_child(jetpack)
	
