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

	func last(where pred: (Iterator.Element) -> Bool) -> Iterator.Element? {
		return reversed().first(where: pred)
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










