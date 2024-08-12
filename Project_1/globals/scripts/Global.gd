class_name Global

enum EGameState{
	None,
	Explore,
	Battle,
	Cooking,
}

static var game_state:EGameState = EGameState.None

static func ChangeGameState(new_game_state:EGameState)->void:
	game_state = new_game_state
	EventCenter.GameStateChange.emit(new_game_state)
