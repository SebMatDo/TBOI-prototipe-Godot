extends Area2D
onready var Camer=get_parent().get_parent().get_parent().get_node("Camera2D")

func _on_Area2D_body_entered(body): ## Señal de que colisione con algo
		if (body.is_in_group("Player")): ## Si el que colisiona con esto es esta en el group player:
			Camer.set_new()## Emitir señal a la camara
			
func delete():
	var ya=0
	var p=get_tree().get_nodes_in_group("puertas")
	for i in range (p.size()):
		if ya==0:
			if self.global_position.distance_to(p[i].global_position)<150 and p[i]!=self:
				if p[i].get_parent().puertas>2:
					get_parent().puertas-=1
					p[i].get_parent().puertas-=1
					p[i].get_node("Sprite").visible=false
					p[i].get_node("CollisionShape2D").disabled=true
					visible=false
					$CollisionShape2D.disabled=true