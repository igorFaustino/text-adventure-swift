import LineNoise


class Bash {
    static let ln = LineNoise()
    
    static func input() -> String {
        do {
            let input = try ln.getLine(prompt: "> ")
            ln.addHistory(input)
            print("")
            return input
        } catch {
            print(error)
        }
        return ""
    }
}