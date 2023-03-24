extends CanvasLayer

@onready var health_label = $Panel/HealthLabel

var health = 50 : set = set_health
var max_health = null : set = set_max_health
var fueltanks
var fuel

func set_health(value):
	health = clamp(value, 0, max_health)
	

func set_max_health(value):
	max_health = max(value, 1)
	
func _ready():
	max_health = SaveLoad.data["player"]["max_health"]
	health = SaveLoad.data["player"]["max_health"]

