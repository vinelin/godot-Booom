extends CharacterBody3D

@export var ATTACK_INTERVAL: float = randf_range(2.0, 5.0)
@export var health: float = 100.0

@onready var is_idle: bool = true
@onready var attack_interval: float = 0.0
@onready var attack_damage: float = 20.0

func _process(delta):
	if is_idle and Main.is_in_battle and Main.cur_enemy == self:
		attack_interval += delta
		if attack_interval >= ATTACK_INTERVAL:
			attack_interval = 0
			is_idle = false
			Main.enemy_attack(attack_damage)
