extends Control

@onready var MasterVolumeSlider: HSlider = $MarginContainer/TabContainer/VBoxOptions/VBoxVolume/slider_master
@onready var MusicVolumeSlider: HSlider = $MarginContainer/TabContainer/VBoxOptions/VBoxVolume/slider_music
@onready var sfxVolumeSlider: HSlider = $MarginContainer/TabContainer/VBoxOptions/VBoxVolume/slider_sfx
@onready var sfx_pressed: AudioStreamPlayer = $MarginContainer/TabContainer/VBoxOptions/sfx_pressed

func _ready():
	MasterVolumeSlider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	MusicVolumeSlider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	sfxVolumeSlider.value = db_to_linear(AudioServer.get_bus_volume_db(2))

func _process(delta):
	if Input.is_action_just_pressed("esc") :
		sfx_pressed.play()
		self.hide()

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
	self.hide()
