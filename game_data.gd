extends Node

var resourceCount = 1000
@export var resourceSubtractor = 20
@export var resourceAdder = 100
@onready var resource_text : Label = get_tree().get_first_node_in_group("resource_text")

var moneyCount = 0
@onready var money_text : Label = get_tree().get_first_node_in_group("money_text")

@onready var phase_time_text : Label = get_tree().get_first_node_in_group("time_text")

@export var phase_time_start = 120
var current_phase_time = 120

func _process(delta):
	current_phase_time -= delta
	_update_current_phase_time_text()

func _update_current_phase_time_text():
	phase_time_text.text = "Time Remaining: " + str(roundi(current_phase_time))

func increase_resource_count():
	resourceCount += resourceAdder
	_update_resource_text()

func decrease_resource_count():
	resourceCount -= resourceSubtractor
	_update_resource_text()

func _update_resource_text():
	resource_text.text = "Resource: " + str(resourceCount)

func trigger_money_add(amt):
	moneyCount += amt
	_update_money_text()

func _update_money_text():
	money_text.text = "Money: " + str(moneyCount)

@export var upgrade_panel : Panel

func _on_toggle_upgrades_panel_pressed():
	if upgrade_panel.visible == true:
		upgrade_panel.visible = false
	else:
		upgrade_panel.visible = true
