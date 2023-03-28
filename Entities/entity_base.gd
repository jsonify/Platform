extends CharacterBody2D

signal hp_max_changed(new_hp_max)
signal hp_changed(new_hp)
signal died

@export var hp_max := 100 : set = set_hp_max
@export var hp := hp_max : set = set_hp
@export var defense := 0

@export var SPEED := 300

@onready var sprite := $Sprite2D
@onready var collision_shape := $CollisionShape2D
@onready var animation_player := $AnimationPlayer
@onready var hurtbox := $Hurtbox


func _physics_process(delta):
	move()
	
func move():
	move_and_slide()

func set_hp(value):
	if value != hp:
		hp = clamp(value, 0, hp_max)
		emit_signal("hp_changed", hp)
		if hp == 0:
			emit_signal("died")
		
func set_hp_max(value):
	if value != hp_max:
		hp_max = max(0, value)
		emit_signal("hp_max_changed", hp_max)
		self.hp = hp

func die():
	queue_free()

func receive_damage(base_damage):
	var actual_damage = base_damage
	actual_damage -= defense
	self.hp -= actual_damage

func _on_hurtbox_area_entered(hitbox):
	receive_damage(hitbox.damage)


func _on_died():
	die()
