extends Area2D

@onready var game_manager: Node = %"Game Manager"
@onready var game_manager_2: Node = %"Game Manager"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var level = 1

func _on_body_entered(body: Node2D):
	# ------- THIS IS SHIT, NEED TO BE FIXED -------
	# -----  NO HARD CODING PLEASE -------------
	print(" +1 Coin")
	if game_manager:
		game_manager.add_point()
		animation_player.play("pickup_animation")
	elif game_manager_2:
		game_manager_2.add_point()
		animation_player.play("pickup_animation")
