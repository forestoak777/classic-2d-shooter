extends CharacterBody2D

@export var speed = -250

var explosion_particle = preload("res://explosion_particle.tscn")

func start(pos, rot):
	position = pos
	rotation = rot
	
func _physics_process(delta):
	var direction = Vector2.from_angle(rotation + deg_to_rad(90))
	var motion = direction * speed * delta
	
	var collision = move_and_collide(motion)
	
	if collision:
		var collider = collision.get_collider()
	
		if collider is TileMapLayer:
			_destroy_tile(collider, collision.get_position(), collision.get_normal())
			_spawn_effect(collision.get_position())
			queue_free()
		elif collider.is_in_group("enemies"):
			collider.explode()
			queue_free()
			
@onready var game_data = get_tree().get_first_node_in_group("game_data")

func _destroy_tile(tilemap: TileMapLayer, hit_pos: Vector2, normal: Vector2):
	var inset_pos = hit_pos - normal * 1.0
	var tile_pos = tilemap.local_to_map(tilemap.to_local(inset_pos))
	tilemap.erase_cell(tile_pos)
	game_data.increase_resource_count()
	

func _spawn_effect(pos: Vector2):
	var effect = explosion_particle.instantiate()
	get_tree().root.add_child(effect)
	effect.global_position = pos

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
