extends Area2D

signal died 

var speed = 20
var bullet_scene = preload("res://enemy_bullet.tscn")

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

func explode():
	speed = 0
	$AnimationPlayer.play("explode")
	set_deferred("monitorable", false)
	died.emit(5)
	await $AnimationPlayer.animation_finished
	queue_free()
