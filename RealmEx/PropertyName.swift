public struct PropertyName: ExpressibleByStringLiteral {
    public let value: String
    
    public init(stringLiteral value: String) {
        self.value = value
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self.value = value
    }

    public init(unicodeScalarLiteral value: String) {
        self.value = value
    }
}
