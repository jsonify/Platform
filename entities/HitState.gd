extends State

class_name HitState

@export var damageable: Damageable
@export var state_machine: CharacterStateMachine

func _ready():
	damageable.connect("on_hit", on_damageable_hit)
	

func on_damageable_hit(node: Node, damage_amount: int):
	pass
