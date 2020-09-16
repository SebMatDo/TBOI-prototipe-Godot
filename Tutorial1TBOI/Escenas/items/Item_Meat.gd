extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_Item_SadOnion_body_entered(body):
	if body.is_in_group("Player"):
		body.dmg+=0.5
		body.max_speed+=30
		body.max_hp+=2
		body.ui.update()
		body.audio.sfx_play("res://Resources/sfx/power up1.wav",-10)
		queue_free()
		
