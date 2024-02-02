extends MeshInstance3D

@export var isLeft: bool

@onready var flipper_launch_area = $FlipperLaunchArea

var currentAngle = -6.0
var restingAngle = -6.0
var rot = 39
var maxAngle = 39.0
var flipperResetSpeed = 700
const lenVector = Vector3(0, 0, 0.10)

var action

var launchImpulse = 15


func _ready():
	if isLeft:
		action = "left_flipper"
	else:
		action = "right_flipper"
		currentAngle *= -1
		restingAngle *= -1
		maxAngle *= -1
		flipperResetSpeed *= -1
		rot *= -1
	rot = deg_to_rad(rot)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed(action):
		currentAngle = maxAngle
	elif (isLeft and restingAngle < currentAngle) or (!isLeft and currentAngle < restingAngle):
		currentAngle -= flipperResetSpeed * delta
	
	rotation.y = deg_to_rad(currentAngle)
	
	if Input.is_action_just_pressed(action):
		var bodies = flipper_launch_area.get_overlapping_bodies()
		for i in bodies:
			var ipos = i.position
			var angle = position.angle_to(ipos)
			if isLeft:
				angle = rot + angle
			else:
				angle = rot - angle
			var dist: Vector3 = (ipos - position)
			var change = dist.rotated(Vector3(0, 1, 0), angle)
			dist = dist.clamp(-lenVector*scale, lenVector*scale)
			change = -dist + change
			change.y /= 2
			i.position += change
			i.apply_impulse(change * launchImpulse)
	
