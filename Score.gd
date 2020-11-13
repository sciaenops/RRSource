extends Label

#tutorial by PlugWorld

func _process(delta):
	text = String("Samples Collected: ") + String(Global.points)
