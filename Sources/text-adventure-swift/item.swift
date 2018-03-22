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

    func get_id(item: item) -> Int {
        return item.id
    }

    func get_name(item: item) -> String {
        return item.name
    }

    func get_description(item: item) -> String {
        return item.description
    }

    func get_negative_result(item: item) -> String {
        return item.negative_result
    }

    func get_positive_result(item: item) -> String {
        return item.positive_result
    }

    func get_scene(item: item) -> Int {
        return item.scene
    }

     func get_stocked(item: item) -> Bool {
        return item.stocked
    }

    func get_resolved(item: item) -> Bool {
        return item.resolved
    }

    func get_key(item: item) -> Int {
        return item.key
    }
    
    func get_command(item: item) -> String {
        return item.command
    }

    //Sets

     func set_stocked(item: item, state: Bool){
        item.stocked = state
    }

    func set_resolved(item: item, state: Bool){
        item.stocked = state
    }
}