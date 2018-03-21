class Scene {

	let id: Int
	let titulo: String
	let descricao: String
	let itens: [String] // trocar string por um array de objetos

	init(id: Int, titulo: String, descricao: String, itens: [String]){
		self.id = id
		self.titulo = titulo
		self.descricao = descricao
		self.itens = itens
	}
}