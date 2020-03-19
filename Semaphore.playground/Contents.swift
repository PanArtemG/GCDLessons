import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let queue = DispatchQueue(label: "semaphore", attributes: .concurrent)

let semaphore = DispatchSemaphore(value: 2)

queue.async {
    semaphore.wait(timeout: .distantFuture) //ждем пока не получим сигнал
    Thread.sleep(forTimeInterval: 4) // Останвливаем поток на 4 секунды
    print(" BLOCK 1")
    semaphore.signal()
}

queue.async {
    semaphore.wait(timeout: .distantFuture) //ждем пока не получим сигнал
    Thread.sleep(forTimeInterval: 2) // Останвливаем поток на 2 секунды
    print(" BLOCK 2")
    semaphore.signal()
}

queue.async {
    semaphore.wait(timeout: .distantFuture) //ждем пока не получим сигнал
    print(" BLOCK 3")
    semaphore.signal()
}

queue.async {
    semaphore.wait(timeout: .distantFuture) //ждем пока не получим сигнал
    print(" BLOCK 4")
    semaphore.signal()
}

/*
 Выполненее:
 BLOCK 1 и BLOCK 2 забрали на себя 2 разрешенных потока ( DispatchSemaphore(value: 2)) - (value: 0)
 BLOCK 2 выполнился, сработал semaphore.signal() - (value: 1)
 Запустился BLOCK 3 - (value: 0)
 BLOCK 3 выполнился, сработал semaphore.signal() - (value: 1)
 Запустился BLOCK 4 - (value: 0)
 спксят 4 секунды запустился BLOCK 1 (Thread.sleep(forTimeInterval: 4))
*/


//BLOCK 2
//BLOCK 3
//BLOCK 4
//BLOCK 1
