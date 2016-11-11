//
//  SequenceableSlice.swift
//  TimeSeries
//
//  Created by Adam Nemecek on 11/10/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation

//protocol SliceProtocol: Collection {
//  associatedtype Base
//  var base: Base { get }
//  init(base: Base, bounds: Range<Index>)
//}
//
//extension Slice: SliceProtocol { }

/*
struct SequenceableSlice<Base: MutableSequenceable>: MutableSequenceable, MutableCollection where Base.Iterator.Element: Temporal {

  typealias Element = Base.Iterator.Element
  typealias Timestamp = Element.Timestamp
  typealias Index = Base.Index

  private(set) var base: Base

  let startIndex: Index
  let endIndex: Index

  let startTimestamp: Timestamp
  let endTimestamp: Timestamp

  internal init(base: Base, bounds: Range<Index>) {
    self.base = base

    self.startIndex = bounds.lowerBound
    self.endIndex = base.index(after: bounds.upperBound)

    self.startTimestamp = base[bounds.lowerBound].timestamp
    self.endTimestamp = base[bounds.upperBound].timestamp
  }

  public func index(of timestamp: Timestamp, insertion: Bool) -> Index? {
    fatalError()
  }

  func move(by: Timestamp) -> SequenceableSlice {
    fatalError()
  }


  init(base: Base, timerange: Range<Timestamp>) {
    self.base = base
    self.startTimestamp = timerange.lowerBound
    self.endTimestamp = timerange.upperBound
    let r : Timestamp = timerange.lowerBound
    base.index(of: <#T##Base.Timestamp#>, insertion: <#T##Bool#>)

    let t = base.index(of: timerange.lowerBound, insertion: false)
    let z =  t ?? Timestamp()
    self.startIndex = z
    self.endIndex = base.index(of: timerange.upperBound, insertion: true) ?? Timestamp()
  }

  subscript (index: Index) -> Element {
    get {
      return base[index]
    }
    set {
      base[index] = newValue
    }
  }

  subscript (bounds: Range<Index>) -> SequenceableSlice {
     get {
      fatalError()
      }
      set {
        fatalError()
      }
  }

  func index(before i: Index) -> Index {
    return base.index(before: i)
  }

  func index(after i: Index) -> Index {
    return base.index(after: i)
  }

}

*/
