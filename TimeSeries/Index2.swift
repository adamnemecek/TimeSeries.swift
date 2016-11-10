//
//  Index2.swift
//  TimeSeries
//
//  Created by Adam Nemecek on 11/9/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation


enum Index2<E: Temporal>: Comparable, ExpressibleByIntegerLiteral {
  case linear(index: Int), complex(timestamp: E.Timestamp, offset: Int)

  init(integerLiteral value: E.Timestamp.IntegerLiteralType) {
    self = .complex(timestamp: E.Timestamp(integerLiteral: value), offset: 0)
  }

  init(timestamp: E.Timestamp, offset: Int = 0) {
    self = .complex(timestamp: timestamp, offset: 0)
  }

  internal init(index: Int) {
    self = .linear(index: index)
  }

  var isLinear: Bool {
    if case .linear = self {
      return true
    }
    return false
  }
}

func ==<E>(lhs: Index2<E>, rhs: Index2<E>) -> Bool {
  switch (lhs, rhs) {
    case (.linear(let l), .linear(let r)):
      return l == r
    case (.complex(let lts, let lo), .complex(let rts, let ro)):
      return lts == rts && lo == ro
    default:
      return false
  }
}


func <<E>(lhs: Index2<E>, rhs: Index2<E>) -> Bool {
  switch (lhs, rhs) {
    case (.linear(let l), .linear(let r)):
      return l < r
    case (.complex(let lts, let lo), .complex(let rts, let ro)):
      return lts < rts && lo < ro
    default:
      return false
  }
}


extension TimeSeries {
  var startIndex2: Index2<Event> {
    return .linear(index: content.startIndex)
  }

  var endIndex2: Index2<Event> {
    return .linear(index: content.endIndex)
  }

  //todo private
  func complexify(index: Int) -> Index2<Event> {
    return .complex(timestamp: Timestamp(), offset: index)
  }

  //todo private
  func linearize(index: Index2<Event>) -> Int? {
    switch index {
      case .linear(let i):
        return i
      case .complex(let timestamp, let offset):
        //
        // todo binary search
        //
        guard let idx = (content.index { $0.timestamp == timestamp }) else { return nil }
//        return .linear(index: idx + offset)
        return idx + offset
    }
  }

  subscript (index2 index: Index2<Event>) -> Event? {
    return linearize(index: index).map { content[$0] }
  }

  func index2(after index: Index2<Event>) -> Index2<Event> {
    fatalError()
  }

}
extension TimeSeries {
  public subscript(bounds: Range<Index>) -> SubSequence {
    get {
//      let ind = linrange(bounds: bounds)
//      dump(ind)
//      return content[ind]
      let id = self.linearize(index: bounds.lowerBounds)

      let i = indices.filter { bounds.contains($0) }
      print("indices: \(i)")
      print("self.indices: \(self.indices)")
      return i.extrema.map { self.content[$0.first.index!..<$0.last.index!] } ?? []

//      return i.extrema.map { self.content[Range(uncheckedBounds: $0)] } ?? []
//      fatalError()

    }
    set {
      fatalError()
//      replaceSubrange(linrange(bounds: bounds), with: newValue)
    }
}


//extension TimeSeries {
//  typealias Ind = Index2<Event>
//
//  func linearize(index: Ind) -> Ind {
//    if case .complex(let timestamp, let offset) = index {
//
//
//      let cnt =
//       return .linear(cnt + offset)
//    }
//    return index
//  }
//
//  func get(index: Index2<Event>) -> Event {
//    switch index {
//      case .linear(let l):
//        return
//    }
//  }
//}
//

