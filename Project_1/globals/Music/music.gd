extends Control

@onready var music: AudioStreamPlayer = $music

func play(fileName: String, is_loop: bool):
	music.stop()
	var stream = load("res://globals/Music/" + fileName)
	music.stream = stream
	music.stream.loop = is_loop
	music.play()
