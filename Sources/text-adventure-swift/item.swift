class Item{
    
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

    //Gets

    func get_id() -> Int {
        return self.id
    }

    func get_name() -> String {
        return self.name
    }

    func get_description() -> String {
        return self.description
    }

    func get_negative_result() -> String {
        return self.negative_result
    }

    func get_positive_result() -> String {
        return self.positive_result
    }

    func get_scene() -> Int {
        return self.scene
    }

     func get_stocked() -> Bool {
        return self.stocked
    }

    func get_resolved() -> Bool {
        return self.resolved
    }

    func get_key() -> Bool {
        return self.key
    }
    
    func get_command() -> String {
        return self.command
    }

    //Sets

     func set_stocked( state: Bool){
        self.stocked = state
    }

    func set_resolved( state: Bool){
        self.resolved = state
    }
}