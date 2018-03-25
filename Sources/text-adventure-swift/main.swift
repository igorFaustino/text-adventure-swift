import Foundation

// clear all the text in the bash
system("clear")

var typeWriter = TypeWriter()

// you need to pass the whole path to the file
let myGame = GameEngine(filePath: "/home/igor/Documents/code/faculdade/5_periodo/lp/text-adventure-swift/Sources/json/test.json")

myGame.printGameDescription()
// sleep(1)

var repeatMenu = true
while(repeatMenu) {
	repeatMenu = false
	typeWriter.typeOn(string: "O que dejesa fazer?")
	
	print("newgame")
	print("load")
	print("help")
	print("exit")
	print(">", terminator: " ")
	let command = readLine()

	if (command == "newgame") {
		print("newgame")
	} else if (command == "load") {
		print("load")
	} else if (command == "help") {
		print("help")
	} else if (command == "exit"){
		exit(0)
	} else {
		print("Não entendi o que vc está querendo fazer..\n")
		sleep(1)
		repeatMenu = true
	}
}