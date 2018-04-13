import Foundation // FileHandle
import SwiftyJSON // work with json

class GameEngine {
	// These attributes need to be started by a file ... uncomment when the game can read json files
	var file: FileHandle!
	var data: Data
	var json: JSON
	var game: Game!
	var radioMessages: [String]
	var inventory: Inventory!
	var help: String
	var gameOver: String

	init(filePath: String){
		self.file = FileHandle(forReadingAtPath: filePath)
		self.data = self.file!.readDataToEndOfFile()
		self.json = JSON(data: self.data)
		self.game = nil
		self.inventory = Inventory(vectorItens: [])
		self.radioMessages = []
		self.help = self.json["help"].string!
		self.gameOver = self.json["gameOver"].string!

		// call methods to read a file and put the data insite the attributes

		self.game = initGameFromFile()
		self.radioMessages = initRadioMessagesFromFile()
	}

	func useRadio(){
		// Show the radio message for the current scene
		print(self.radioMessages[self.game.getCurrentScene()])
	}

	func initGameFromFile() -> Game {
		var scenes : [Scene] = []
		playSong(songName: "554__bebeto__ambient-loop.mp3", params: ["--loop", "-1", "-q"])
		// get all scene from a vector of scene
		for (_, scene):(String, JSON) in self.json["scenes"] {
			var itens: [Item] = []
			// inside a scene get all the itens
			for (_, item):(String, JSON) in scene["itens"] {
				itens.append(Item(
						id: item["id"].int!,
						name: item["name"].string!,
						description: item["description"].string!,
						negativeResult: item["negativeResult"].string!,
						positiveResult: item["positiveResult"].string!,
						speech: item["speech"].string!,
						targetScene: item["targetScene"].int!,
						stocked: item["stocked"].bool!,
						isInventoryItem: item["isInventoryItem"].bool!,
						resolved: item["resolved"].bool!,
            			key: item["key"].bool!, 
            			command: item["command"].string!
					)
				)
			}

			scenes.append(Scene(
				id: scene["id"].int!,
				title: scene["title"].string!,
				description: scene["description"].string!,
				itens: itens,
				endGame: scene["isEndGame"].bool!,
				isQuick: scene["isQuick"].bool!,
				time: scene["time"].int!,
				music: scene["music"].string!,
				resolutionSong: scene["resolutionSong"].string!
			))
		}


		return Game(
			gameTitle: self.json["gameTitle"].string!,
			gameDescription: self.json["gameDescription"].string!,
			currentScene: 0,
			scenes: scenes
		)
	}

	func loadGame(filePath: String) -> Bool{
		let loadGameFile: FileHandle! = FileHandle(forReadingAtPath: filePath)
		if (loadGameFile == nil){
			print("Este save não existe...")
			return false
		}
		let loadGameData: Data = loadGameFile!.readDataToEndOfFile()
		let loadGameJson: JSON = JSON(data: loadGameData)

		for (_, item):(String, JSON) in loadGameJson["inventory"] {
			self.inventory.addItem(item: Item(
				id: item["id"].int!,
				name: item["name"].string!,
				description: item["description"].string!,
				negativeResult: item["negativeResult"].string!,
				positiveResult: item["positiveResult"].string!,
				speech: item["speech"].string!,
				targetScene: item["targetScene"].int!,
				stocked: item["stocked"].bool!,
				isInventoryItem: item["isInventoryItem"].bool!,
				resolved: item["resolved"].bool!,
				key: item["key"].bool!, 
				command: item["command"].string!
			))
		}
		self.game.setCurrentScene(value: loadGameJson["currentScene"].int!)
		var itens: [Item] = []
		for (_, item):(String, JSON) in loadGameJson["sceneItens"] {
			itens.append(Item(
				id: item["id"].int!,
				name: item["name"].string!,
				description: item["description"].string!,
				negativeResult: item["negativeResult"].string!,
				positiveResult: item["positiveResult"].string!,
				speech: item["speech"].string!,
				targetScene: item["targetScene"].int!,
				stocked: item["stocked"].bool!,
				isInventoryItem: item["isInventoryItem"].bool!,
				resolved: item["resolved"].bool!,
				key: item["key"].bool!, 
				command: item["command"].string!
			))
		}
		self.game.getScene().loadItens(itens: itens)
		if (self.game.getScene().getIsQuick()){
			self.game.getScene().setTime(value: loadGameJson["time"].int!)
		}
		return true
	}

	func saveGame(filePath: String) {
		var saveError: Bool = false
		let saveStruct = SaveStruct(
			inventory: self.inventory!.getItens(),
			currentScene: self.game.getCurrentScene(),
			sceneItens: self.game.getScene().getItens(),
			time: self.game.getScene().getTime()
		)
		let jsonEncoder = JSONEncoder()
		let jsonData = try! jsonEncoder.encode(saveStruct)
		let json = String(data: jsonData, encoding: String.Encoding.utf8)!
		do {
			try json.write(toFile: filePath, atomically: false, encoding: String.Encoding.utf8)
		} catch _ as NSError {
			print("Ooops! não foi possivel salvar seu jogo...")
			saveError = true
		} catch {
			print("Ooops! não foi possivel salvar seu jogo...")
			saveError = true			
		}
		if (!saveError){
			print("Jogo salvo com sucesso!")
		}
	}

	func getCurrentScene() -> Int {
		return self.game.getCurrentScene()
	}

	func initRadioMessagesFromFile() -> [String] {
		var radioMessages: [String] = []
		for (_, radioMessagesItem):(String, JSON) in self.json["radioMessages"] {
			radioMessages.append(radioMessagesItem.string!)
		}
		return radioMessages
	}

	func printGameTitle(){
		game.printGameTitle()
	}

	func printGameDescription() {
		game.printGameDescription()
	}

	func printHelp() {
		print(self.help)
	}

	func processCommand(command: String) -> Bool {
		let lowerCommand = command.lowercased().folding(options: .diacriticInsensitive, locale: .current)
		if (command == "help"){
			printHelp()
		} else if (lowerCommand == "exit"){
			print("Tem certeza que dejesa sair? [sim/nao]\nTodo o seu progresso não salvo será perdido!")
			print(" >".red, terminator: " ")
			var answer = readLine()
			while (!afirmativeAnswer(answer: answer!) && !negativeAnswer(answer: answer!)) {
				print("Não entendi o que vc está querendo fazer..\n")
				print("Tem certeza que dejesa sair? [sim/nao]\nTodo o seu progresso não salvo será perdido!")
				print(" >".red, terminator: " ")
				answer = readLine()
			}
			if (afirmativeAnswer(answer: answer!)){
				gameExit()
			} else if (negativeAnswer(answer: answer!)) {
				return true
			}

			gameExit()
		} else if (lowerCommand == "restart") {
			print("Tem certeza que dejesa reiniciar o jogo? [sim/nao]\nTodo o seu progresso não salvo será perdido!")
			print(" >".red, terminator: " ")
			var answer = readLine()
			while (!afirmativeAnswer(answer: answer!) && !negativeAnswer(answer: answer!)) {
				print("Não entendi o que vc está querendo fazer..\n")
				print("Tem certeza que dejesa sair? [sim/nao]\nTodo o seu progresso não salvo será perdido!")
				print(" >".red, terminator: " ")
				answer = readLine()
			}
			if (afirmativeAnswer(answer: answer!)){
				return false
			} else if (negativeAnswer(answer: answer!)) {
				return true
			}
		} else if(lowerCommand == "save"){
			print("Digite um nome para o save ou digite cancelar para cancelar o salvamento")
			print(" >".red, terminator: " ")
			let answer = readLine()
			if (answer == "cancelar"){
				return true
			} else {
				let path = URL(fileURLWithPath: "./Sources/json/saves/" + answer! + ".json").path
				saveGame(filePath: path)
			}
		} else if (lowerCommand == "radio"){
			useRadio()
		} else if (lowerCommand == "inventory"){
			inventory.printInventory()
		} else if (lowerCommand.range(of: "check") != nil){
			return checkItem(command: lowerCommand)
		} else if (lowerCommand.range(of: "get") != nil){
			return getItem(command: lowerCommand)
		} else if (lowerCommand.range(of: "talk") != nil){
			return talk(command: lowerCommand)
		} else if (lowerCommand.range(of: "use") != nil && lowerCommand.range(of: "with") == nil){
			return useItem(command: lowerCommand)
		} else if (lowerCommand.range(of: "use") != nil && lowerCommand.range(of: "with") != nil){
			return useItemWith(command: lowerCommand)
		} else {
			print("Não entendi o que voce quis dizer...")
		}

		return true
	}

	func playSong(songName: String, params: [String]) {
		// if(songName != self.currentSong){
			let song = Process()
			song.launchPath = "/usr/bin/mpg123"
			song.arguments = params + ["-q", "./Sources/songs/" + String(songName)]
			song.launch()
		// }
	}

	func playSongSync(songName: String) {
		let song = Process()
		song.launchPath = "/usr/bin/mpg123"
		song.arguments = ["-q", "./Sources/songs/" + String(songName)]
		song.launch()
		song.waitUntilExit()
	}

	func stopSongs() {
		let killall = Process()
		killall.launchPath = "/usr/bin/killall"
		killall.arguments = ["mpg123"]
		killall.launch()
	}

	func playSceneSong(){
		playSong(songName: self.game.getScene().getMusic(), params: ["--loop", "-1", "-q"])
	}

	func printScene() {
		self.game.printScene()
	}

	func printGameOver(){
		print(self.gameOver)
	}

	func isEndGame() -> Bool {
		return self.game.getScene().isEndGame()
	}

	func gameExit(){
		stopSongs()
		system("clear")
		exit(0)
	}

	func endGame(){
		printGameOver()
		print("\n[Digite enter para continuar]")
		_ = readLine()
	}

	// check item
	func checkItem(command: String) -> Bool {
		let commandSplit = command.split(separator:" ")
		if(commandSplit.count != 2 || commandSplit[0] != "check"){
        	print("Não entendi o que você quis dizer...")
			return true
		}
		let item = commandSplit[1]
		let itemFromInventary = inventory.searchItem(name: String(item))
		let itemFromScene = game.getScene().searchItemScene(name: String(item))
        if(itemFromInventary != nil){
			print(itemFromInventary!.getDescription())
		} else if(itemFromScene != nil){
			print(itemFromScene!.getDescription())
		} else {
        	print("Não entendi o que você quis dizer...")
			return true
		}
		let currentScene = self.game.getScene()
		if(currentScene.getIsQuick()){
			let stillTime = currentScene.passTime()
			print(currentScene.getTime(), "jogadas restantes")
			if (!stillTime){
				endGame()
			}
			return stillTime
		}
		return true
    }

	func talk(command: String) -> Bool {
		let commandSplit = command.split(separator:" ")
		if(commandSplit.count != 2 || commandSplit[0] != "talk"){
        	print("Não entendi o que você quis dizer...")
			return true
		}
		let item = commandSplit[1]
		let itemFromScene = game.getScene().searchItemScene(name: String(item))
		if(itemFromScene != nil){
			print(itemFromScene!.getSpeech())
		} else {
        	print("Não entendi o que você quis dizer...")
			return true
		}
		let currentScene = self.game.getScene()
		if(currentScene.getIsQuick()){
			let stillTime = currentScene.passTime()
			print(currentScene.getTime(), "jogadas restantes")
			if (!stillTime){
				endGame()
			}
			return stillTime
		}
		return true
    }

	func getItem(command: String) -> Bool {
		let commandSplit = command.split(separator:" ")
		if(commandSplit.count != 2 || commandSplit[0] != "get"){
        	print("Não entendi o que você quis dizer...")
			return true
		}
		let item = commandSplit[1]
		let itemFromScene = game.getScene().searchItemScene(name: String(item))
		if(itemFromScene != nil){
			// TODO: Change function name
			if(itemFromScene!.getIsInventoryItem()){
				if(!itemFromScene!.getStocked()){
					itemFromScene!.setStocked(state: true)
					inventory.addItem(item: itemFromScene!)
					print("O item foi adicionado ao inventario")
				} else {
					print("Esse item já está comigo")					
				}
			} else {
				print("Eu não acho que consigo fazer isso...")
			}
		} else {
        	print("Não entendi o que você quis dizer...")
			return true
		}
		let currentScene = self.game.getScene()
		if(currentScene.getIsQuick()){
			let stillTime = currentScene.passTime()
			print(currentScene.getTime(), "jogadas restantes")
			if (!stillTime){
				endGame()
			}
			return stillTime
		}
		return true
	}

	func useItemWith(command: String) -> Bool {
		let commandSplit = command.split(separator:" ")
		if(commandSplit.count != 4 || commandSplit[0] != "use" || commandSplit[2] != "with"){
        	print("Não entendi o que você quis dizer...")
			return true
		}

		let itemInInventory = commandSplit[1]
		let itemInScene = commandSplit[3]
		let itemFromInventary = inventory.searchItem(name: String(itemInInventory))
		let itemFromScene = game.getScene().searchItemScene(name: String(itemInScene))
		if(itemFromScene != nil && itemFromInventary != nil){
			if(itemFromScene!.getCommand().lowercased() == command){
				print(itemFromScene!.getPositiveResult())
				playSongSync(songName: game.getScene().getResolutionSong())
				game.setCurrentScene(value: itemFromScene!.getTargetScene())
				inventory.deleteItem(name: itemFromInventary!.getName())
				return true
			} else {
				print(itemFromScene!.getNegativeResult())
			}
		} else {
        	print("Não entendi o que você quis dizer...")
			return true
		}
		let currentScene = self.game.getScene()
		if(currentScene.getIsQuick()){
			let stillTime = currentScene.passTime()
			print(currentScene.getTime(), "jogadas restantes")
			if (!stillTime){
				endGame()
			}
			return stillTime
		}
		return true
	}

	func useItem(command: String) -> Bool {
		let commandSplit = command.split(separator:" ")
		if(commandSplit.count != 2 || commandSplit[0] != "use"){
        	print("Não entendi o que você quis dizer...")
			return true
		}
		let item = commandSplit[1]
		let itemFromScene = game.getScene().searchItemScene(name: String(item))
		if(itemFromScene != nil){
			if(itemFromScene!.getCommand().lowercased() == command){
				print(itemFromScene!.getPositiveResult())
				playSongSync(songName: game.getScene().getResolutionSong())			
				game.setCurrentScene(value: itemFromScene!.getTargetScene())
				return true
			} else {
				print(itemFromScene!.getNegativeResult())
			}
		} else {
        	print("Não entendi o que você quis dizer...")
			return true
		}
		let currentScene = self.game.getScene()
		if(currentScene.getIsQuick()){
			let stillTime = currentScene.passTime()
			print(currentScene.getTime(), "jogadas restantes")
			if (!stillTime){
				endGame()
			}
			return stillTime
		}
		return true
	}
}

func afirmativeAnswer(answer: String) -> Bool {
	if (answer == "sim" || answer == "Sim" || answer == "yes" || answer == "Yes"){
		return true
	}
	return false
}

func negativeAnswer(answer: String) -> Bool {
	if (answer == "não" || answer == "Não" || answer == "no" || answer == "No" || answer == "nao" || answer == "Nao"){
		return true
	}
	return false
}
