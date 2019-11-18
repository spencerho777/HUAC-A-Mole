extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var restingRotation = 70

var whackSoundEffect = []
var eagleSoundEffect = []

var communistLabel = []
var nonCommunistLabel = []

var isRotated = false
var rotateClock = 0
var clock = 0
var overActiveMole = []

# Called when the node enters the scene tree for the first time.
func _ready():
	self.rotation = restingRotation
	whackSoundEffect = get_node("Whack")
	eagleSoundEffect = get_node("Eagle")
	nonCommunistLabel = get_node("/root/Node2D/Non-Communist Score")
	communistLabel = get_node("/root/Node2D/Communist Score")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	isHoveringOverMole()
	
	clock = OS.get_ticks_msec()
	self.position.x = get_global_mouse_position().x
	self.position.y = get_global_mouse_position().y
	
	if Input.is_action_just_pressed('ui_click'):
		didClick()
		
	if isRotated and clock >= rotateClock + 500:
		isRotated = false
		self.rotation = restingRotation

func didClick():
	rotateClock = OS.get_ticks_msec()
	isRotated = true
	self.rotation = -45
	
	whackSoundEffect.play()
	
	if overActiveMole:
		overActiveMole.moleDown()
		eagleSoundEffect.play()
		if overActiveMole.mole.communist:
			communistLabel.value = communistLabel.value + 1
		else:
			nonCommunistLabel.value = nonCommunistLabel.value + 1
	
func isHoveringOverMole():
	var colliding_bodies = get_overlapping_bodies()
	overActiveMole = []
	if colliding_bodies:
		if not colliding_bodies[0].availible:
			overActiveMole = colliding_bodies[0]