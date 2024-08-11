class_name State extends Node

var state_owner:StateMacine
var target:Object:
	get:
		return state_owner.m_target

func set_state_owner(owner:StateMacine)->void:
	state_owner = owner
	
func on_enter()->void:
	pass
	
func on_update(delta:float)->void:
	pass
	
func on_exit()->void:
	pass
	
# todo 切换condition
