extends Node2D

@onready var tilemaplayer = get_node("../TileMapLayer")

var map = []

var MAP_SIZE = 32

func _ready():
	var noise = FastNoiseLite.new()

	noise.frequency = 0.1
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
	noise.seed = randi()
	
	initialize_map_array()
	
	generate_map(noise, tilemaplayer)
	
	generate_visuals()
	
func initialize_map_array():
	for x in range(MAP_SIZE):
		map.append([])
		for y in range(MAP_SIZE):
			map[x].append(0)
			
func generate_map(noise, tilemaplayer):
	for x in range(MAP_SIZE):
		for y in range(MAP_SIZE):
			if(noise.get_noise_2d(x, y) > 0):
				map[x][y] = 1
			else:
				map[x][y] = 0
	
func generate_visuals():
	#put solid blocks into a list of vector2i s
	var solidblocklist : Array[Vector2i]
	for x in range(MAP_SIZE):
		for y in range(MAP_SIZE):
			if (map[x][y] == 1):
				solidblocklist.append(Vector2i(x,y))
	
	#now actually place the tiles
	tilemaplayer.set_cells_terrain_connect(solidblocklist, 0, 0, false)
