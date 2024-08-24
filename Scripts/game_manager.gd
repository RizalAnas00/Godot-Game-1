extends Node

var score = 0
var total_coins = 0

@onready var score_label: Label = $ScoreLabel
@onready var coins: Node = %Coins

func _ready():
	total_coins = coins.get_child_count()

func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " / " + str(total_coins) + " coins!"
