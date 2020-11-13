extends KinematicBody2D

#movement (tutorial by Space Shark Studios)

export var move_speed = 500
export var stop_distance = 20

var velocity = Vector2()

var bullet = preload("res://Bullet.tscn")
var oil = preload("res://Oil.tscn")

var can_shoot = true
var is_dead = false

func _ready():
	Global.player = self

func _exit_tree():
	Global.player = null

func _process(delta):
	_look_at_mouse()
	_move_to_mouse()

func _look_at_mouse():
	look_at(get_global_mouse_position())
	
func _move_to_mouse():
	if position.distance_to(get_global_mouse_position()) > stop_distance:
		var direction = get_global_mouse_position() - position
		var normalized_direction = direction.normalized()
		move_and_slide(normalized_direction * move_speed)
		global_position.x = clamp(global_position.x, 24, 1000)
		global_position.y = clamp(global_position.y, 24, 576)
		
#shooty part (tutorial by PlugWorld)
#sound tutorial by Gamefromscratch
		
	if Input.is_action_just_pressed("shoot") and Global.node_creation_parent != null and can_shoot and is_dead == false:
		Global.play_sound("Zap")
		Global.instance_node(bullet, global_position, Global.node_creation_parent)
		
func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy"):
		is_dead = true
		visible = false
		Global.play_sound("Crash")
		if Global.node_creation_parent != null:
			var oil_particle_instance = Global.instance_node(oil, global_position,Global.node_creation_parent)
			oil_particle_instance.rotation = velocity.angle()
		Global.save_game()
		yield(get_tree().create_timer(1.0), "timeout")
		get_tree().reload_current_scene()
