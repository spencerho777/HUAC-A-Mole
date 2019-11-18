extends StaticBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var rng = RandomNumberGenerator.new()
var mole = []

export (int) var nextMoleTime = 0# rng.randi_range(1500, 4000) #percentage per tick
export (int) var moleSpeed = 20
export (int) var moleTimeUpMin = 200
export (int) var moleTimeUpMax = 3000

var availible = true
var clock = 0
var lastMoleTime = 0# rng.randi_range(0, 5000)
var moleTimeUpRandom = 0# rng.randi_range(moleTimeUpMin, moleTimeUpMax)

# Called when the node enters the scene tree for the first time.
func _ready():
	mole = get_node("Mole")
	
	rng.randomize()
	
	nextMoleTime = rng.randi_range(1500, 4000)
	lastMoleTime = rng.randi_range(0, 5000)
	moleTimeUpRandom = rng.randi_range(moleTimeUpMin, moleTimeUpMax)
	pass

func shouldProcMole():
	if clock > lastMoleTime + nextMoleTime:
		lastMoleTime = clock
		nextMoleTime = rng.randi_range(300, 4500)
		moleUp()

func shouldLowerMole():
	if clock > lastMoleTime + moleTimeUpRandom:
		moleDown()
		lastMoleTime = clock
		moleTimeUpRandom = rng.randi_range(moleTimeUpMin, moleTimeUpMax)

func moleUp():
	availible = false
	mole.changeImage()
	mole.shouldMoveUp = true
	
func moleDown():
	mole.shouldMoveDown = true
	availible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	clock = OS.get_ticks_msec()
	if availible:
		shouldProcMole()
	else:
		shouldLowerMole()
		