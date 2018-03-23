class Game {
	let scenes: [Scene]
	var current_scene: Int

	init(current_scene: Int, scenes: [Scene]){
		self.scenes = scenes
		self.current_scene = current_scene
	}

	func get_scene() -> Scene {
		return self.scenes[self.current_scene]
	}

	func set_current_scene(value: Int) {
		self.current_scene = value
	}

	func print_scene() {
		self.scenes[self.current_scene].print_scene()
	}

	func get_current_scene() -> Int{
		return self.current_scene
	}
}