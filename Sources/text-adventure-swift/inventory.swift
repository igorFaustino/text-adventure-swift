class Inventory{
    var vectorItens: [Item]
    
    init(vectorItens:[Item]){
        self.vectorItens = [Item]()
    }

    func getItens() -> [Item] {
        return self.vectorItens
    }

    func addItem(item: Item){
        self.vectorItens.append(item)
    }

    func printInventory(){
        if(self.vectorItens.count == 0){
            print("Empty")
            return
        }
        for item in self.vectorItens {
            print("\(item.name)", terminator:" ")
        }
        print("")
    }

    func searchItem(name: String) -> Item! {
        for item in self.vectorItens {
            if (item.getName().lowercased() == name.lowercased()){
                return item
            }
        }
        return nil
    }

    func deleteItem(name: String){
       if (searchItem(name: name) != nil){
            self.vectorItens = self.vectorItens.filter{ $0.name != name}
       }
    }
}

