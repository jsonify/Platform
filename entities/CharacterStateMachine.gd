extends Node

class_name CharacterStateMachine

@export var current_state : State

var states : Array[State]

func _ready():
	for child in get_children():
		if child is State:
			states.append(child)
			
			#Set the states up with what they need to function
			
		else:
			push_warning("Child " + child.name + " is not a State for CharacterStateMachine")

func _physics_process(delta):
	if current_state.next_state != null:
		switch_state(current_state.next_state)

func check_if_can_move():
	return current_state.can_move

func switch_state():
	pass
