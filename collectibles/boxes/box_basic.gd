extends Area2D

class_name BoxBasic



@onready var animation_player := $AnimationPlayer
@onready var collision_shape := $CollisionShape2D

func _on_body_entered(body):
		if body is Player:
			animation_player.play("opening")
			collision_shape.set_deferred("disabled", true)
			print("basic box now here")

