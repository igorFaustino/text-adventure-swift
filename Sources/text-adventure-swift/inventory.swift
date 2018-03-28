class Inventory{
    var vectorItens: [Item]
    
    init(vectorItens:[Item]){
        self.vectorItens = [Item]()
    }

    func addItem(item: Item){
        self.vectorItens.append(item)
    }

    func printInventory(){
        for item in self.vectorItens{
            if item.stocked == true{
                print("\nNome: \(item.name)")
                print("Descriçao: \(item.description)")
            }
        }
    }

}

