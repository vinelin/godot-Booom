extends CharacterBody3D

const SPEED: float = 5.0
const DIRECTION: Array = ["N", "W", "S", "E"]
const DIR_VECTOR: Dictionary = {
								"N": Vector3(0, 0, -1), 
								"W": Vector3(-1, 0, 0),
								"S": Vector3(0, 0, 1),
								"E": Vector3(1, 0, 0)
								}
const ANGLE_ERROR: float = 0.01

@onready var is_moving: bool = false
@onready var destination_pos: Vector3 = Vector3(0, 1, 0)
@onready var destination_rotation_y: float = self.rotation.y
@onready var cur_pos: Vector3 = get_parent().player_pos
@onready var cur_direction: String = DIRECTION[0]
@onready var cur_rotation: int = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _process(delta):
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Moving.
	if is_moving:
		# Stepping.
		if self.position != destination_pos:
			self.position = self.position.move_toward(destination_pos, 0.5)
		# Rotating.
		elif abs(abs(destination_rotation_y) - abs(self.rotation.y)) > ANGLE_ERROR and abs(abs(destination_rotation_y) - abs(self.rotation.y)) < PI:
			self.rotate_y(cur_rotation * (abs(abs(destination_rotation_y) - abs(self.rotation.y))) * delta * 7)
		# Stopping.
		else:
			self.rotation.y = destination_rotation_y
			is_moving = false
	move_and_slide()
	
func _turn_direction(direction: int):
	var _cur_index = DIRECTION.find(cur_direction)
	if _cur_index + direction < 0:
		cur_direction = DIRECTION[-1]
	elif _cur_index + direction > len(DIRECTION) - 1:
		cur_direction = DIRECTION[0]
	else:
		cur_direction = DIRECTION[_cur_index + direction]

func _on_btn_forward_pressed():
	if not is_moving:
		is_moving = true
		destination_pos = self.position + 5 * DIR_VECTOR[cur_direction]

func _on_btn_backward_pressed():
	if not is_moving:
		is_moving = true
		destination_pos = self.position - 5 * DIR_VECTOR[cur_direction]

func _on_btn_left_pressed():
	if not is_moving:
		is_moving = true
		cur_rotation = 1
		_turn_direction(cur_rotation)
		destination_rotation_y += PI/2
		if destination_rotation_y > PI:
			destination_rotation_y -= PI * 2

func _on_btn_right_pressed():
	if not is_moving:
		is_moving = true
		cur_rotation = -1
		_turn_direction(cur_rotation)
		destination_rotation_y -= PI/2
		if destination_rotation_y < -PI:
			destination_rotation_y += PI * 2
