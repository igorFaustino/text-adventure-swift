class Game {
	let scenes: [Scene]
	var currentScene: Int

	init(currentScene: Int, scenes: [Scene]){
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
}