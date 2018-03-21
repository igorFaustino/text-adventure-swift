class item{
    
    var id : Int // id for identify in the Save
    var name: String
    var description: String
    var negative_result: String
    var positive_result: String
    var scene : Int
    var stocked: Bool
    var resolved: Bool
    var key: Bool // key for puzzle
    var command: String

    init(   id : Int,
            name: String,
            description: String,
            negative_result: String,
            positive_result: String,
            scene : Int,
            stocked: Bool,
            resolved: Bool,
            key: Bool, 
            command: String )
    {
        self.id = id
        self.name = name
        self.description = description
        self.negative_result = negative_result
        self.positive_result = positive_result
        self.scene = scene
        self.stocked = stocked
        self.resolved = resolved
        self.key = key
        self.command = command
    } 

}