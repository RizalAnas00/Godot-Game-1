extends Area2D

@onready var timer: Timer = $Timer
@onready var hurt_sfx: AudioStreamPlayer2D = $hurtSFX
@onready var level_1: Node2D = $".."
@onready var dead_hud: CanvasLayer = $dead_hud
var player: CharacterBody2D
	
func _ready():
	# Ensure dead_hud is hidden initially
	dead_hud.hide()
	
func _on_body_entered(body):
	print("DEAD")
	Engine.time_scale = 0.5
	hurt_sfx.play()
	
	if (body is CharacterBody2D):
		player = body
		player.get_node("CollisionShape2D").queue_free()
		player.get_node("AnimatedSprite2D").flip_v = true
		
	#body.rotate(180)
	timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1.0
	#get_node("dead_hud")
	dead_hud.show()
	player.input_enabled = false
	player.motion_mode = 1
	#get_tree().change_scene_to_file("res://Scenes/level_1.tscn")

func _on_dead_hud_restart():
	get_tree().reload_current_scene()

func _on_dead_hud_quit():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

#func dead_on_finish(body):
	#print("Dead on finish called")
	#hurt_sfx.play()
	#body.get_node("CollisionShape2D").queue_free()
	#body.get_node("AnimatedSprite2D").flip_v = true
	#if dead_hud:
		#dead_hud.hide()
	#if timer:
		#timer.stop()
