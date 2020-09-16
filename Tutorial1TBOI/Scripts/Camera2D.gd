extends Camera2D
var Motion=Vector2() #### Crear un vector 
var new_pos=Vector2()
var new_pos2=Vector2()
var Width=ProjectSettings.get_setting("display/window/size/width") ## Obtengo la resolucion en width, usando el path de settings
var Height=ProjectSettings.get_setting("display/window/size/height")## Resolucion height
var camaralibre ## Inicializo
onready var player=get_parent().get_node("Obj_Player") ## Obtener el nodo player, primero recorriendo el padre
onready var ray=get_tree().get_nodes_in_group("PlayerRaycast") ## obtengo todos los objetos en player raycast, es necesario hacerlo en on ready
onready var camx=get_camera_screen_center().x ## guardar en variable el centro de lacamara en x
onready var camy=get_camera_screen_center().y## same en y
var transicion=0
var check=[false,false]
func set_new(): ## Cuando llega la señal por parte de la puerta:
	var posx=player.position.x-get_global_position().x+camx ## Get la posicion del player relativa al offset en x
	var posy=player.position.y-get_global_position().y+camy ## Get la pos del player relativa al offset en y
	################ Settear donde deberia estar la camara segun el jugador
	if (posx>(Width/2-100)): ## Si la posicion x del jugador relativa a la view es mayor de la mitad -50(Derecha)
		Motion.x+=Width# Sumarle "una room en x" osea lamisma resolucion en ancho a donde deberia estar la camara
		player.position.x+=125 ## Sumarle un poco al jugador para que salga al otro room entero
	if (posx<-(Width/2-100)):
		Motion.x-=Width
		player.position.x-=125
	if (posy<-(Height/2-100)):
		Motion.y-=Height 
		player.position.y-=110
	if (posy>(Height/2-100)):
		Motion.y+=Height ## Misma resolucion en  alto
		player.position.y+=110
	transicion=1## aviso que voy a hacer el efecto transicion
func _process(_delta): ##### para que se ejecute step by step y la camara llegue a donde se setteo
	if new_pos!=Motion: ## Para que llame el resto de la funcion solo si algo ha cambiado
		if (new_pos.x<Motion.x): ## Si la nueva posicion es menor que donde deberia estar, que se sume.
			new_pos.x+=Width/10
			player.quieto=1
		if (new_pos.x>Motion.x):
			new_pos.x-=Width/10
			player.quieto=1
		if (new_pos.y<Motion.y):
			new_pos.y+=(Height/10)
			player.quieto=1
		if (new_pos.y>Motion.y):
			new_pos.y-=(Height/10)
			player.quieto=1
		if (new_pos==Motion):
			player.quieto=0
			transicion=0
		if abs (new_pos.x- Motion.x)<10 and abs (new_pos.y-Motion.y)<10:
			new_pos=Motion
			player.quieto=0
			transicion=0
		new_pos2.x=new_pos.x+camx ## Esto es para igualar el centro de la camara  y que no se descuadre
		new_pos2.y=new_pos.y+camy
		set_global_position(new_pos2) ## actualizar la camara a new_pos
	if transicion==0:
		if ray[0].is_colliding(): ## Verificar si el primer raycast del array esta colisionando
			check[0]=true ## En caso verddero, guardar su true
		else:
			check[0]=false ## si no gaurdar falso
		if ray[1].is_colliding():
			check[1]=true
		else:
			check[1]=false
		if check[0]==true or check[1]==true : ## Si cualquiera de los dos colisiona 
			camaralibre=0 # La camara es fija
			
		if check[0]==false or check[1]==false: ## Si cualquiera de los dos deja de colisionar
			camaralibre=1 ## la camara es libre
		
		if camaralibre==1:	# si la camra es libre:
			if check[0]==false and check[1]==true: ## Verificar cual de los dos esta colisionando
				var carx=Vector2() ## Nuevo vector2 temporal
				carx=Vector2(player.position.x+camx-get_offset().x , get_global_position().y)#VEctor2=La posicion en x del jugador, restandole el centro de la camara, y la posicion y de la camara sin cambiar
				set_global_position(carx) ##Actualizar posicon de camara
				
			if check[1]==false and check[0]==true: ## Verificar cual de los dos esta colisionando
				var cary=Vector2()
				cary=Vector2(get_global_position().x, player.position.y+camy-get_offset().y)## Lo mismo pero dejando estatico a x y moviendo a y
				set_global_position(cary)
				
			if check==[false,false]: ## Si los dos no estan colisionando mover tanto equis como ye
				var car=Vector2()
				car=Vector2(player.position.x+camx-get_offset().x, player.position.y+camy-get_offset().y)
				set_global_position(car)
