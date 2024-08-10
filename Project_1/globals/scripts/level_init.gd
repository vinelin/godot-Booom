extends Node

const tile_length = 10

func level_init(node: Node, width: int, height: int):
	var init_x = randi_range(0, width - 1)
	var init_y = randi_range(0, height - 1)
	Main.player_pos = Vector3(init_x, Main.camera_height, init_y * -1)
	_add_player(node, Vector3(init_x, Main.camera_height, init_y * -1) * Vector3(tile_length, 1, tile_length)) 
	return _maze_generate(node, width, height, init_x, init_y)

func _maze_generate(node: Node, width: int, height: int, init_x: int, init_y: int):
	# Implement generation with Randomized DFS 
	var map: Array = []
	var cur_Node: Node
	for x in range(width):
		map.append([])
		for y in range(height):
			var _temp_Node = Tile.new()
			_temp_Node.is_visited = false
			_temp_Node.has_wall = [true, true, true, true]
			_temp_Node.floor_type = "floor.tscn"
			_temp_Node.x = x
			_temp_Node.y = y
			map[x].append(_temp_Node)
	cur_Node = map[init_x][init_y]
	
	var count: int = 0
	while count < width * height:
		cur_Node.is_visited = true
		count += 1
		var neighbor_status: Array = _check_neighbor_status(cur_Node, map, width, height)
		var next_direction: String
		var temp_Node: Node
		if neighbor_status.has(1):
			next_direction = Main.DIRECTION[_random_index_weighted(neighbor_status)]
			if next_direction == "N":
				temp_Node = map[cur_Node.x][cur_Node.y + 1]
				cur_Node.has_wall[0] = false
				temp_Node.has_wall[2] = false
			elif next_direction == "W":
				temp_Node = map[cur_Node.x - 1][cur_Node.y]
				cur_Node.has_wall[1] = false
				temp_Node.has_wall[3] = false
			elif next_direction == "S":
				temp_Node = map[cur_Node.x][cur_Node.y - 1]
				cur_Node.has_wall[2] = false
				temp_Node.has_wall[0] = false
			elif next_direction == "E":
				temp_Node = map[cur_Node.x + 1][cur_Node.y]
				cur_Node.has_wall[3] = false
				temp_Node.has_wall[1] = false
			# Set node info
			cur_Node.next_node = temp_Node
			temp_Node.prev_node = cur_Node
			cur_Node = temp_Node
		else:
			cur_Node = cur_Node.prev_node
			
	# Test For Fun
	_test_add_goal(node, map, 1)
	_add_enemies(node, map, 15)
	
	# Instantiate floors and walls
	for x in range(len(map)):
		for y in range(len(map[x])):
			_add_floor(node, Vector3(x * tile_length, -1, y * -tile_length), map[x][y].floor_type)
			_add_floor(node, Vector3(x * tile_length, 8, y * -tile_length), map[x][y].floor_type)
			if map[x][y].has_wall[2]:
				_add_wall(node, Vector3(x * tile_length, 4, y * -tile_length) + Vector3(0, 0, tile_length * 0.5), "wall_test.tscn", 0)
			if map[x][y].has_wall[0]:
				_add_wall(node, Vector3(x * tile_length, 4, y * -tile_length) + Vector3(0, 0, tile_length * -0.5), "wall_test.tscn", 0)
			if map[x][y].has_wall[1]:
				_add_wall(node, Vector3(x * tile_length, 4, y * -tile_length) + Vector3(tile_length * -0.5, 0, 0), "wall_test.tscn", PI * 0.5)
			if map[x][y].has_wall[3]:
				_add_wall(node, Vector3(x * tile_length, 4, y * -tile_length) + Vector3(tile_length * 0.5, 0, 0), "wall_test.tscn", PI * 0.5)
	return map

func _add_floor(node: Node, pos: Vector3, type: String):
	var floor = load("res://entities/environment/floor/" + type).instantiate()
	floor.position = pos
	node.add_child(floor)
	
func _add_wall(node: Node, pos: Vector3, type: String, rotation_y: float):
	var wall = load("res://entities/environment/wall/" + type).instantiate()
	wall.position = pos
	wall.rotation.y = rotation_y
	node.add_child(wall)

func _test_add_goal(node: Node, map: Array, number_limit: int):
	var _count: int = 0
	for x in range(len(map)):
		for y in range(len(map[x])):
			if map[x][y].has_wall.count(true) == 3:
				map[x][y].tile_type = "goal"
				var goal = load("res://entities/environment/goal_test.tscn").instantiate()
				goal.position = Vector3(x, 2, -y) * Vector3(tile_length, 1, tile_length)
				node.add_child(goal)
				_count += 1
				break
		if _count >= number_limit:
			break

func _add_enemies(node: Node, map: Array, number_limit: int):
	var _count: int = 0
	for x in range(len(map)):
		for y in range(len(map[x])):
			if map[x][y].has_wall.count(true) == 2 and randi_range(1,10) < 4:
				map[x][y].tile_type = "enemy" #no need if enemy can move
				var enemy = load("res://entities/enemies/enemy_test/enemy_test.tscn").instantiate()
				enemy.position = Vector3(x, 2, -y) * Vector3(tile_length, 1, tile_length)
				node.add_child(enemy)
				_count += 1
				break
		if _count >= number_limit:
			break

func _add_player(node: Node, pos: Vector3):
	var player = load("res://entities/player/player.tscn").instantiate()
	player.position = pos
	Main.player = player
	node.add_child(player)

func _check_neighbor_status(node: Node, map: Array, width: int, height: int):
	# Order: N W S E
	var neighbor_status: Array = [0, 0, 0, 0]
	if node.y < height - 1 and !map[node.x][node.y + 1].is_visited:
		neighbor_status[0] = 1
	if node.x > 0 and !map[node.x - 1][node.y].is_visited:
		neighbor_status[1] = 1
	if node.y > 0 and !map[node.x][node.y - 1].is_visited:
		neighbor_status[2] = 1
	if node.x < width - 1 and !map[node.x + 1][node.y].is_visited:
		neighbor_status[3] = 1
	return neighbor_status

func _random_index_weighted(weights: Array):
	var total_weight: float = 0.0
	for weight in weights:
		total_weight += weight
	var remaining_distance: float = randf() * total_weight
	for i in weights.size():
		remaining_distance -= weights[i]
		if remaining_distance < 0:
			return i
