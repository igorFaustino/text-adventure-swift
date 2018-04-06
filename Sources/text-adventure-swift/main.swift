import Foundation
import Rainbow

func menu(game: GameEngine) -> Bool{
	print("\nEscolha uma opção")
	
	print("newgame")
	print("load")
	print("help")
	print("exit")
	print(" >".red, terminator: " ")
	let command = readLine()
	// print("\n")

	if (command == "newgame") {
		print("newgame")
	} else if (command == "load") {
		// Get all save names to show for the user
		let fileMngr = FileManager.default;
		let savePath = URL(fileURLWithPath: "./Sources/json/saves/").path
    	let saveFiles = try! fileMngr.contentsOfDirectory(atPath: savePath)
		print("Escolha um save...")
		for save in saveFiles{
			print("-", save.replacingOccurrences(of: ".json", with: ""))
		}

		print("\nDigite o nome do save ou digite cancelar para voltar ao menu principal...")
		print(" >".red, terminator: " ")
		let command : String! = readLine()
		if (command.lowercased() == "cancelar"){
			return true
		}
		let path = URL(fileURLWithPath: "./Sources/json/saves/" + command + ".json").path
		return !game.loadGame(filePath: path)
	} else if (command == "help") {
		game.printHelp()
		return true
	} else if (command == "exit"){
		game.gameExit()
	} else {
		print("\nNão entendi o que vc está querendo fazer..")
		return true
	}

	return false
}

func gameMain(){

	while(true){
		// clear all the text in the bash
		system("clear")

		// you need to pass the whole path to the file -> this is bad!!
		let path = URL(fileURLWithPath: "./Sources/json/test.json").path
		let myGame = GameEngine(filePath: path)

		// print game info
		myGame.printGameTitle()
		myGame.printGameDescription()

		// main menu
		var gameRunning = true
		var repeatMenu = true
		while(repeatMenu) {
			repeatMenu = menu(game: myGame)
		}

		var currentScene: Int? = nil
		while(gameRunning){
			if(myGame.getCurrentScene() != currentScene){
				print("\n[Digite enter para continuar]")
				_ = readLine()
				system("clear")
				sleep(1)
				myGame.printScene()
				currentScene = myGame.getCurrentScene()
			}
			if(!myGame.isEndGame()){
				print(" >".red, terminator: " ")
				let command : String! = readLine()
				// print("\n", terminator: "")
				gameRunning = myGame.processCommand(command: command)
			} else {
				print("Dejesa jogar novamente? [sim/não]")
				let command = readLine()
				if (command == "não"){
					myGame.gameExit()
				} else {
					gameRunning = false
				}
			}
		
		}

	}

}

gameMain()