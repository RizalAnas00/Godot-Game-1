extends Node
signal start

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	pass
	
func _on_start_button_pressed():
	$startButton.hide()
	start.emit()
