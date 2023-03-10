extends Area2D

@onready var computer_animation_player := $ComputerAnimationPlayer
@onready var detection_timer := $DetectionTimer
@onready var collision_shape := $CollisionShape2D

signal platform_activated

var platform

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	computer_animation_player.play("detected")
	collision_shape.set_deferred("disabled", true)
	detection_timer.start()


func _on_timer_timeout():
	var jetpack = preload("res://PowerUps/jet_pack.tscn").instantiate()
	get_node("/root/World").add_child(jetpack)
	# other code to position the jetpack and add it to the scene
	emit_signal("platform_activated")
	platform = PowerUpPlatform.new()
	jetpack.position = platform.position
	computer_animation_player.play("destroy")
	
	
func apply_effect(body):
	pass
