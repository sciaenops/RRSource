extends Node2D

#tutorial by PlugWorld

var enemyOne = preload("res://Enemy.tscn")

func _ready():
	Global.node_creation_parent = self
	
	Global.points = 0
	
func _exit_tree():
	Global.node_creation_parent = null

func _on_Spawn_timeout():
	var enemy_pos = Vector2(rand_range(-160, 670), rand_range(-90, 390))
	
	while enemy_pos.x < 640 and enemy_pos.x > -80 and enemy_pos.y < 360 and enemy_pos.y > -45:
		enemy_pos = Vector2(rand_range(-160, 670), rand_range(-90, 390))
	
	Global.instance_node(enemyOne, enemy_pos, self)

func _on_Difficulty_timeout():
	if $Spawn.wait_time > 1:
		$Spawn.wait_time -= 0.1
