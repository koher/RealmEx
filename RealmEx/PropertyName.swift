public struct PropertyName: StringLiteralConvertible {
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