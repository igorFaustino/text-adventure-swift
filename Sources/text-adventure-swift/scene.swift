class Scene {

	let id: Int
	let title: String
	let description: String
	let itens: [Item] // trocar string por um array de objetos
	let endGame: Bool

	init(id: Int, title: String, description: String, itens: [Item], endGame: Bool){
		self.id = id
		self.title = title
		self.description = description
		self.itens = itens
		self.endGame = endGame
	}

	func printScene(){
		print(self.title)
		print(self.description)
	}

	func searchItemScene(name: String) -> Item! {
        for item in self.itens {
            if(item.getName().lowercased() == name.lowercased()){
                return item
            }
        }
        return nil
    }

	func isEndGame() -> Bool {
		return self.endGame
	}
}