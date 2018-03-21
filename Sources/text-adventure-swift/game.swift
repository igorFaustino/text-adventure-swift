class Jogo {
	let cenas: [Scene]
	let cena_atual: Int

	init(cena_atual: Int){
		self.cenas = [Scene]()
		self.cena_atual = cena_atual
	}
}