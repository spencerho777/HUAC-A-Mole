extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var rng = RandomNumberGenerator.new()

export (int) var speed = 5

var sprite = ""

var communist = false
var startY = 0
var shouldMoveUp = false
var shouldMoveDown = false

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	sprite = get_node("AnimatedSprite")
	startY = self.position.y
	changeImage()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("ui_down"):
		shouldMoveDown = true
	elif Input.is_action_just_pressed("ui_up"):
		shouldMoveUp = true
	
	if shouldMoveUp and shouldMoveDown:
		shouldMoveUp = false
	
	if shouldMoveUp:
		if self.position.y > startY - 130:
			self.position.y = self.position.y - speed
		else:
			shouldMoveUp = false
			
	if shouldMoveDown:
		if self.position.y < startY:
			self.position.y = self.position.y + speed
		else:
			shouldMoveDown = false

func changeImage(frame = -1):
	if (frame == -1):
		
		sprite.frame = rng.randi_range(0, 10)
	else:
		sprite.frame = frame
		
	if sprite.frame == 5:
		communist = true
	else:
		communist = false

