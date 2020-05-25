extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
var x = 350
var y = 100
var h = 100
var w = 100
var tex_x = preload("res://assets/textures/x.png")
var tex_o = preload("res://assets/textures/o.png")
var size=3
var player_x:bool = true
var grid=[]
func _ready():
	for _p in range(size):
		grid.append([])
	for i in range(size):
		for _j in range(size):
			var rect = Rect2(x,y,w,h)
			var data={}
			data.rect=rect
			data.val=-1
			grid[i].append(data)
			y=y+w
		x=x+h
		y=y-(size*w)
	
func _on_GameScene_draw():
	draw_game()

func draw_game():
	for i in range(size):
		for j in range(size):
			draw_rect(grid[i][j].rect,Color("#ffffff"),false)
			grid[i][j].val=-1
			var p:Panel = get_node("Panel").duplicate()
			p.rect_position = grid[i][j].rect.position+Vector2(5,5)
			p.connect("gui_input",self,"_on_doit",[i,j])
			p.name = "tile"+str(i)+str(j)
			p.editor_description="tile"
			add_child(p)

func _on_doit(event,i,j):
	if event is InputEventMouseButton:
		if event.button_index==BUTTON_LEFT and event.pressed==true: 
			var p:Panel = get_node("tile"+str(i)+str(j))
			p.disconnect("gui_input",self,"_on_doit")
			var s:Sprite = p.get_child(0)
			s.set_texture((tex_x if player_x==true else tex_o))
			grid[i][j].val=(0 if player_x==false else 1)
			player_x = (false if player_x==true else true)
			checkWinner()

func _on_Button_pressed():
	for c in get_children():
		if c is Panel and c.editor_description=="tile":
			remove_child(c)
	player_x=true
	draw_game()
	
func checkWinner():
	var r=checkrow()
	if r!="":
		print(r+" won") 
func checkrow():
	var won=""
	for i in range(size):
		var sum=0
		for j in range(size):
			sum=sum+grid[i][j].val
		if sum==0:
			won="o"
		elif sum==size:
			won="x"
	return won


func _on_BackButton_pressed():
	get_tree().change_scene("res://Main.tscn")
