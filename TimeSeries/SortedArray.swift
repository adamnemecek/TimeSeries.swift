//
//  SortedArray.swift
//  ATWrappers
//
//  Created by Adam Nemecek on 10/1/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation

//protocol OrderedCollection: Collection {
//  associatedtype _Element: Comparable = Iterator.Element
//}



public struct SortedArray<Element: Comparable> : MutableCollection, RangeReplaceableCollection,/* RandomAccessCollection, OrderedCollection,*/ ExpressibleByArrayLiteral  {

  public typealias SubSequence = Slice<[Element]>
  public typealias Index = Int

  private var content: [Element]

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

  public  subscript (index: Index) -> Element {
    get {
      return content[index]
    }
    set {
      content[index] = newValue
    }
  }

  public subscript(bounds: Range<Index>) -> SubSequence {
    get {
      fatalError()
    }
    set {
      fatalError()
    }
  }

  public func index(after index: Index) -> Index {
    return index + 1
  }

  public func index(before index: Index) -> Index {
    return index - 1
  }

  public mutating
  func replaceSubrange<C: Collection>(_ subrange: Range<Int>, with newElements: C) where C.Iterator.Element == Element {
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

  public func index(of element: Element) -> Index? {
//    fatalError("implement")
    return content.index(of: element)
//    return nil
  }

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




