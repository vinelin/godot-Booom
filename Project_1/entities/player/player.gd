extends CharacterBody3D

const ANGLE_ERROR: float = 0.01

@export var speed: float = 40.0
@onready var anim_player: AnimationPlayer = %"PlayerAnimator"
@onready var is_moving: bool = false
@onready var cur_pos: Vector3 = Main.player_pos
@onready var cur_rotation: int = 1
@onready var destination_pos: Vector3 = cur_pos * Vector3(Main.tile_length, 1, Main.tile_length)
@onready var destination_rotation_y: float = self.rotation.y

func _ready():
	self.rotation.y = 0
	anim_player.play("idle")

func _process(delta):
	if Input.is_action_pressed("move_backward"):
		_on_btn_backward_pressed()
	if Input.is_action_pressed("move_forward"):
		_on_btn_forward_pressed()
	if Input.is_action_pressed("turn_left"):
		_on_btn_left_pressed()
	if Input.is_action_pressed("turn_right"):
		_on_btn_right_pressed()

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
