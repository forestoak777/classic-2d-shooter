extends CharacterBody2D

signal shield_changed
signal died

@export var speed = 150
@export var cooldown = 0.01
@export var bullet_scene : PackedScene
@export var max_shield = 10
var shield = max_shield:
	set = set_shield
	
var can_shoot = true

@onready var screensize = get_viewport_rect().size

func _ready():
	start()

func start():
	show()
	position = Vector2(screensize.x / 2, screensize.y - 64)
	shield = max_shield
	$GunCooldown.wait_time = cooldown
	
func _physics_process(delta):
	var direction = Vector2.ZERO
	var input = Input.get_vector("left", "right", "up", "down")
	
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")

	velocity = direction.normalized() * speed
	move_and_slide()

func _process(delta):
	look_at(get_global_mouse_position())

	if Input.is_action_pressed("shoot"):
		shoot()

func shoot():
	if not can_shoot:
		return
	can_shoot = false
	$GunCooldown.start()
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start(position, rotation + deg_to_rad(90))
	var tween = create_tween().set_parallel(false)
	tween.tween_property($Ship, "position:x", 1, 0.1)
	tween.tween_property($Ship, "position:x", 0, 0.05)
	$ShootSound.play()

func set_shield(value):
	shield = min(max_shield, value)
	shield_changed.emit(max_shield, shield)
	if shield <= 0:
		hide()
		died.emit()
		
func _on_gun_cooldown_timeout():
	can_shoot = true


func _on_area_entered(area):
	if area.is_in_group("enemies"):
		area.explode()
		shield -= max_shield / 2.0
