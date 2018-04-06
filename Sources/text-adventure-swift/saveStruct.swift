struct SaveStruct: Codable {
	var inventory: [Item]
	var currentScene: Int
	var sceneItens: [Item]
	var time: Int
}