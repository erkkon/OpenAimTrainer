extends CharacterBody3D

signal pause_game

const SPEED = 20.0
const JUMP_VELOCITY = 25
const ACCELERATION = 50.0
const DECCELERATION = 5.0

var conversion_sensitivity = 0.0707589285714285
var user_sensitivity = 0.14
var mouse_sensitivity = 0.00990624999999999

var spread_bullets = true
var damage = 10
var shot_count = 0

var seconds = 60

var direction = Vector3()

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var raycast = $Head/Camera3D/RayCast3D
@onready var timer = $"../Timer"
@onready var timer_label = $Head/Timer
@onready var bullet = preload("res://scenes/levels/Bullet.tscn")
@onready var paused = $"../CanvasLayer/Pause"
@onready var kills = $"../CanvasLayer/Pause/Buttons/Kills"
@onready var resume = $"../CanvasLayer/Pause/Buttons/Resume"


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var callable_fire_in_thread = Callable(self, "_fire_in_thread")

var thread = Thread.new()
var bullets = []

func _ready():
	paused.visible = false
	kills.visible = false
	resume.visible = true
	
	timer_label.set_text((str(seconds) + "s"))
	if DataManager.get_data("sensitivity_game_value"):
		conversion_sensitivity = DataManager.get_data("sensitivity_game_value")
	if DataManager.get_data("sensitivity"):
		user_sensitivity = DataManager.get_data("sensitivity")
	if OS.has_feature("web"):
		mouse_sensitivity = user_sensitivity * conversion_sensitivity * 0.67857142857142857143
	else:
		mouse_sensitivity = user_sensitivity * conversion_sensitivity

	# Create a Callable object

	# Start the thread
	thread.start(callable_fire_in_thread)
	var callable_stop_thread = Callable(self, "stop_thread")
	var callable_start_thread = Callable(self, "start_thread")
	paused.connect("pause_game", callable_stop_thread)
	paused.connect("resume_game", callable_start_thread)
	
func _exit_tree():
	# Stop the thread
	if thread.is_alive():
		thread.wait_to_finish()

	# Free all the bullets
	for bullet_instance in bullets:
		if bullet_instance != null:
			bullet_instance.queue_free()

	# Clear the bullets list
	bullets.clear()

func _fire_in_thread():
	while not get_tree().paused:
		call_deferred("fire")
		OS.delay_msec(50)


func start_thread():
	if not thread.is_alive():
		thread.start(callable_fire_in_thread)


func stop_thread():
	if thread.is_alive():
		thread.wait_to_finish()
		
func set_bullet_transform(bullet_instance):
	if camera.is_inside_tree():
		bullet_instance.global_transform.origin = camera.global_transform.origin + Vector3(1, -1, 0)


func fire():
	if Input.is_action_just_pressed("fire"):
		if raycast.is_colliding():
			var target = raycast.get_collider()
			var bullet_instance = bullet.instantiate()
			get_tree().root.call_deferred("add_child", bullet_instance)
			call_deferred("set_bullet_transform", bullet_instance)


			
			
			# Pass the collision point of the raycast to the bullet
			bullet_instance.target = raycast.get_collision_point()
			if target != null:
				if target.is_in_group("Enemy"):
					target.health -= damage 
					bullet_instance.hited = true
			
			# Add the bullet to the list
			bullets.append(bullet_instance)
			
		shot_count += 1
		if (timer.is_stopped()):
			timer.start()




func _input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		camera.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(89))
	else:
		if event.is_action_pressed("ui_cancel"):
			emit_signal("pause_game")



func _physics_process(delta):
	fire()
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= (gravity * 6) * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var thedirection = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if thedirection:
		# Check if the direction has changed.
		if thedirection.dot(velocity.normalized()) < 0:
			# Instantly stop the velocity.
			velocity = Vector3.ZERO
		else:
			# Add acceleration to the velocity.
			velocity += thedirection * ACCELERATION * delta
			# Limit the velocity to the maximum speed.
			if velocity.length() > SPEED:
				velocity = velocity.normalized() * SPEED
	else:
		# Decelerate the velocity.
		velocity -= velocity * DECCELERATION * delta
	
	if spread_bullets:
		# Set initial position
		raycast.rotation = Vector3(deg_to_rad(90),0,0)
		# sperad.
		raycast.rotate_x(random_spread())
		raycast.rotate_y(random_spread())
		raycast.rotate_z(random_spread())
	move_and_slide()

func random_spread() -> float:
	var spread = 2
	var velocity_spread = 0
	# if less than percentage no spread.
	if velocity.length() > (SPEED * 0.3):
		velocity_spread = velocity.length()
	randomize()
	return deg_to_rad(randf_range(-spread, spread) * velocity_spread)


func _on_timer_timeout():
	seconds -= 1
	timer_label.set_text((str(seconds) + "s"))
	if (int(seconds) <= 0):
		kills.visible = true
		resume.visible = false
		emit_signal("pause_game")
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)		
		#get_tree().change_scene_to_file("res://scenes/ui/MainScreen.tscn")

