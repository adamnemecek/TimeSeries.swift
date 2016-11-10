//
//  SortedArray.swift
//  ATWrappers
//
//  Created by Adam Nemecek on 10/1/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation

public struct SortedArray<Element: Comparable> : MutableCollection, ExpressibleByArrayLiteral, DefaultConstructible, SortedCollection {

  public typealias SubSequence = ArraySlice<Element>
  public typealias Index = Int

  fileprivate var content: [Element]

  public init() {
    content = []
  }

  public init<S: Sequence>(_ seq: S) where S.Iterator.Element == Element {
    content = seq.sorted()
  }

  public init(arrayLiteral elements: Element...) {
    content = elements.sorted()
  }

  public var startIndex: Index {
    return content.startIndex
  }

  public var endIndex: Index {
    return content.endIndex
  }

  public subscript (index: Index) -> Element {
    get {
      return content[index]
    }
    set {
      content[index] = newValue
      content = content.sorted()
    }
  }

  public subscript(bounds: Range<Index>) -> SubSequence {
    get {
      return content[bounds]
    }
    set {
      replaceSubrange(bounds, with: newValue)
    }
  }

  public func index(after index: Index) -> Index {
    return index + 1
  }

  public func index(of element: Element) -> Index? {
//    fatalError("implement")
    return content.index(of: element)
//    return nil
  }
}

extension SortedArray {
  public func sorted() -> [Element] {
    return content
  }

  public func max() -> Element? {
    return content.last
  }

  public func min() -> Element? {
    return content.first
  }
}

extension SortedArray: RangeReplaceableCollection {
  public mutating func replaceSubrange<C: Collection>(_ subrange: Range<Index>, with newElements: C) where C.Iterator.Element == Element {
    //
    // todo: optimize
    //
    content.replaceSubrange(subrange, with: newElements)
    content = content.sorted()
  }

  public mutating func append<S: Sequence>(contentsOf newElements: S) where S.Iterator.Element == Element {
    content.append(contentsOf: newElements)
    content = content.sorted()
  }
}

extension SortedArray: BidirectionalCollection {
  public func index(before index: Index) -> Index {
    return index - 1
  }
}


//extension SortedArray where Element: Temporal  {
//  //
//  // todo: optimize all of these
//  //
//
//  func before(timestamp: Element.Timestamp) -> Int {
//    return filter { $0.timestamp < timestamp }.count
//  }
//
//  func after(timestamp: Element.Timestamp) -> Int {
//    return filter { $0.timestamp > timestamp }.count
//  }
//
//  func concurrent(at timestamp: Element.Timestamp) -> Int {
//    return filter { $0.timestamp == timestamp }.count
//  }
//
//  func indices(of domain: Range<Element.Timestamp>) -> Range<Index> {
//    fatalError()
//  }
//
////  func count(at timestamp: Element.Timestamp) -> Int {
//////    fatalError()
////    //return reduce(0) { $0 + Int($1.timestamp == timestamp) }
////    return count (where: { $0.timestamp == timestamp } )
////  }
////
////  func count(until timestamp: Element.Timestamp) -> Int {
//////    fatalError()
//////    return reduce(0) { $0 + Int($1.timestamp < timestamp) }
////    return count(where: { $0.timestamp < timestamp } )
////  }
////
////  func count(from timestamp: Element.Timestamp) -> Int {
//////    return reduce(0) { $0 + Int(timestamp < $1.timestamp) }
////    fatalError()
////  }
//}

