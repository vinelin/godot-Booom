extends CanvasLayer

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready():
	opening()

func opening():
	anim_player.play("display")
	await anim_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/gui/main_menu/main_menu.tscn")
	anim_player.play("disappear")
	await anim_player.animation_finished
	self.queue_free()

func change_scene(target: String):
	pass
