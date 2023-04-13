extends BoxBasic


func _on_body_entered(body):
		if body is Player:
			animation_player.play("opening")
			collision_shape.set_deferred("disabled", true)
			print("purple box now here")
