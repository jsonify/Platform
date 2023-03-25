extends Area2D

#signal player_hit(damage_amount)

#var damage_amount := 10

@export var damage = 1

func _on_body_entered(body):
#	if body is Player:
#		body.knockback(position.x)
#		body.health -= damage_amount
#		emit_signal("player_hit", damage_amount)
#
#		# Stop the enemy's hitbox from continuosly damaging the player
#		$Timer.start()
#		set_collision_mask_value(2, false)
	print(get_parent().name + " hit the player")

func _on_timer_timeout():
	set_collision_mask_value(2, true)


func _on_area_entered(area):
	print(get_parent().name, " hit the player's hurtbox")
	var player = area.get_parent()
	player.take_damage(damage)
