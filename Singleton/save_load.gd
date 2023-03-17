extends Node

const SAVE_PATH = "user://save.json" #use user://savefilename.dat instead here

var player_data := {
	"name"="Jsonify",
	"score"=10,
	"jetpack_enabled" = false,
	"guns"={
		"small": 10,
		"large": 14
	}
}
	
func save_data():
	var save_game := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var json_string := JSON.stringify(player_data)
	#TODO: implement encryption password
	save_game.store_line(json_string)

func load_data():
	if not FileAccess.file_exists(SAVE_PATH):
		print("no file, to load.")
		return
	var load_game = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json_string = load_game.get_line()
	player_data = JSON.parse_string(json_string)

