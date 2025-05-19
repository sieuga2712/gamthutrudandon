extends Area2D

var vongchon_path = preload("res://screens/common/luachontru.tscn")
var radius := 100.0
var angles_deg := [0, 60, 120, 180, 240, 300]  # Các góc muốn sinh ô
var tru_select_scene = preload("res://screens/common/truselect.tscn")
var damochon:=false
var vongchon_instance: Node = null
var tru_selects: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Bắt sự kiện chuột
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			# Khởi tạo vòng tròn
			if damochon==false:
				damochon=true
				vongchon_instance = vongchon_path.instantiate()
				vongchon_instance.global_position = global_position
				get_tree().current_scene.add_child(vongchon_instance)
				spawn_o_tren_vien()
			else:
				damochon = false
				remove_vongchon_va_ots()

# Tạo các ô trên viền vòng tròn
func spawn_o_tren_vien():
	for angle_deg in angles_deg:
		var angle_rad = deg_to_rad(angle_deg) 
		var pos = global_position + Vector2(cos(angle_rad), sin(angle_rad)) * radius
		var tru_select = tru_select_scene.instantiate()
		tru_select.global_position = pos  
		get_tree().current_scene.add_child(tru_select)
		tru_selects.append(tru_select)

func remove_vongchon_va_ots():
	if vongchon_instance:
		vongchon_instance.play_disappear()
		vongchon_instance = null
	for tru in tru_selects:
		if tru:
			var tween = create_tween()
			tween.tween_property(tru, "global_position", global_position, 0.1)
			tween.tween_callback(Callable(tru, "queue_free"))
	tru_selects.clear()
