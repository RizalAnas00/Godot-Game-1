extends Node2D

@onready var button: Button = $Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect the button's "pressed" signal to the custom function
	button.connect("pressed", Callable(self, "_on_button_pressed"))

# Function triggered when the button is pressed
func _on_button_pressed() -> void:
	# Change to the MAIN scene
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
