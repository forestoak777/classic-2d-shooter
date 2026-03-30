extends Node2D

@onready var tilemaplayer = get_node("../TileMapLayer")

var map = []

var MAP_SIZE = 128

@onready var player = get_node("../Player")

@export var resourceAddScene : PackedScene

@export var diamond : PackedScene


func _ready():

	
	initialize_map_array()
	
	generate_map(tilemaplayer)
	
	generate_visuals()
	
	generate_resource_add_pickups()
	
	generate_diamond_pickups()
	
func initialize_map_array():
	for x in range(MAP_SIZE):
		map.append([])
		for y in range(MAP_SIZE):
			map[x].append(0)

func generate_resource_add_pickups():
	for x in range(MAP_SIZE):
		for y in range(MAP_SIZE):
			var rand = randf()
			if rand >= 0.98:
				var b = resourceAddScene.instantiate()
				get_tree().root.add_child.call_deferred(b)
				b.position = Vector2(x * 16,y * 16)

func generate_diamond_pickups():
	for x in range(MAP_SIZE):
		for y in range(MAP_SIZE):
			var rand = randf()
			if rand >= 0.995:
				var b = diamond.instantiate()
				get_tree().root.add_child.call_deferred(b)
				b.position = Vector2(x * 16,y * 16)

func generate_map(tilemaplayer):

	#first put in the initial perlin cave gen
	var noise = FastNoiseLite.new()
	noise.frequency = 0.1
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
	noise.seed = randi()
	for x in range(MAP_SIZE):
		for y in range(MAP_SIZE):
			if(noise.get_noise_2d(x, y) > 0):
				map[x][y] = 1
	
	#Now we're gonna multpily this by the cellular noise
	noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_CELLULAR
	noise.frequency = 0.03
	noise.domain_warp_enabled = true
	noise.domain_warp_amplitude = 70
	noise.domain_warp_frequency = 0.02
	noise.domain_warp_type = FastNoiseLite.DOMAIN_WARP_SIMPLEX_REDUCED

	for x in range(MAP_SIZE):
		for y in range(MAP_SIZE):
			if(noise.get_noise_2d(x, y) < -0.8):
				map[x][y] = 0
	
	#Add borders
	for x in range(MAP_SIZE):
		for y in range(MAP_SIZE):
			if(x==0 || x == MAP_SIZE - 1):
				map[x][y] = 1
			if (y==0 || y == MAP_SIZE - 1):
				map[x][y] = 1
	
	#Make sure player start space is unblocked
	map[1][1] = 0
	map[1][2] = 0
	map[2][1] = 0
	map[2][2] = 0
	
	
func generate_visuals():
	#put solid blocks into a list of vector2i s
	var solidblocklist : Array[Vector2i] = []
	for x in range(MAP_SIZE):
		var line = ""
		for y in range(MAP_SIZE):
			#print grid to console
			if (map[x][y] == 1):
				line += "#"
				solidblocklist.append(Vector2i(x,y))
			else:
				line += " "
		print(line)
	
	#now actually place the tiles
	tilemaplayer.set_cells_terrain_connect(solidblocklist, 0, 0, false)
