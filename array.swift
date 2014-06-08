import Foundation

extension Array {
  
  /**
   * Get first item in array.
   *
   * @return First item in array.
   */
  
  func first () -> T? {
    return count > 0 ? self[0] : nil
  }
  
  /**
   * Get last item in array.
   *
   * @return Last item in array.
   */
  
  func last () -> T? {
    return count > 0 ? self[count - 1] : nil
  }
  
  /**
   * Skip items.
   *
   * @return Array
   */
  
  func skip (var n: Int) -> Array<T> {
    return self[n..count]
  }
  
  /**
   * Take numbers of items.
   *
   * @return Array
   */
  
  func take (n: Int) -> Array<T> {
    return self[0..n]
  }
  
  /**
   * Get the sum of the array.
   *
   * @return Int
   */
  
  func sum() -> Int {
    return reduce(0) { ($0 as Int) + ($1 as Int) }
  }
  
  /**
   * Get the sum of the array.
   *
   * @return Int
   */
  
  func sum (iterator: (T) -> Int) -> Int {
    return map { iterator($0) as Int }.sum()
  }
  
  /**
   * Run a function on each item.
   */
  
  func each (iterator: (T) -> Void) {
    for var i = 0; i < count; i++ {
      iterator(self[i])
    }
  }
  
  /**
   * Create a subscript that support range for arrays.
   *
   * @return Array
   */

  subscript (range: Range<Int>) -> Array<T> {
    var array = Array<T>()
    
    let min = range.startIndex
    let max = range.endIndex

    for var i = min; i < max; i++ {
      array += [self[i]]
    }

    return array
  }
}

// Test code

class NumTest {
  var n : Int = 0
  init (_ n: Int) {
    self.n = n
  }
}

let numTests = [NumTest(1), NumTest(3)]

let numTestSum = numTests.sum ({
  n in return n.n
})

let letters = ["a", "b", "c"]

letters.each({
  n in println(n)
})