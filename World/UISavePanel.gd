extends Panel

# Emitted when the player presses the save button
signal save_requested
# Emitted when the player presses the load button
signal reload_requested

@onready var save_button := $HBoxContainer/SaveButton as Button
@onready var load_button := $HBoxContainer/LoadButton as Button


func _on_save_button_pressed():
	emit_signal("save_requested")
	print("Save button press")


func _on_load_button_pressed():
	emit_signal("reload_requested")
	print("Load button press")
