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

    func searchItem(name: String) -> Item! {
        for item in self.vectorItens {
            if((item.stocked == true) && (item.name == name)){
                return item
            }
        }
        return nil
    }

    func deleteItem(name: String){
       if(searchItem(name: name) != nil){
            self.vectorItens = self.vectorItens.filter{ $0.name != name}
       }
    }
}

