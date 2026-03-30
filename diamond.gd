extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.player_trigger_money_add(5000)
		queue_free()
