// This code is an example implementation of a Swift Evolution for the inclusion of last(where:),
// lastIndex(where:), and lastIndex(of:) methods in the Collection protocol.

extension Collection {
    /// Returns the last element of the collection that satisfies the given
    /// predicate, or `nil` if no element does.
    func last(where predicate: @noescape (Iterator.Element) throws -> Bool) 
        rethrows -> Iterator.Element? 
    {
        return try lastIndex(where: predicate).map({ self[$0] })
    }

    /// Returns the index of the last element of the collection that satisfies 
    /// the given predicate, or `nil` if no element does.
    func lastIndex(where predicate: @noescape (Iterator.Element) throws -> Bool) 
        rethrows -> Index? 
    {
        var found: Index?
        for i in indices {
            if try predicate(self[i]) {
                found = i
            }
        }
        return found
    }
}
extension Collection where Iterator.Element: Equatable {
    /// Returns the index of the last element equal to the given element, or 
    /// `nil` if there is no equal element.
    func lastIndex(of element: Iterator.Element) -> Index? {
        return lastIndex(where: { $0 == element })
    }
}
extension Collection where Index: BidirectionalIndex {
    /// Returns the index of the last element of the collection that satisfies 
    /// the given predicate, or `nil` if no element does.
    func lastIndex(where predicate: @noescape (Iterator.Element) throws -> Bool) 
        rethrows -> Index? 
    {
        for i in indices.reversed() {
            if try predicate(self[i]) {
                return i
            }
        }
        return nil
    }
}

let a = [20, 30, 10, 40, 20, 30, 10, 40, 20]
print(a.lastIndex(of: 40))
print(a.last(where: { $0 > 25 }))


777777777777777777777777777777777
