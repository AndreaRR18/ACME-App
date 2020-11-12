public protocol Updatable {
  
    associatedtype UpdateType
    
    func update(_ value: UpdateType)

}
