extends Sprite

#Some people say they can outsmart me.
#But I bet they can't outsmart bullets.
#Tutorial from PlugWorld

var velocity = Vector2(1, 0)
var speed = 300

var look_once = true

func _process(delta):
	if look_once:
		look_at(get_global_mouse_position())
		look_once = false
	global_position += velocity.rotated(rotation) * speed * delta

