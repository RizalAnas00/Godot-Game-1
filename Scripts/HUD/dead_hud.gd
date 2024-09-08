extends CanvasLayer
signal restart
signal quit

@onready var canvas_layer: CanvasLayer = $"."

func _on_restart_button_pressed():
	canvas_layer.hide()
	restart.emit()

func _on_quit_button_pressed():
	canvas_layer.hide()
	quit.emit()
