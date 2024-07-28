extends AudioStreamPlayer

@onready var bgm_menu: AudioStreamPlayer = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _play():
	bgm_menu.stop()
	#var stream = load("res://y2051.mp3")
	#bgm_menu.stream = stream
	bgm_menu.play()
