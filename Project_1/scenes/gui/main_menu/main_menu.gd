extends Control

@onready var sfx_pressed: AudioStreamPlayer = $MarginContainer/VBoxContainer/VBoxButtons/sfx_pressed
@onready var quit_menu: Control = $quit_menu
@onready var options_menu: Control = $options_menu

func _ready():
	options_menu.hide()
	quit_menu.hide()

func _process(delta):
	if Input.is_action_just_pressed("esc") and options_menu.visible == false:
		sfx_pressed.play()
		quit_menu.show()

func _on_btn_play_pressed():
	sfx_pressed.play()
	get_tree().change_scene_to_file("res://scenes/level/level_1/level_1.tscn")

func _on_btn_options_pressed():
	sfx_pressed.play()
	options_menu.show()

func _on_btn_quit_pressed():
	sfx_pressed.play()
	quit_menu.show()
