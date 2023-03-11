extends Area2D

@onready var computer_animation_player := $ComputerAnimationPlayer
@onready var detection_timer := $DetectionTimer
@onready var collision_shape := $CollisionShape2D


signal platform_activated

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	computer_animation_player.play("detected")
	collision_shape.set_deferred("disabled", true)
	detection_timer.start()


func _on_timer_timeout():
	Events.emit_signal("platform_activated")
	computer_animation_player.play("destroy")
	
	
func apply_effect(body):
	pass

