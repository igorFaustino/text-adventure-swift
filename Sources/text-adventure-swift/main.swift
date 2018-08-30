import Foundation
import Rainbow
import LineNoise

let ln = LineNoise()

func menu(game: GameEngine) -> Bool{
	print("\nEscolha uma opção")
	
	print("newgame")
	print("load")
	print("help")
	print("exit")
	var command:String
	command = Bash.input()
	// print("\n")

	if (command == "newgame") {
		system("clear")
		sleep(1)
		game.printGameDescription()
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
		let command : String = Bash.input()
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
		// system("gedit . &")

		let path = URL(fileURLWithPath: "./Sources/json/game.json").path
		let myGame = GameEngine(filePath: path)

		// print game info
		myGame.printGameTitle()

		// main menu
		var gameRunning = true
		var repeatMenu = true
		while(repeatMenu) {
			repeatMenu = menu(game: myGame)
		}

		var currentScene: Int? = nil
		while(gameRunning){
			if(myGame.getCurrentScene() != currentScene){
				print("\n[Pressione enter para continuar]")
				_ = Bash.input()
				myGame.stopSongs()
				system("clear")
				sleep(1)
				myGame.playSceneSong()
				myGame.printScene()
				currentScene = myGame.getCurrentScene()
			}
			if(!myGame.isEndGame()){
				let command : String = Bash.input()
				gameRunning = myGame.processCommand(command: command)
			} else {
				print("Dejesa jogar novamente? [sim/não]")
				var command = Bash.input()
				while(!afirmativeAnswer(answer: command) && !negativeAnswer(answer: command)){

					command = Bash.input()
				}
				if (negativeAnswer(answer: command)){
					myGame.gameExit()
				} else {
					gameRunning = false
				}
			}
		
		}
		myGame.stopSongs()
	}

}


gameMain()