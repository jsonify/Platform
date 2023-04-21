extends Area2D
@export var affected_by_light: bool
@export var spawn_indicator_offset := -20

var fuel_amount := 1.0

#func _ready():
#	$Sprite2D.light_mask = 0 if !affected_by_light else 1

func _on_body_entered(body):
	if body is Player:
		Game.fuel_level += fuel_amount
		spawn_indicator(fuel_amount)
		queue_free()


func spawn_effect(EFFECT: PackedScene, effect_position: Vector2 = global_position):
	if EFFECT:
		var effect = EFFECT.instantiate()
		get_tree().current_scene.add_child(effect)
		effect.global_position = effect_position
		return effect
	
func spawn_indicator(amount: float):
	var indicator = spawn_effect(Utils.INDICATOR_DAMAGE)
	if indicator:
		indicator.position.y += spawn_indicator_offset
		indicator.label.text = "+" + str(amount)
