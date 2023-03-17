class_name SaveGameAsJSON
extends RefCounted

const SAVE_GAME_PATH := "user://save.json"

var version := 1

var character: Resource = MyCharacter.new()

var global_position := Vector2.ZERO

#var _file := File.new()


func save_exists() -> bool:
	return FileAccess.file_exists(SAVE_GAME_PATH)


func write_savegame() -> void:
	var _file := FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	if _file.get_open_error() != OK:
		printerr("Could not open the file %s. Aborting save operation. Error code: %s" % [SAVE_GAME_PATH, _file.get_open_error()])
		return

	var data := {
		"global_position":
		{
			"x": global_position.x,
			"y": global_position.y,
		},
		"player":
		{
			"jetpack_enabled": character.jetpack_enabled,
		}
	}
	
	var json_string := JSON.stringify(data)
	_file.store_string(json_string)


func load_savegame() -> void:
	var _file := FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	if _file.get_open_error() != OK:
		printerr("Could not open the file %s. Aborting save operation. Error code: %s" % [SAVE_GAME_PATH, _file.get_open_error()])
		return
	character = MyCharacter.new()
	while _file.get_position() < _file.get_length():
		var content := _file.get_line()
#		var content := _file.get_as_text()
		
		var json := JSON.new()
		var data = json.parse(content)
		global_position = Vector2(data.global_position.x, data.global_position.y)

		character.jetpack_enabled = data.player.jetpack_enabled
