extends KinematicBody2D

#all code but sound-related tutorial by PlugWorld
#sound-related tutorial by Gamefromscratch

var speed = 100
var velocity = Vector2()
var stun = false
var hp = 3

var blood = preload("res://Blood.tscn")
onready var death_audio = $Death
onready var ouch_audio = $Ouch

func _process(delta):
	_look_at_mouse()
	if Global.player != null and stun == false:
		velocity = global_position.direction_to(Global.player.global_position)
	elif stun:
		velocity = lerp(velocity, Vector2(0, 0), 0.3)
		Global.play_sound("Ouch")
	global_position += velocity * speed * delta
	if hp <= 0:
		
		if Global.camera != null:
			Global.camera.screen_shake(40, 0.1)
			
		Global.points += 1
		
		if Global.node_creation_parent != null:
			var bloodInstance = Global.instance_node(blood, global_position, Global.node_creation_parent)
			bloodInstance.rotation = velocity.angle()
		Global.play_sound("Death")
		queue_free()
		
#turn enemy towards player (recycled from player script)
func _look_at_mouse():
	look_at(get_global_mouse_position())

func _on_Hitbox_area_entered(area):
	if area.is_in_group("enemyDamage") and stun == false:
		modulate = Color.red
		velocity = -velocity * 6
		hp -= 1
		stun = true
		$Stun_Timer.start()
		area.get_parent().queue_free()

func _on_Stun_Timer_timeout():
	modulate = Color(1, 1, 1)
	stun = false
