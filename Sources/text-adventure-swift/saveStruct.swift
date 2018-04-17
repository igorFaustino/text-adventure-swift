struct SaveStruct: Codable {
	var inventory: [Item]
	var currentScene: Int
	var scenes: [Scene]
	var time: Int
}