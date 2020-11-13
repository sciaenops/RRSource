extends Label

#tutorial by PlugWorld

func _ready():
	Global.load_game()
	text = String("Most Samples Collected: ") + String(Global.highscore)

func _process(delta):
	if Global.points > Global.highscore:
		Global.highscore = Global.points
