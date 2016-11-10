
import Foundation

extension Int {
  static func random(_ max: UInt32 = UInt32.max) -> Int {
    return Int(arc4random_uniform(max))
  }
}


extension Int: TimestampType {}

struct Note: Temporal, CustomStringConvertible {
  let timestamp: Int //= Int.random(10000)
  let duration: Int // = Int.random(50)
  let pitch: Int 

  var description: String {
    return "Note(timestamp:\(timestamp), duration:\(duration), pitch: \(pitch))"
  }

  init(timestamp: Int, duration: Int, pitch: Int) {
    self.timestamp = timestamp
    self.duration = duration
    self.pitch = pitch
  }

  init() {
    timestamp = Int.random(10000)
    duration = Int.random(50)
    pitch = Int.random(50)
  }

  func advanced(by n: Int) -> Note {
    return Note(timestamp: timestamp + n, duration: duration, pitch: pitch)
  }

  func distance(to other: Note) -> Int {
    return timestamp - other.timestamp
  }
}

func ==(lhs: Note, rhs: Note) -> Bool {
  return lhs.timestamp == rhs.timestamp &&
        lhs.duration == rhs.duration &&
        lhs.pitch == rhs.pitch
}

func <(lhs: Note, rhs: Note) -> Bool {
  return lhs.timestamp < rhs.timestamp ||
         (lhs.timestamp == rhs.timestamp && lhs.pitch < rhs.pitch)

}



func test() {
  let q = (0...4).map { Note(timestamp: $0 * 10, duration : $0 * 10, pitch : $0 * 10) }
  let b = SortedArray(q + [q[0], q[0]])
  print(b.concurrent(after: 0))


}

test()


