extends Control


@onready var sfx_pressed: AudioStreamPlayer = $sfx_pressed


func _process(delta)->void:
	if Input.is_action_just_pressed("esc") && self.visible == true :
		sfx_pressed.play()
		self.hide()


func _on_back_pressed():
	sfx_pressed.play()
	self.hide()


func _on_tab_container_tab_clicked(tab):
	sfx_pressed.play()
