extends CanvasLayer

signal set_player_active
signal dialogue_done

@export_file(".json") var d_file

@onready var d_name := $NinePatchRect/Name
@onready var d_text := $NinePatchRect/Message
@onready var d_box := $NinePatchRect

var dialogues = []
var current_dialogue_id := 0
var is_dialogue_active := false

func _ready():
	d_box.visible = false
	

func play():
	if is_dialogue_active:
		return
	
	dialogues = load_dialogues()
	
	turn_off_player()
	is_dialogue_active = true
	d_box.visible = true
	current_dialogue_id = -1
	next_line()
	

func _input(event):
	if not is_dialogue_active:
		return
		
	if event.is_action_pressed("event_usage"):
		next_line()
		

func next_line():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogues):
		$Timer.start()
		d_box.visible = false
		turn_on_player()
		
		return
	d_name.text = dialogues[current_dialogue_id]["name"] + ":"
	d_text.text = dialogues[current_dialogue_id]["text"]

	

func load_dialogues():
	var file = d_file
	var json_as_text = FileAccess.get_file_as_string(file)
	var json_as_dict = JSON.parse_string(json_as_text)
	return json_as_dict


func _on_timer_timeout():
	is_dialogue_active = false
	emit_signal("dialogue_done")

func turn_on_player():
	emit_signal("set_player_active", true)
	
	
func turn_off_player():
	emit_signal("set_player_active", false)
