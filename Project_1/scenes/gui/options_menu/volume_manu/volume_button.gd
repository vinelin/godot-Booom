extends Control


@onready var MasterVolumeSlider: HSlider = $HBoxContainer/HSlider


func _ready():
	MasterVolumeSlider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	MasterVolumeSlider.value_changed.connect(_on_slider_master_value_changed);


func _on_slider_master_value_changed(value):
	AudioServer.set_bus_volume_db(0, linear_to_db(value))
