extends State

class_name HitState

@export var damageable: Damageable
@export var state_machine: CharacterStateMachine
@export var dead_state: State
@export var dead_animation_node := "dead"
@export var knockback_velocity := Vector2(100, 0)

func _ready():
	damageable.connect("on_hit", on_damageable_hit)
	

func on_enter():
	character.velocity = knockback_velocity
	

func on_damageable_hit(node: Node, damage_amount: int):
	if damageable.health > 0:
		emit_signal("interrupt_state", self)
	else:
		emit_signal("interrupt_state", dead_state)
		playback.travel(dead_animation_node)

func on_exit():
	character.velocity = Vector2.ZERO
