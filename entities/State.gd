extends Node

class_name State

@export var can_move := true

var character: CharacterBody2D
var next_state: State

func state_input(event: InputEvent):
	pass
