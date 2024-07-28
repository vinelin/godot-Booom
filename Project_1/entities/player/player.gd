extends CharacterBody3D

const SPEED: float = 5.0
const DIRECTION: Array = ["N", "E", "S", "W"]
const DIR_VECTOR: Dictionary = {"N": Vector3(0, 0, -1), 
								"E": Vector3(1, 0, 0),
								"S": Vector3(0, 0, 1),
								"W": Vector3(-1, 0, 0)}

@onready var is_moving: bool = false
@onready var destination: Vector3 = self.position
@onready var cur_pos: Vector3 = get_parent().player_pos
@onready var cur_direction: String = DIRECTION[0]

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _process(delta):
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Moving.
	if is_moving and self.position != destination:
		self.position = self.position.move_toward(destination, 1.0)
	if self.position == destination:
		is_moving = false
	
	# TODO: Rotating.
	move_and_slide()
	
func _turn_direction(direction: int):
	var _cur_index = DIRECTION.find(cur_direction)
	if _cur_index + direction < 0:
		cur_direction = DIRECTION[-1]
	elif _cur_index + direction > len(DIRECTION) - 1:
		cur_direction = DIRECTION[0]
	else:
		cur_direction = DIRECTION[_cur_index + direction]
	print(cur_direction)

func _on_btn_forward_pressed():
	if not is_moving:
		is_moving = true
		destination = self.position + 5 * DIR_VECTOR[cur_direction]

func _on_btn_backward_pressed():
	if not is_moving:
		is_moving = true
		destination = self.position - 5 * DIR_VECTOR[cur_direction]

func _on_btn_left_pressed():
	if not is_moving:
		is_moving = true
		rotate_y(PI/2)
		_turn_direction(-1)
		# TODO: await and reset is_moving

func _on_btn_right_pressed():
	if not is_moving:
		is_moving = true
		rotate_y(-PI/2)
		_turn_direction(1)
		# TODO: await and reset is_moving
