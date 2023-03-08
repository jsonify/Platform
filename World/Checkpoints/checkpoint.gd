extends Area2D

@onready var animated_sprite := $AnimatedSprite2D

var active = true

func _on_body_entered(body):
	if not body is Player: return
	if not active: return
	animated_sprite.play("Checked")
	active = false
	Events.emit_signal("hit_checkpoint", position)
