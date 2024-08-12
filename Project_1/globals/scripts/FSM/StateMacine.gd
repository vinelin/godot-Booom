class_name StateMacine extends Node

var states:Dictionary = {}
var current_state:State
var m_target

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.set_state_owner(self)
			
func start(state_name:String,target:Object):
	m_target = target
	current_state = states.get(state_name)
	if current_state == null:
		printerr("状态不存在")
	on_enter()

func stop():
	on_exit()
	
func on_enter()->void:
	current_state.on_enter()
	
func _process(delta: float) -> void:
	if current_state != null:
		current_state.on_update(delta)
	
func on_exit()->void:
	current_state.on_exit()

func change_state(new_state_name:String)->bool:
	var new_state = states.get(new_state_name)
	if new_state != null and new_state.condition():
		current_state.on_exit()
		current_state = new_state
		current_state.on_enter()
		return true
	else:
		printerr("状态不存在 或者 条件不满足",)
		return false
