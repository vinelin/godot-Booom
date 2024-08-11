extends Control


@onready var sfxVolumeSlider: HSlider = $HBoxContainer/HSlider


func _ready():
	sfxVolumeSlider.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	sfxVolumeSlider.value_changed.connect(_on_slider_sfx_value_changed);


func _on_slider_sfx_value_changed(value):
	AudioServer.set_bus_volume_db(2, linear_to_db(value))
