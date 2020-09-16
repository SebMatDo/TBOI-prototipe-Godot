extends Node2D

# Called when the node enters the scene tree for the first time.
func abrir():
	if $RayCast2D.is_colliding():
		var r=$RayCast2D.get_collider()
		if r.is_in_group("puertas"):
			r.set_collision_mask_bit(9,false)
			r.set_collision_layer_bit(9,false)
			r.set_collision_mask_bit(0,true)
			r.set_collision_mask_bit(1,true)
			r.get_parent().get_node("Area2D").set_collision_layer_bit(0,false)
			r.get_parent().get_node("Area2D").set_collision_mask_bit(0,false)
			r.visible=true
func delete():
	queue_free()