extends Node

var resourceCount = 0
@export var resourceAdder = 20
@onready var resource_text : Label = get_tree().get_first_node_in_group("resource_text")

func increase_resource_count():
	resourceCount += resourceAdder
	resource_text.text = "Resource: " + str(resourceCount)
