extends Node
class_name Tile

@onready var x: int
@onready var y: int
@onready var is_visited: bool
@onready var prev_node: Node
@onready var next_node: Node
@onready var has_wall: Array # Order: N W S E. Usage: [true, true, true, true]
@onready var tile_type: String # enemy_1, treasure, exit...etc
@onready var floor_type: String #"floor.tscn"
