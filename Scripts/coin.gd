extends Area2D

@onready var game_manager: Node = %"Game Manager"

func _on_body_entered(body: Node2D):
	game_manager.add_point()
	queue_free()
