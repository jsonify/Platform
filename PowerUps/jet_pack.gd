extends Area2D

#signal jetpack_collected

@onready var animation_player := $AnimationPlayer

var jetpack_enabled = false

func _on_body_entered(body):
	if body is Player:
		jetpack_enabled = true
		body.jetpack_enabled = true
		SaveLoad.data["player"]["jetpack_enabled"] = true
		SaveLoad.data["powerups"]["jetpack_powerup_acquired"] = true
		SaveLoad.save_data()
		animation_player.play("Destroy")
