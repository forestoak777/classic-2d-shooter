extends Area2D

@export var sceneToLoad : PackedScene

func _on_body_entered(body):
	if (body == get_tree().get_first_node_in_group("player")):
		get_tree().change_scene_to_packed(sceneToLoad)
