extends Node

@onready var player_pos: Vector3 = Vector3(0, 0, 0)

func maze_generate(node: Node, width: int, height: int):
	# Temp generation 
	var _map: Array = []
	for x in range(width):
		_map.append([])
		for y in range(height):
			_map[x].append(0)
	# Instantiate floors
	for x in range(len(_map)):
		for y in range(len(_map[x])):
			if _map[x][y] == 0:
				_add_floor(node, Vector3(0, 0, 0) + Vector3(x * 10, 0, y * -10), "floor.tscn")

func _add_floor(node: Node, pos: Vector3, type: String):
	var floor = load("res://entities/environment/floor/" + type).instantiate()
	floor.position = pos
	node.add_child(floor)

