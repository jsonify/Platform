extends Node

#var load_saved_game = false
#var save_path = "user://savegame.json"
#
#func _ready():
#	var file = FileAccess.open(save_path, FileAccess.READ)
#	load_data()
#
#func save():
#	var data = {
#		"player" : %Player.to_dictionary(),
#	}
#
#func load_data():
#	load_saved_game = true
#	var file = FileAccess.open(save_path, FileAccess.READ)
#
#	if file.file_exists(save_path):
#		file = FileAccess.open(save_path, FileAccess.READ)
#		var json = JSON.new()
#		var data = JSON.parse_string(file.get_as_text())
#
#		%Player.from_dictionary(data.player)
