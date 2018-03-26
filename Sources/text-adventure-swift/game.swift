class Game {
	let gameTitle: String
	let gameDescription: String
	let scenes: [Scene]
	var currentScene: Int

	init(gameTitle: String, gameDescription: String, currentScene: Int, scenes: [Scene]){
		self.gameTitle = gameTitle
		self.gameDescription = gameDescription
		self.scenes = scenes
		self.currentScene = currentScene
	}

	func getScene() -> Scene {
		return self.scenes[self.currentScene]
	}

	func setCurrentScene(value: Int) {
		self.currentScene = value
	}

	func printScene() {
		self.scenes[self.currentScene].printScene()
	}

	func getCurrentScene() -> Int{
		return self.currentScene
	}

	func printGameTitle() {
		print(self.gameTitle)
	}

	func printGameDescription() {
		print(self.gameDescription)
	}
}