extends Node


@export var max_health := 1
@onready var health = max_health: set = set_health
@onready var player_health = SaveLoad.data["player"]["health"]

signal no_health

func _ready():
#	player_health = SaveLoad.load_player_health()
	print(player_health)

func set_health(value):
	health = value
	print(health)
	if health <= 0:
		emit_signal("no_health")
		
func get_player_health():
	player_health = SaveLoad.data["player"]["health"]
	
