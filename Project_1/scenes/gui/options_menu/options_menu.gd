extends Control

@onready var MasterVolumeSlider: HSlider = $MarginContainer/VBoxOptions/VBoxVolume/slider_master
@onready var MusicVolumeSlider: HSlider = $MarginContainer/VBoxOptions/VBoxVolume/slider_music
@onready var sfxVolumeSlider: HSlider = $MarginContainer/VBoxOptions/VBoxVolume/slider_sfx

@onready var sfx_pressed: AudioStreamPlayer = $MarginContainer/VBoxOptions/sfx_pressed


func _ready():
	MasterVolumeSlider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	MusicVolumeSlider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	sfxVolumeSlider.value = db_to_linear(AudioServer.get_bus_volume_db(2))

func _on_slider_master_value_changed(value):
	sfx_pressed.play()
	AudioServer.set_bus_volume_db(0, linear_to_db(value))

func _on_slider_music_value_changed(value):
	sfx_pressed.play()
	AudioServer.set_bus_volume_db(1, linear_to_db(value))

func _on_slider_sfx_value_changed(value):
	sfx_pressed.play()
	AudioServer.set_bus_volume_db(2, linear_to_db(value))

func _on_back_pressed():
	sfx_pressed.play()
	get_tree().change_scene_to_file("res://scenes/gui/main_menu/main_menu.tscn")
