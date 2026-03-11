extends CharacterBody2D

signal died 

var speed = 20
var bullet_scene = preload("res://enemy_bullet.tscn")

var explosion_particle = preload("res://explosion_particle.tscn")

@onready var screensize  = get_viewport_rect().size

@onready var player_node = get_tree().get_first_node_in_group("Player")

func start(pos):
	speed = 0
	await get_tree().create_timer(randf_range(0.25, 0.55)).timeout
	var tw = create_tween().set_trans(Tween.TRANS_BACK)
	await tw.finished

	
func _process(delta):
	if (player_node != null):
		look_at(player_node.position)

func _physics_process(delta):
	if player_node:
		var move_vec = Vector2.from_angle(rotation) * speed * delta
		move_and_collide(move_vec)

func explode():
	speed = 0
	_spawn_effect()
	queue_free()

func _spawn_effect():
	var effect = explosion_particle.instantiate()
	get_tree().root.add_child(effect)
	effect.global_position = global_position
