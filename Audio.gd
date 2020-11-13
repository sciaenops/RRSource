extends Node

#global audio stuff learned from PlugWorld
#other audio stuff learned from Gamefromscratch

func _ready():
	Global.sound_control = self
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Sounds/RiffsTwo.ogg")
	player.play()
	
func _exit_tree():
	Global.sound_control = null
