extends Node

class_name State
# Step 1
# Virtual base class will be used for your states. The methods below are virtual
# methods, meaning we will override them in our state nodes (idle, run, fly, etc)

# We store reference to the state machine so that we can all its "transition_to()" method directly
var state_machine = null


# Virtual function. Receives events from the "_unhandled_input()" callback in StateMachine.
func handle_input(_event: InputEvent):
	pass
	
	
# Virtual function. Corresponds to the "_process()" callback in StateMachine.
func update(_delta: float):
	pass
	
	
# Virtual function. Corresponds to the "_physics_process()" callback in StateMachine.
func physics_update(_delta: float):
	pass
	
	
# Called by the state machine upon changing active state. The "msg" parameter
# is a dictionary with arbitrary data that the state can use to initialize itself.
# Removed for this game, see GDQuest link for implementation (https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/)
func enter():
	pass
	
	
# Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit():
	pass
