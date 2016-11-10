//
//  Extensions.swift
//  TimeSeries
//
//  Created by Adam Nemecek on 11/9/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation

extension Sequence {
	func first(where pred: (Iterator.Element) -> Bool) -> Iterator.Element? {
		for e in self where pred(e) {
			return e
		}
		return nil
	}

//	func last(where pred: (Iterator.Element) -> Bool) -> Iterator.Element? {
//		return reversed().first(where: pred)
//	}
}

extension Sequence {
  func countAll(pred: @escaping (Iterator.Element) -> Bool) -> Int {
    return reduce(0) { $0 + Int(pred($1)) }
  }

  func countWhile(pred: @escaping (Iterator.Element) -> Bool) -> Int {
    var g = makeIterator()
    var count = 0
    while let n = g.next(), pred(n) {
      count += 1
    }
    return count
  }
}

extension Strideable where Stride: ExpressibleByIntegerLiteral {
	func forward() -> Self {
		return advanced(by: 1)
	}

	func backward() -> Self {
		return advanced(by: -1)
	}
}

extension Collection where SubSequence: Collection, SubSequence.Iterator.Element == Iterator.Element, SubSequence.Index == Index {
	func range(where pred: (Iterator.Element) -> Bool) -> Range<Index>? {
		guard let start = index(where: pred) else { return nil }
		guard let end = (self[start..<endIndex].index { !pred($0) }) else { return nil }
		return start..<end
	}

}

extension Collection {
  func split(at index: Index) -> (SubSequence, Iterator.Element, SubSequence) {
    return (self[startIndex..<index], self[index], self[self.index(after:index)..<endIndex] )
  }
}

extension Sequence where SubSequence: Sequence, SubSequence.Iterator.Element == Iterator.Element {
	func tuples() -> AnyIterator<(Iterator.Element, Iterator.Element)> {
		return AnyIterator(zip(dropFirst(), dropLast()).makeIterator())
	}
}


public extension Int {
  init(_ value: Bool) {
    self = value ? 1 : 0
  }
}

extension Range {
	init(bound: Bound) {
		self.init(bound..<bound)
	}
}






extension BidirectionalCollection {
  //
  // like index
  //
  func lastIndex(where predicate: (Iterator.Element) -> Bool) -> Index? {
    var start = endIndex

    while true {
      let prev = index(before: start)
      if predicate(self[prev]) {
        return prev
      }
      start = prev
    }
    return nil
  }
}




