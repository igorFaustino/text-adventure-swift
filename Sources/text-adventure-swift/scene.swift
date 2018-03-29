class Scene {

	let id: Int
	let title: String
	let description: String
	let itens: [Item] // trocar string por um array de objetos

	init(id: Int, title: String, description: String, itens: [Item]){
		self.id = id
		self.title = title
		self.description = description
		self.itens = itens
	}

	func printScene(){
		print(self.title)
		print(self.description)
	}

	func searchItemScene(name: String) -> Item! {
        for item in self.itens {
            if((item.name == name){
                return item
            }
        }
        return nil
    }

}