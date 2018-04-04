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
		// initialized class.. without that we can't call any methods
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
				endGame: scene["isEndGame"].bool!
			))
		}
		return Game(
			gameTitle: self.json["gameTitle"].string!,
			gameDescription: self.json["gameDescription"].string!,
			currentScene: 0,
			scenes: scenes
		)
	}

	func loadGame(filePath: String) {
		// TODO: Test this function
		let loadGameFile: FileHandle! = FileHandle(forReadingAtPath: filePath)
		let loadGameData: Data = loadGameFile!.readDataToEndOfFile()
		let loadGameJson: JSON = JSON(data: loadGameData)

		for (_, item):(String, JSON) in loadGameJson["inventory"] {
			self.inventory.addItem(item: Item(
				id: item["id"].int!,
				name: item["name"].string!,
				description: item["description"].string!,
				negativeResult: item["negativeResult"].string!,
				positiveResult: item["positiveResult"].string!,
				targetScene: item["targetScene"].int!,
				stocked: item["stocked"].bool!,
				isInventoryItem: item["isInventoryItem"].bool!,
				resolved: item["resolved"].bool!,
				key: item["key"].bool!, 
				command: item["command"].string!
			))
		}
		self.game.setCurrentScene(value: loadGameJson["currentScene"].int!)
	}

	// TODO: work in this!
	func saveGame(filePath: String) {

	}

	func getCurrentScene() -> Int {
		return self.game.getCurrentScene()
	}

	func initRadioMessagesFromFile() -> [String] {
		// work in progress..
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
		if (command == "help"){
			printHelp()
		} else if (command == "exit"){
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
		} else if (command == "restart") {
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
		} else if(command == "save"){
			// do the save stuff here
		} else if (command == "use radio"){
			useRadio()
		} else if (command == "inventory"){
			inventory.printInventory()
		} else if (command.range(of: "check") != nil){
			checkItem(command: command)
		} else if (command.range(of: "get") != nil){
			getItem(command: command)
		} else if (command.range(of: "use") != nil && command.range(of: "with") == nil){
			useItem(command: command)
		} else if (command.range(of: "use") != nil && command.range(of: "with") != nil){
			useItemWith(command: command)
		} else {
			print("Não entendi o que voce quis dizer...")
		}

		return true
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
		system("clear")
		exit(0)
	}

	// check item
	func checkItem(command: String){
		let commandSplit = command.split(separator:" ")
		if(commandSplit.count < 2){
        	print("Não entendi o que você quis dizer...")
			return
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
			return
		}
    }

	func getItem(command: String){
		let commandSplit = command.split(separator:" ")
		if(commandSplit.count < 2){
        	print("Não entendi o que você quis dizer...")
			return
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
					return					
				}
			} else {
				print("Eu não acho que consigo fazer isso...")
				return
			}
		} else {
        	print("Não entendi o que você quis dizer...")
			return
		}
	}

	func useItemWith(command: String){
		let commandSplit = command.split(separator:" ")
		if(commandSplit.count < 2){
        	print("Não entendi o que você quis dizer...")
			return
		}

		let itemInInventory = commandSplit[1]
		let itemInScene = commandSplit[3]
		let itemFromInventary = inventory.searchItem(name: String(itemInInventory))
		let itemFromScene = game.getScene().searchItemScene(name: String(itemInScene))
		if(itemFromScene != nil && itemFromInventary != nil){
			if(itemFromScene!.getCommand() == command){
				print(itemFromScene!.getPositiveResult())
				game.setCurrentScene(value: itemFromScene!.getTargetScene())
			} else {
				print(itemFromScene!.getNegativeResult())
				return
			}
		} else {
        	print("Não entendi o que você quis dizer...")
			return
		}
	}

	func useItem(command: String){
		let commandSplit = command.split(separator:" ")
		if(commandSplit.count < 2){
        	print("Não entendi o que você quis dizer...")
			return
		}
		let item = commandSplit[1]
		let itemFromScene = game.getScene().searchItemScene(name: String(item))
		if(itemFromScene != nil){
			if(itemFromScene!.getCommand() == command){
				print(itemFromScene!.getPositiveResult())
				game.setCurrentScene(value: itemFromScene!.getTargetScene())
			} else {
				print(itemFromScene!.getNegativeResult())
				return
			}
		} else {
        	print("Não entendi o que você quis dizer...")
			return
		}
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