extends CanvasLayer

@onready var health_label = $Panel/HealthLabel

#var max_health = null : set = set_max_health
var fueltanks
var fuel
@onready var player = Player
#func set_health(value):
#	health = clamp(value, 0, max_health)
#
#
#func set_max_health(value):
#	max_health = max(value, 1)
#
func _ready():
	get_node("root/player").health_changed.connect("update_health_label")
	
func update_health_label(new_health):
	health_label.text = str(new_health)

func _process(delta):
	pass
	
func new_hp():
	print("what")
