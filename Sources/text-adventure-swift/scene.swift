class Scene: Codable {

	let id: Int
	let title: String
	let description: String
	var itens: [Item]
	let endGame: Bool
	let isQuick: Bool
	var time: Int
	var music: String
	var resolutionSong: String

	init(id: Int, title: String, description: String, itens: [Item], endGame: Bool, isQuick: Bool, time: Int, music: String, resolutionSong: String){
		self.id = id
		self.title = title
		self.description = description
		self.itens = itens
		self.endGame = endGame
		self.isQuick = isQuick
		self.time = time
		self.music = music
		self.resolutionSong = resolutionSong
	}

	func getIsQuick() -> Bool {
		return self.isQuick
	}

	func getMusic() -> String {
		return self.music
	}

	func getResolutionSong() -> String {
		return self.resolutionSong
	}

	func passTime() -> Bool {
		self.time = self.time - 1
		if (self.time > 0){
			return true
		}
		return false
	}

	func getTime() -> Int {
		return self.time
	}

	func setTime(value: Int) {
		self.time = value
	}

	func loadItens(itens: [Item]){
		self.itens = itens
	}

	func getItens() -> [Item] {
		return self.itens
	}

	func printScene(){
		print(self.title, terminator: "")
		print(self.description)
	}

	func searchItemScene(name: String) -> Item! {
        for item in self.itens {
            if(item.getName().lowercased().folding(options: .diacriticInsensitive, locale: .current) == name.lowercased().folding(options: .diacriticInsensitive, locale: .current)){
                return item
            }
        }
        return nil
    }

	func isEndGame() -> Bool {
		return self.endGame
	}
}