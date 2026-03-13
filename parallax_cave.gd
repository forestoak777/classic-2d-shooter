extends Sprite2D

@onready var player = get_tree().get_first_node_in_group("player")

@export var parallax1sprites : Array[Sprite2D] = []
@export var parallax2sprites : Array[Sprite2D]= []
@export var parallax3sprites : Array[Sprite2D]= []

var parallaxtoswap1 = 0
var parallaxtoswap2 = 0
var parallaxtoswap3 = 0

func _switch_parallax_to_use(what):
	if(what == 1):
		if (parallaxtoswap1 == 0):
			parallaxtoswap1 = 1
		else:
			parallaxtoswap1 = 0
	elif (what == 2):
		if (parallaxtoswap2 == 0):
			parallaxtoswap2 = 1
		else:
			parallaxtoswap2 = 0
	elif (what == 3):
		if (parallaxtoswap3 == 0):
			parallaxtoswap3 = 1
		else:
			parallaxtoswap3 = 0

#func _process(delta):
	#do parallax movement
#	if(player.position > parallax1sprites[parallaxtoswap1].get_rect().size.x + parallax1sprites[parallaxtoswap1].position.x):
		
		#_switch_parallax_to_use(1)
