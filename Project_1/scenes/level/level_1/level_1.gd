extends Node3D

@onready var player_pos: Vector3 = Vector3(0, 0, 0)
@onready var map: Array = [0, 0, 0, 0, 0]

func _ready():
	# Set the map matrix. Width then Height. 
	for x in range(len(map)):
		map[x]=[0, 0, 0, 0, 0]
		for y in range(len(map[x])):
			map[x][y]=0
	print(map)
	
	# Instantiate floors
	for x in range(len(map)):
		for y in range(len(map[x])):
			if map[x][y] == 0:
				_add_floor(player_pos + Vector3(x * 10, 0, y * -10), "floor.tscn")
	#for _i in self.get_children():
		#print(_i)

func _add_floor(pos: Vector3, type: String):
	var floor = load("res://entities/environment/floor/" + type).instantiate()
	floor.position = pos
	self.add_child(floor)
