extends Node2D
var posx=0
var posy=0
var mainroom=0
var height=ProjectSettings.get("display/window/size/height")
var width=ProjectSettings.get("display/window/size/width")
var puerta=preload("res://Escenas/puerta.tscn")
var puertas=0
var new_puerta1
var new_puerta2
var new_puerta3
var new_puerta4

var valor=1000 

var levelmap=0

func _ready():
	position.x=posx
	position.y=posy

func finish():
	######################## SABER CUALES PUERTAS TENGO ARRIBA ABAJO IZQ Y DERECHA

	new_puerta1=puerta.instance()
	new_puerta1.position.x-=width/2-43
	#new_puerta1.position.y=position.y
	new_puerta1.rotation=deg2rad(270)
	add_child(new_puerta1)
	puertas+=1
	

	new_puerta2=puerta.instance()
	new_puerta2.position.x+=width/2-40
	#new_puerta2.position.y=position.y
	new_puerta2.rotation=deg2rad(90)
	add_child(new_puerta2)
	puertas+=1
		

	new_puerta3=puerta.instance()
	#	new_puerta3.position.x=position.x
	new_puerta3.position.y-=height/2-36
	new_puerta3.rotation=deg2rad(0)
	add_child(new_puerta3)
	puertas+=1
		
		

	new_puerta4=puerta.instance()
	#new_puerta4.position.x=position.x
	new_puerta4.position.y+=height/2-35
	new_puerta4.rotation=deg2rad(180)
	add_child(new_puerta4)
	puertas+=1
		
	################# Crear las paredes############
	##########  ARRIBA ###########
	var shapee=CollisionShape2D.new()
	$AreaWall.add_child(shapee)
	shapee.shape=RectangleShape2D.new()
	shapee.shape.set_extents(Vector2(width/4-15,5))
	shapee.position.y-=(height/2)-49
	shapee.position.x-=width/4
	
	var shapee1=CollisionShape2D.new()
	$AreaWall.add_child(shapee1)
	shapee1.shape=RectangleShape2D.new()
	shapee1.shape.set_extents(Vector2(width/4-15,5))
	shapee1.position.y-=(height/2)-49
	shapee1.position.x+=width/4
	
	
	
	
	###### Se repite el proceseo para las demas direcciones.
	######## ABAJO#######
	var shapee2=CollisionShape2D.new()
	$AreaWall.add_child(shapee2)
	shapee2.shape=RectangleShape2D.new()
	shapee2.shape.set_extents(Vector2(width/4-15,5))
	shapee2.position.y+=height/2-48
	shapee2.position.x-=width/4
	
	var shapee22=CollisionShape2D.new()
	$AreaWall.add_child(shapee22)
	shapee22.shape=RectangleShape2D.new()
	shapee22.shape.set_extents(Vector2(width/4-15,5))
	shapee22.position.y+=height/2-48
	shapee22.position.x+=width/4
	
	
	
	
	###### Se repite el proceseo para las demas direcciones.
	######### Derecha ############
	
	var shapee3=CollisionShape2D.new()
	$AreaWall.add_child(shapee3)
	shapee3.shape=RectangleShape2D.new()
	shapee3.shape.set_extents(Vector2(5,height/4-15))
	shapee3.position.x+=width/2-53
	shapee3.position.y+=height/4
	
	var shapee33=CollisionShape2D.new()
	$AreaWall.add_child(shapee33)
	shapee33.shape=RectangleShape2D.new()
	shapee33.shape.set_extents(Vector2(5,height/4-15))
	shapee33.position.x+=width/2-53
	shapee33.position.y-=height/4
	
	
	
	
	###### Se repite el proceseo para las demas direcciones.
	######## IZQUIERDA #######
	var shapee4=CollisionShape2D.new()
	$AreaWall.add_child(shapee4)
	shapee4.shape=RectangleShape2D.new()
	shapee4.shape.set_extents(Vector2(5,height/4-15))
	shapee4.position.x-=width/2-56
	shapee4.position.y-=height/4
	
	var shapee44=CollisionShape2D.new()
	$AreaWall.add_child(shapee44)
	shapee44.shape=RectangleShape2D.new()
	shapee44.shape.set_extents(Vector2(5,height/4-15))
	shapee44.position.x-=width/2-56
	shapee44.position.y+=height/4
	
	### Pared Para Las balas#######
	var shapetear=CollisionShape2D.new()
	$AreaWallTear.add_child(shapetear)
	shapetear.shape=RectangleShape2D.new()
	shapetear.shape.set_extents(Vector2(width/2,5))
	shapetear.position.y-=(height/2)-10
	
	### Pared Para Las balas#######
	var shapetear2=CollisionShape2D.new()
	$AreaWallTear.add_child(shapetear2)
	shapetear2.shape=RectangleShape2D.new()
	shapetear2.shape.set_extents(Vector2(width/2,5))
	shapetear2.position.y+=(height/2)-45
	
	### Pared Para Las balas#######
	var shapetear3=CollisionShape2D.new()
	$AreaWallTear.add_child(shapetear3)
	shapetear3.shape=RectangleShape2D.new()
	shapetear3.shape.set_extents(Vector2(5,height/2))
	shapetear3.position.x-=(width/2)-40
	
	### Pared Para Las balas#######
	var shapetear4=CollisionShape2D.new()
	$AreaWallTear.add_child(shapetear4)
	shapetear4.shape=RectangleShape2D.new()
	shapetear4.shape.set_extents(Vector2(5,height/2))
	shapetear4.position.x+=width/2-40
	
	
	
	
	get_parent().get_node("Roomer").finish2+=1
	
func tilear():
	var map=get_parent().get_node("TileMap") ## get el tilemap
	#var wtm=map.world_to_map(self.position) ## Pasar las cordenadas en x,y a las cordenadas tilemap.
	map.set_cell(position.x-width/2+6,position.y-height/2,levelmap,0,0,0)
	map.set_cell(position.x+width/6-2,position.y-height/2,levelmap,1,0,0)
	map.set_cell(position.x-width/2+6,position.y-20,levelmap,0,1,0)
	map.set_cell(position.x+width/6-2,position.y-20,levelmap,1,1,0)
	
	########## CARGAR ROOMS #######
	var r
	if mainroom==0:
		r=randi()%get_parent().list_rooms.size()-1
		r+=1
	if mainroom==1:
		r=0
		
	var r_load=(get_parent().list_rooms[r])
	var r_l_x=-width/2+50
	var r_l_y=-height/4
	var countdown=0
	for i in r_load.length():
		######### CARGA LOS CARACTERES COMO OBJETOS#######
		if r_load[i]=="#":
			var rocainstance=load("res://Escenas/obj_rock.tscn")
			var roca=rocainstance.instance()
			add_child(roca)
			roca.position.x+=r_l_x
			roca.position.y+=r_l_y
		
		#### RECORRRE EL ESPACIO DE LAROOM ########
		countdown+=1
		r_l_x+=27
		if countdown==14:
			r_l_x=-width/2+50
			r_l_y+=22.5
			countdown=0
