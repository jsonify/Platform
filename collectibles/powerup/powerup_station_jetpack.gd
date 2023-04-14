extends Area2D

var is_powerup_acquired := false

@onready var animation_player := $AnimationPlayer
@onready var collision_shape := $CollisionShape2D
@onready var timer := $Timer
@onready var attention_label := $DialogueAttention


func _on_body_entered(body):
	if body is Player:
		attention_label.visible = true
			

func find_and_use_dialogue():
	var dialogue_player = get_node_or_null("DialoguePlayer")
	
	if dialogue_player:
		dialogue_player.play()

func powerup_acquired(_bool):
	if not Game.jetpack:
		animation_player.play("activating")
		collision_shape.set_deferred("disabled", true)
		Events.emit_signal("platform_jetpack_activated")
		is_powerup_acquired = true
	else:
		animation_player.play("activated")

func activated():
	animation_player.play("activated")

func _on_dialogue_player_dialogue_done():
	powerup_acquired(is_powerup_acquired)

func _input(event):
	if event.is_action_pressed("event_usage"):
		find_and_use_dialogue()

func _on_body_exited(_body):
	attention_label.visible = false
