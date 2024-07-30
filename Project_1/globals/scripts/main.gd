extends Node

const DIRECTION: Array = ["N", "W", "S", "E"]
const DIR_VECTOR: Dictionary = {
								"N": Vector3(0, 0, -1), 
								"W": Vector3(-1, 0, 0),
								"S": Vector3(0, 0, 1),
								"E": Vector3(1, 0, 0)
								}

@onready var player_pos: Vector3 = Vector3(0, 0, 0) # Z axis need to be negative when use
@onready var cur_direction: String = DIRECTION[0]
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

func move_player(direction: String):
	# TODO: Detect walls
	var _temp_pos: Vector3
	if direction == "forward":
		_temp_pos = player_pos + DIR_VECTOR[cur_direction]
		if _check_is_passage(_temp_pos):
			player_pos += DIR_VECTOR[cur_direction]
	elif direction == "backward":
		_temp_pos = player_pos - DIR_VECTOR[cur_direction]
		if _check_is_passage(_temp_pos):
			player_pos -= DIR_VECTOR[cur_direction]
	else:
		print("unknown direction to move")
	return player_pos * Vector3(tile_length, 1, tile_length)

func _check_is_passage(pos: Vector3):
	pos.z = pos.z * -1
	if pos.x >= 0 and pos.x < len(cur_map) and pos.z >= 0 and pos.z < len(cur_map[0]) and cur_map[pos.x][pos.z] == 0: # 0 for temp floor type
		return true
	else:
		return false
