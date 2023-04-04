extends Node


const SAVE_PATH := "res://savegame.bin"

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"playerHP": Game.playerHP,
		"gold": Game.gold,
		"fuel_level": Game.fuel_level,
		"jetpack": Game.jetpack,
	}
	
	var json_string = JSON.stringify(data)
	file.store_line(json_string)
	print("file saved")
	
	
func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.playerHP = current_line["playerHP"]
				Game.gold = current_line["gold"]
				Game.fuel_level = current_line["fuel_level"]
				Game.jetpack = current_line["jetpack"]
