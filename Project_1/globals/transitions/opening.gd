extends CanvasLayer

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready():
	anim_player.play("display")
	await anim_player.animation_finished
	anim_player.play("disappear")
	await anim_player.animation_finished
	Music.play("bgm_manu.mp3", true)
	get_tree().change_scene_to_file("res://scenes/gui/main_menu/main_menu.tscn")
