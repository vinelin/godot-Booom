extends Node3D

@onready var player_pos: Vector3 = Vector3(0, 0, 0)

func _ready():
	Main.maze_generate(self, 5, 5)
