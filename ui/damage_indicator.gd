extends Node2D

@export var SPEED := 2
@export var FRICTION := 15

@onready var label := $Label

var SHIFT_DIRECTION := Vector2.UP

func _process(delta):
	global_position += SPEED * SHIFT_DIRECTION * delta
	SPEED = max(SPEED - FRICTION * delta, 0)
