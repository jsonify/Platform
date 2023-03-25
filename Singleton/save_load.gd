extends Node

const SAVE_PATH = "user://save.json"

var default_data := {
	"player":
	{
		"name": "Zara",
		"max_health": 100,
		"health": 0,
		"jetpack_enabled": false,
		"level": 1,
		"current_projectile": "single"
	},
	"projectile": {
		"type": {
			"single": {
				"enabled": true
			},
			"multi": {
				"enabled": false,
				"quantity": 3
			},
			"laser": {
				"enabled": false
			},
			"flame_thrower": {
				"enabled": false
			},
		}
	},
	"powerups":
	{
		"jetpack_powerup_acquired": false,
		"hook_powerup_acquired": false,
	},
	"fuel":
	{
		"tank_acquired": false,
		"tank_capacity": 100,
		"number_of_tanks": 0,
		"type": {"basic": true, "rocket": false},
		"amount": 0
	},
	"levels_completed": [0]
}

var data = {}


func _ready():
	reset_data()
	load_data()
#	print(data)
	update_text()


func save_data():
	var save_game := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var json_string := JSON.stringify(data)
	#TODO: implement encryption password
	save_game.store_line(json_string)


func load_data():
	if not FileAccess.file_exists(SAVE_PATH):
		reset_data()
		return
	var load_game = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json_string = load_game.get_line()
	data = JSON.parse_string(json_string)

func load_player_health():
	return data["player"]["health"]

func reset_data():
	data = default_data.duplicate(true)


func update_text():
	pass
