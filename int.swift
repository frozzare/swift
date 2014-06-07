extension Int {
    
    func times (iterator: () -> Void) {
        for _ in 0..self {
            iterator()
        }
    }
    
    func downto (to : Int, iterator: (Int) -> Void) {
        var num : Int = self
        while num != to - 1 {
            iterator(num)
            num--
        }
    }
    
    func upto (to : Int, iterator: (Int) -> Void) {
        var num : Int = self
        while num != to + 1 {
            iterator(num)
            num++
        }
    }
    
    func even (num: Int) -> Bool {
        return self == num
    }
    
    func next () -> Int {
        return self + 1
    }
    
    func pred () -> Int {
        return self - 1
    }
    
}

2.times {
    println("Hello, world")
}

2.downto(1) {
    i in print("\(i)..")
}

var isEven : Bool = 2.even(3)

println(isEven)

4.upto(8) {
    i in print("\(i)..")
}