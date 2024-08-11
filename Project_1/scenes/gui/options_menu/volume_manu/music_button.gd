extends Control


@onready var MusicVolumeSlider: HSlider = $HBoxContainer/HSlider


func _ready():
	MusicVolumeSlider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	MusicVolumeSlider.value_changed.connect(_on_slider_music_value_changed);


func _on_slider_music_value_changed(value):
	AudioServer.set_bus_volume_db(1, linear_to_db(value))
