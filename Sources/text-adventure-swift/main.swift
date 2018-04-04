import Foundation
import Rainbow

func menu(game: GameEngine) -> Bool{
	print("\nEscolha uma opção?")
	
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
		print("load")
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

		// you need to pass the whole path to the file
		let myGame = GameEngine(filePath: "/home/neos/Documentos/Projetos/text-adventure-swift/Sources/json/test.json")

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
			if (myGame.getCurrentScene() != currentScene){
				myGame.printScene()
				currentScene = myGame.getCurrentScene()
			}
		
			print(" >".red, terminator: " ")
			let command : String! = readLine()
			// print("\n", terminator: "")
			gameRunning = myGame.processCommand(command: command)
		
		}

	}

}

gameMain()