extends Node

const DIRECTION: Array = ["N", "W", "S", "E"]
const DIR_VECTOR: Dictionary = {
								"N": Vector3(0, 0, -1), 
								"W": Vector3(-1, 0, 0),
								"S": Vector3(0, 0, 1),
								"E": Vector3(1, 0, 0)
								}

@onready var player_pos: Vector3 # Z axis need to be negative when use
@onready var camera_height: float = 2.0
@onready var cur_direction: String = DIRECTION[0]
@onready var cur_backward: String = DIRECTION[2]
@onready var cur_map: Array = []
@onready var tile_length = LevelInit.tile_length

func get_map_info(map: Array):
	cur_map = map

func turn_direction(direction: int):
	var _cur_index = DIRECTION.find(cur_direction)
	if _cur_index + direction < 0:
		cur_direction = DIRECTION[-1]
	elif _cur_index + direction > len(DIRECTION) - 1:
		cur_direction = DIRECTION[0]
	else:
		cur_direction = DIRECTION[_cur_index + direction]
	if DIRECTION.find(cur_direction) + 2 > len(DIRECTION) - 1:
		cur_backward = DIRECTION[DIRECTION.find(cur_direction) - 2]
	else:
		cur_backward = DIRECTION[DIRECTION.find(cur_direction) + 2]

func move_player(direction: String):
	# TODO: Detect walls
	var _temp_pos: Vector3
	if direction == "forward":
		_temp_pos = player_pos + DIR_VECTOR[cur_direction]
		if _check_is_passage(player_pos, _temp_pos, direction):
			player_pos += DIR_VECTOR[cur_direction]
	elif direction == "backward":
		_temp_pos = player_pos - DIR_VECTOR[cur_direction]
		if _check_is_passage(player_pos, _temp_pos, direction):
			player_pos -= DIR_VECTOR[cur_direction]
	else:
		print("unknown direction to move")
	return player_pos * Vector3(tile_length, 1, tile_length)

func _check_is_passage(player_pos: Vector3, forward_pos: Vector3, direction: String):
	player_pos.z = player_pos.z * -1
	forward_pos.z = forward_pos.z * -1
	if direction == "forward":
		if (
			forward_pos.x >= 0 and forward_pos.x < len(cur_map) and forward_pos.z >= 0 and forward_pos.z < len(cur_map[0]) 
			and !cur_map[forward_pos.x][forward_pos.z].has_wall[(DIRECTION.find(cur_backward))]
			and !cur_map[player_pos.x][player_pos.z].has_wall[DIRECTION.find(cur_direction)]
		): 
			return true
		else:
			return false
	elif direction == "backward":
		if (
			forward_pos.x >= 0 and forward_pos.x < len(cur_map) and forward_pos.z >= 0 and forward_pos.z < len(cur_map[0]) 
			and !cur_map[forward_pos.x][forward_pos.z].has_wall[(DIRECTION.find(cur_direction))]
			and !cur_map[player_pos.x][player_pos.z].has_wall[DIRECTION.find(cur_backward)]
		): 
			return true
		else:
			return false
	else:
		print("unknown direction to move")
		return false
