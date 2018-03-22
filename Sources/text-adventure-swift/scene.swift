class Scene {

	let id: Int
	let titulo: String
	let descricao: String
	let itens: [Item] // trocar string por um array de objetos

	init(id: Int, titulo: String, descricao: String, itens: [Item]){
		self.id = id
		self.titulo = titulo
		self.descricao = descricao
		self.itens = itens
	}
}