extends CanvasLayer

signal completed

func _on_button_pressed():
	hide()
	completed.emit()
