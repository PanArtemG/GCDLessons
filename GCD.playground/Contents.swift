import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class SafeArray<Element> {
    private var array = [Element]()
    private let queue = DispatchQueue(label: "DispatchBarrier", attributes: .concurrent)
    
    public func append(el: Element) {
        queue.async(flags: .barrier) { // аппендим елементы по очереди 
            self.array.append(el)
        }
    }
    
    public var elements: [Element] {
        var result = [Element]()
        queue.sync { // обращаемся за результатом но ждем пока он выполнится полностью
            result = self.array
        }
        return result
    }
}

var safeArray = SafeArray<Int>()
DispatchQueue.concurrentPerform(iterations: 20) { (index) in
    safeArray.append(el: index)
}

print("safeArray: \(safeArray.elements)")


var array = [Int]()
// паралельные запросы
DispatchQueue.concurrentPerform(iterations: 20) { (index) in //DispatchQueue.concurrentPerform(iterations: 20) - паралельные запросы
    array.append(index)
}

print("array: \(array)")
