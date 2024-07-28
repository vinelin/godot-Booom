extends Control

func _on_btn_yes_pressed():
	get_tree().quit()

func _on_btn_no_pressed():
	self.hide()
