extends Node

var score = 0
var total_coins = 0
var finish = false
var pos_platform
var pos_player

signal switch_lvl

@onready var score_label: Label = $ScoreLabel
@onready var coins: Node = %Coins
@onready var completed: CanvasLayer = $"../Completed"
@onready var labels: Node = $"../Labels"
@onready var player: CharacterBody2D = $"../Player"
@onready var platform_3: AnimatableBody2D = $"../Platforms/Platform3"
@onready var killzone: Area2D = $"../Killzone"
@onready var timer: Timer = $"../Timer"

func _ready():
	var all_coins = coins.get_child_count()
	total_coins += all_coins
	completed.hide()

func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " / " + str(total_coins) + " coins!"
	if (score == total_coins):
		finish = true #flag for finish the level
		
		player.collision_layer = 1 #change the collision layer so it can't die
		player.modulate = Color(1,1,1,0.7)
		
		await get_tree().create_timer(1.0).timeout 
		player.modulate = Color(1,1,1,1)
		completed.show()

		#get the platform position to teleport the player to it
		score_label.text = "You collected ALL " + str(total_coins) + " coins! Amazing"
		pos_player = player
		platform_3.get_node("AnimationPlayer").queue_free()
		pos_platform = platform_3
		
		# Stop horizontal movement by setting velocity.x to 0
		player.velocity.x = 0
		player.death_and_jump()
		
		#change the camera zoom
		var zooming = player.get_node("Camera2D")
		zooming.zoom = Vector2(3,3)
		
		
		pos_player.position = pos_platform.position
		labels.get_node("Label7").queue_free()
		player.idle_player()

func _on_completed_completed():
	print("Level Completed Signal Emitted")
	switch_lvl.emit()
