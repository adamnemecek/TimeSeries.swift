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

struct SortedArray<Element: Comparable> : BidirectionalCollection,  /* MutableCollection, RangeReplaceableCollection,, RandomAccessCollection,OrderedCollection,*/ ExpressibleByArrayLiteral   {
  private var content: [Element]

  public init() {
    content = []
  }

  init<S: Sequence>(_ seq: S) where S.Iterator.Element == Element {
    content = seq.sorted()
  }

  public init(arrayLiteral elements: Element...) {
    content = elements.sorted()
  }

  public var startIndex: Int {
    return content.startIndex
  }

  public var endIndex: Int {
    return content.endIndex
  }

  subscript (index: Int) -> Element {
    get {
      return content[index]
    }
    set {
      content[index] = newValue
    }
  }

  func index(after index: Int) -> Int {
    return index + 1
  }

  func index(before index: Int) -> Int {
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

  mutating
  func append<S: Sequence>(contentsOf newElements: S) where S.Iterator.Element == Element {
    content.append(contentsOf: newElements)
    content = content.sorted()
  }

  func index(of element: Element) -> Int? {
//    fatalError("implement")
    return content.index(of: element)
//    return nil
  }

  func sorted() -> [Element] {
    return content
  }

  func max() -> Element? {
    return content.last
  }

  func min() -> Element? {
    return content.first
  }
}




