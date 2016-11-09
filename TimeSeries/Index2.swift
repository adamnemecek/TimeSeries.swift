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

