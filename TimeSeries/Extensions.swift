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

