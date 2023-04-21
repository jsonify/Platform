extends Area2D

class_name SignBase

@onready var sprite := $Sprite2D

func _ready():
	sprite.modulate.a = 0.0

