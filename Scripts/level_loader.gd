extends Node

var current_level: Node
var level_number: int = 0
var levels: Array[PackedScene] = []

@onready var ground: Node = $"../Ground"
@onready var camera_2d: Camera2D = $"../Camera2D"
@onready var player_main: CharacterBody2D = $"../Player"
@onready var slime: Node2D = $"../slime"

func _ready():
	load_levels()
	player_on_start()
	slime_on_start()

	if levels.size() > 0:
		current_level = levels[0].instantiate()
		add_child(current_level)
		
		# Akses ke Game Manager dan sambungkan sinyal
		var game_manager = current_level.get_node("Game Manager")
		var player = current_level.get_node("Player")
		player.queue_free()

		if game_manager:
			game_manager.connect("switch_lvl", Callable(self, "_on_level_completed"))
		else:
			print("Game Manager node not found!")
	else:
		print("No levels loaded!")

func player_on_start():
	player_main.idle_player()

func slime_on_start():
	slime.idle_slime()

func load_levels():
	var level_paths = [
		"res://Scenes/level_1.tscn",
		"res://Scenes/level_2.tscn",
		"res://Scenes/level_3.tscn"
	]
	
	for path in level_paths:
		var packed_scene = ResourceLoader.load(path)
		if packed_scene:
			levels.append(packed_scene)
			print("Level " + path + " Successfully Loaded!")
		else:
			print("Failed to load level: " + path)

func _on_level_completed():
	level_number += 1
	if level_number < levels.size():
		change_level(level_number)
	else:
		print("No more levels to load")
		# Bisa menambahkan logika untuk kembali ke menu utama atau menampilkan pesan akhir
		return

func change_level(level_idx: int):
	if current_level:
		current_level.queue_free()  # Free the current level
		
	if level_idx >= 0 and level_idx < levels.size():
		current_level = levels[level_idx].instantiate()
		add_child(current_level)
		print("Loading Level: " + str(level_idx + 1))
		print("Level index:", level_idx)
		print("Total levels:", levels.size())
		
		# Pastikan untuk menghubungkan sinyal di level baru
		var game_manager = current_level.get_node("Game Manager")
		if game_manager:
			game_manager.connect("switch_lvl", Callable(self, "_on_level_completed"))
			print("Game Manager found and signal connected.")
		else:
			print("Game Manager node not found!")
	else:
		print("Level index out of bounds or invalid. No more levels to load.")

func _on_start_game():
	player_main.enable_player()
	slime.enable_slime()

	# Free ground, camera, player, and slime if you want to clean them up
	ground.queue_free()
	camera_2d.queue_free()
	player_main.queue_free()  
	slime.queue_free()

	# Change to the first level
	change_level(0)
