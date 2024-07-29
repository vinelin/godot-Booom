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
	if direction == "forward":
		player_pos += DIR_VECTOR[cur_direction]
	elif direction == "backward":
		player_pos -= DIR_VECTOR[cur_direction]
	else:
		print("unknown direction to move")
	return player_pos * Vector3(tile_length, 1, tile_length)
