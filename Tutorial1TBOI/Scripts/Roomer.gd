extends Area2D

### Crear room proceduralmente#####
var max_rooms=0
var direction=0
onready var room= load("res://Escenas/Room.tscn")
var roomcreated
var currentrooms=0
var back=0
onready var main=get_parent()
var col=0
var sizex=ProjectSettings.get("display/window/size/width")
var sizey=ProjectSettings.get("display/window/size/height")
var finish2=0
var recorrer=preload("res://Escenas/Recorrer.tscn")
var can=0
var n_nodos=[]
var goto
var rposition=Vector2(0,0)
var recorrido=[Vector2(0,0)]
var total_recorrer=1
var levelmap=0

func make_rooms():
	if currentrooms<max_rooms:
		roomcreated=room.instance()
		main.call_deferred("add_child",roomcreated)
		roomcreated.posx=position.x
		roomcreated.posy=position.y
		roomcreated.valor=randi()%4+1
		roomcreated.levelmap=levelmap
		currentrooms+=1

#warning-ignore:unused_argument
func _process(delta):

	if currentrooms<max_rooms:
		comprobar()
	
	if finish2==max_rooms:
		finish2=999
		puertas()
		

func puertas():
	var nodos=get_tree().get_nodes_in_group("room")
	while total_recorrer<max_rooms+1:
		can=0
		n_nodos=[]
		for i in nodos.size():
			if rposition.distance_to(nodos[i].position)<sizex+1:
				n_nodos.append(nodos[i])
		var min_valor=n_nodos[0].valor
		goto=n_nodos[0]
		for i in n_nodos.size():
			if n_nodos[i].valor<min_valor:
				min_valor=n_nodos[i].valor
				goto=n_nodos[i]
		if min_valor==10000:
			can=1
			if recorrido!=[]: 
				rposition=recorrido.back()
				if recorrido.size()>1:
					recorrido.remove(recorrido.size()-1)
					rposition=recorrido.back()

		if can==0:
			if goto.position.x<rposition.x:
				var nr=recorrer.instance()
				get_parent().add_child(nr)
				nr.position=rposition
				rposition.x-=sizex
				nr.get_node("RayCast2D").set_cast_to(rposition-nr.position)
				goto.valor=10000
				recorrido.append(rposition)
				total_recorrer+=1
				
			if goto.position.x>rposition.x:
				var nr=recorrer.instance()
				get_parent().add_child(nr)
				nr.position=rposition
				rposition.x+=sizex
				nr.get_node("RayCast2D").set_cast_to(rposition-nr.position)
				goto.valor=10000
				recorrido.append(rposition)
				total_recorrer+=1
					
			if goto.position.y<rposition.y:
				var nr=recorrer.instance()
				get_parent().add_child(nr)
				nr.position=rposition
				rposition.y-=sizey
				nr.get_node("RayCast2D").set_cast_to(rposition-nr.position)
				goto.valor=10000
				recorrido.append(rposition)
				total_recorrer+=1
				
			if goto.position.y>rposition.y:
				var nr=recorrer.instance()
				get_parent().add_child(nr)
				nr.position=rposition
				rposition.y+=sizey
				nr.get_node("RayCast2D").set_cast_to(rposition-nr.position)
				goto.valor=10000
				recorrido.append(rposition)
				total_recorrer+=1
	
	if max_rooms+1==total_recorrer:
			yield(get_tree().create_timer(0.1), "timeout")
			get_tree().call_group("RCRecorrer","abrir")
			yield(get_tree().create_timer(0.1), "timeout")
			get_tree().call_group("RCRecorrer","abrir")
			get_tree().call_group("RCRecorrer","delete")
			yield(get_tree().create_timer(0.25), "timeout")
			get_tree().call_group("room","tilear")
			yield(get_tree().create_timer(0.25), "timeout")
			get_parent().get_node("Obj_Player").quieto=0

func Fdirection():
	col=0
	direction=randi()%6+1
	if direction==1 or direction==2:
		position.x-=sizex
	if direction==3 or direction==4:
		position.x+=sizex
	if direction==5:
		position.y-=sizey
	if direction==6:
		position.y+=sizey
	back=randi()%10+1
	if back==1:
		position.x=0
		position.y=0
		Fdirection()
	
func comprobar():
	var romes=get_tree().get_nodes_in_group("room")
	for i in range (romes.size()):
		if romes[i].position==self.position:
			col=1
			
	if col==0:
		make_rooms()
	if col==1:
		Fdirection()
		
	if currentrooms==max_rooms:
		print("finish")
		get_tree().call_group("room","finish")
		#get_tree().call_group("room","nearest")
		yield(get_tree().create_timer(0.1), "timeout")
		roomcreated.finish()
		get_node("Sprite").visible=false
