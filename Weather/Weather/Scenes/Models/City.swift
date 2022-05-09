struct City {
    let id: Int
    let name: String
    var weather: Weather?
}

extension City: Comparable {
    static func == (lhs: City, rhs: City) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    static func < (lhs: City, rhs: City) -> Bool {
        lhs.name < rhs.name
    }
}
