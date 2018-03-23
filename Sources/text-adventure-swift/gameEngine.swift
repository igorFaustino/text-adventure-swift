class GameEngine {
	// These attributes need to be started by a file ... uncomment when the game can read json files
	var game: Game!
	var radio_messages: [String]
	var inventory: Inventory!

	init(){
		// initialized class.. without that we can't call any methods
		self.game = nil
		self.inventory = nil
		self.radio_messages = []

		// call methods to read a file and put the data insite the attributes

		self.game = init_game_from_file()
		self.radio_messages = init_radio_messages_from_file()
		self.inventory = init_inventory_from_file()
	}

	func use_radio(){
		// Show the radio message for the current scene
		print(self.radio_messages[self.game.get_current_scene()])
	}

	func init_game_from_file() -> Game {
		// work in progress..		
		return Game(current_scene: 0, scenes: [])
	}

	func init_radio_messages_from_file() -> [String] {
		// work in progress..
		return []
	}

	func init_inventory_from_file() -> Inventory {
		// work in progress..
		let vector_itens = [Item(id: 1, name: "test", description: "blabla", negative_result: "oh sorry", positive_result: "yaay", scene: 1, stocked: true, resolved: false, key: false, command: "use test with rock")]
		return Inventory(vector_itens: vector_itens)
	}
}