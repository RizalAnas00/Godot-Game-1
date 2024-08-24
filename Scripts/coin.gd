extends Area2D

@onready var game_manager: Node = %"Game Manager"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D):
	print(" +1 Coin")
	game_manager.add_point()
	animation_player.play("pickup_animation")
