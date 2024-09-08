extends Node  # Use Node as the base class

signal switch_lvl

var score = 0
var total_coins = 0
var finish = false
var pos_platform
var pos_player
var player_spawn
var camera: Camera2D
var animate_camera

var first_pos
#signal can_double_jump

@onready var coins: Node = $"../Coins"
@onready var score_label: Label = $ScoreLabel

func _ready():
	total_coins = coins.get_child_count()
	
	# Load the player scene from file
	var player_scene = preload("res://Scenes/player.tscn")
	
	# Instance the player scene
	player_spawn = player_scene.instantiate()
	player_spawn.set_current_level(2)
	#player_spawn.connect("can_double_jump", Callable(self, "double_jump"))
	player_spawn.idle_player()
	first_pos = player_spawn.position
	
	# Add the player instance to the scene
	add_child(player_spawn)
	print("Player Spawned!")
		
	# Create an instance of Camera2D and add it to the player
	camera = Camera2D.new()
	player_spawn.add_child(camera)

	# Create a Tween using create_tween()
	var tween = create_tween()
	
	# Animate the zoom property of the camera
	tween.tween_property(camera, "zoom", Vector2(2.3, 2.3), 0.5).set_delay(0.5)
	
	# Connect the tween completion to start another zoom
	tween.connect("finished", Callable(self, "_on_tween_completed"))
	
func _on_tween_completed():
	# Start another zoom after the first one completes
	var tween = create_tween()
	tween.tween_property(camera, "zoom", Vector2(4, 4), 1.6).set_trans(Tween.TRANS_QUAD)

	tween.connect("finished", Callable(self, "_on_second_tween_completed"))

func _on_second_tween_completed():
	
	player_spawn.enable_player()
	camera.limit_bottom = 100 

func _process(delta: float) -> void:
	pass

func add_point():
	score += 1

	score_label.text = str(score)
	if score == total_coins:
		player_spawn.collision_layer = 1 #change the collision layer so it can't die
		player_spawn.modulate = Color(1,1,1,0.7)
		player_spawn.position = Vector2(135, -364)
		
		var finish = preload("res://Scenes/completed.tscn")
		var complete_hud = finish.instantiate()
		add_child(complete_hud)
		
		complete_hud.connect("completed", Callable(self, "_on_completed_completed"))
		
func _on_completed_completed():
	print("Level Completed Signal Emitted")
	switch_lvl.emit()
		
