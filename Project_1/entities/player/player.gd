extends CharacterBody3D

const ANGLE_ERROR: float = 0.01

@export var speed: float = 40
@onready var is_moving: bool = false
@onready var destination_pos: Vector3 = Vector3(0, 0, 0)
@onready var destination_rotation_y: float = self.rotation.y
@onready var cur_pos: Vector3 = get_parent().player_pos
@onready var cur_rotation: int = 1

func _ready():
	self.rotation.y = 0

func _physics_process(delta):
	# Moving.
	if is_moving:
		# Stepping.
		if self.position != destination_pos:
			self.position = self.position.move_toward(destination_pos, delta * speed)
		# Rotating.
		elif abs(abs(destination_rotation_y) - abs(self.rotation.y)) > ANGLE_ERROR and abs(abs(destination_rotation_y) - abs(self.rotation.y)) < PI:
			self.rotate_y(cur_rotation * (abs(abs(destination_rotation_y) - abs(self.rotation.y))) * delta * 7)
		# Stopping.
		else:
			self.rotation.y = destination_rotation_y
			is_moving = false
	move_and_slide()

func _on_btn_forward_pressed():
	if not is_moving:
		is_moving = true
		destination_pos = Main.move_player("forward")

func _on_btn_backward_pressed():
	if not is_moving:
		is_moving = true
		destination_pos = Main.move_player("backward")

func _on_btn_left_pressed():
	if not is_moving:
		is_moving = true
		cur_rotation = 1
		Main.turn_direction(cur_rotation)
		destination_rotation_y += PI/2
		if destination_rotation_y > PI:
			destination_rotation_y -= PI * 2

func _on_btn_right_pressed():
	if not is_moving:
		is_moving = true
		cur_rotation = -1
		Main.turn_direction(cur_rotation)
		destination_rotation_y -= PI/2
		if destination_rotation_y < -PI:
			destination_rotation_y += PI * 2
