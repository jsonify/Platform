extends State

class_name PlayerState
# Step 2
# Boilerplate class to get full autocompletion and type checks for the 'player'
# when coding the player's states.
# Without this, we have to run the game to see typos and other errors the
# compiler could otherwise catch while scripting.

# Typed reference to the player node.
var player: Player

func _ready():
	# The states are children of the "Player" node so their "_ready()" callback will execute first.
	# That's why we wait for the "owner" to be ready first.

	# owner refers to the Player
	await owner.ready
	
	player = owner as Player
	
	assert(player != null)
