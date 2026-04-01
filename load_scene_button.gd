extends Button

@export var sceneToLoad : PackedScene

func _on_pressed():
	get_tree().change_scene_to_packed(sceneToLoad)
