extends CanvasLayer

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready():
	self.visible = false

func change_to_battle(player: Node, type: String):
	if type == "wall_test":
		self.visible = true
		anim_player.play("display")
		await anim_player.animation_finished
		Main.is_in_battle = true
		player.position.y = 1000
		_add_floor(player.get_parent(), player.position, "floor.tscn", Main.cur_direction)
		_add_wall(player.get_parent(),  player.position, "wall_test.tscn", Main.cur_direction)
		_add_enemy(player.get_parent(), player.position, "enemy_test.tscn", Main.cur_direction)
		anim_player.play("disappear")
		await anim_player.animation_finished
		self.visible = false

func _add_floor(node: Node, pos: Vector3, type: String, direction: String):
	var distance = 10
	var floor = load("res://entities/environment/floor/" + type).instantiate()
	if direction == "N":
		floor.position = pos + Vector3.FORWARD * distance
	elif direction == "S":
		floor.position = pos + Vector3.BACK * distance
	elif direction == "W":
		floor.rotation.y = PI * 0.5
		floor.position = pos + Vector3.LEFT * distance
	elif direction == "E":
		floor.rotation.y = PI * 0.5
		floor.position = pos + Vector3.RIGHT * distance
	else:
		print("Unknown direction: " + direction)
	node.add_child(floor)
	
func _add_wall(node: Node, pos: Vector3, type: String, direction: String):
	var distance = 12
	var wall = load("res://entities/environment/wall/" + type).instantiate()
	wall.position = pos
	if direction == "N":
		wall.position = pos + Vector3.FORWARD * distance
	elif direction == "S":
		wall.position = pos + Vector3.BACK * distance
	elif direction == "W":
		wall.rotation.y = PI * 0.5
		wall.position = pos + Vector3.LEFT * distance
	elif direction == "E":
		wall.rotation.y = PI * 0.5
		wall.position = pos + Vector3.RIGHT * distance
	else:
		print("Unknown direction: " + direction)
	node.add_child(wall)

func _add_enemy(node: Node, pos: Vector3, type: String, direction: String):
	var distance = 10
	var enemy = load("res://entities/enemies/enemy_test/" + type).instantiate()
	if direction == "N":
		enemy.position = pos + Vector3.FORWARD * distance
	elif direction == "S":
		enemy.position = pos + Vector3.BACK * distance
	elif direction == "W":
		enemy.position = pos + Vector3.LEFT * distance
	elif direction == "E":
		enemy.position = pos + Vector3.RIGHT * distance
	else:
		print("Unknown direction: " + direction)
	Main.cur_enemy = enemy
	node.add_child(enemy)
