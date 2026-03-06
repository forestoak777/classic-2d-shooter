extends Area2D

@export var speed = -250

func start(pos, rot):
	position = pos
	rotation = rot
	
func _process(delta):
	position += Vector2.from_angle(rotation + deg_to_rad(90)) * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area.is_in_group("enemies"):
		area.explode()
		queue_free()
