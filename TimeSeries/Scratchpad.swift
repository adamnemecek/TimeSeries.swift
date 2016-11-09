//
//  Scratchpad.swift
//  TimeSeries
//
//  Created by Adam Nemecek on 11/9/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation

extension BidirectionalCollection {
  var extrema: (first: Iterator.Element, last: Iterator.Element)? {
    return first.map { ($0, last!) }
  }

  func extrema(predicate: (Iterator.Element) -> Bool) -> (first: Iterator.Element, last: Iterator.Element)? {
		let f = filter(predicate)
		return f.first.map { ($0, f.last!) }
	}
}

