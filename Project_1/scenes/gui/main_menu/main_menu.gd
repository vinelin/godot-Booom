extends Control

@onready var sfx_pressed: AudioStreamPlayer = $MarginContainer/VBoxContainer/VBoxButtons/sfx_pressed
#@onready var options_menu: Control = $options_menu
#var esc = false

func _ready():
	$options_menu.hide()

#func _process(delta):
	#if Input.is_action_just_pressed("esc"):
		#pass
	#
#func quitMenu

func _on_btn_play_pressed():
	sfx_pressed.play()
	get_tree().change_scene_to_file("res://scenes/level/level_1/level_1.tscn")

func _on_btn_options_pressed():
	sfx_pressed.play()
	get_tree().change_scene_to_file("res://scenes/gui/options_menu/options_menu.tscn")

func _on_btn_quit_pressed():
	sfx_pressed.play()
	get_tree().quit()
