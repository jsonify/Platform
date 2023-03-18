extends Area2D

@onready var computer_animation_player := $ComputerAnimationPlayer
@onready var detection_timer := $DetectionTimer
@onready var collision_shape := $CollisionShape2D

var is_powerup_acquired := false

signal platform_activated

func _ready():
	if SaveLoad.data["powerups"]["jetpack_powerup_acquired"]:
		computer_animation_player.play("detected")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	powerup_acquired(is_powerup_acquired)


func _on_timer_timeout():
	Events.emit_signal("platform_activated")
	
	
func apply_effect(body):
	pass


func powerup_acquired(bool):
	if not SaveLoad.data["powerups"]["jetpack_powerup_acquired"]:
		computer_animation_player.play("detected")
		collision_shape.set_deferred("disabled", true)
		detection_timer.start()
		is_powerup_acquired = true
	else:
		SaveLoad.data["powerups"]["jetpack_powerup_acquired"]
		computer_animation_player.play("detected")
