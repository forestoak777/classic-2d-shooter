extends CharacterBody2D

signal died 

var speed = 0.2
var bullet_scene = preload("res://enemy_bullet.tscn")

var explosion_particle = preload("res://explosion_particle.tscn")

@onready var screensize  = get_viewport_rect().size

@onready var player_node = get_tree().get_first_node_in_group("player")


	
func _process(delta):
	if (player_node != null):
		look_at(player_node.global_position)
		rotation += deg_to_rad(90)

func _physics_process(delta):
	if player_node:
		var move_vec = (player_node.global_position - global_position).normalized() * speed
		move_and_collide(move_vec)
	else:
		print("NO PLAYER NODE")

func explode():
	_spawn_effect()
	queue_free()

func _spawn_effect():
	var effect = explosion_particle.instantiate()
	get_tree().root.add_child(effect)
	effect.global_position = global_position
