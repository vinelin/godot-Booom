extends Node

const tile_length = 10

func level_init(node: Node, width: int, height: int):
	_add_player(node, Vector3(0, 0, 0))
	return _maze_generate(node, width, height)

func _maze_generate(node: Node, width: int, height: int):
	# Temp generation 
	var map: Array = []
	for x in range(width):
		map.append([])
		for y in range(height):
			map[x].append(0)
	# Instantiate floors
	for x in range(len(map)):
		for y in range(len(map[x])):
			if map[x][y] == 0:
				_add_floor(node, Vector3(0, 0, 0) + Vector3(x * tile_length, -1, y * -tile_length), "floor.tscn")
	return map

func _add_floor(node: Node, pos: Vector3, type: String):
	var floor = load("res://entities/environment/floor/" + type).instantiate()
	floor.position = pos
	node.add_child(floor)

func _add_player(node: Node, pos: Vector3):
	var player = load("res://entities/player/player.tscn").instantiate()
	player.position = pos
	node.add_child(player)

