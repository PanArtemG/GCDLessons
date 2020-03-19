import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let queue = DispatchQueue(label: "sources", attributes: .concurrent)

// 1 Create timer
let timer = DispatchSource.makeTimerSource(queue: queue)


/*
// 3 Seting timer
 deadline - начало работы
 repeating - повтор тиков
 leeway - запаздывание
 */
timer.schedule(deadline: .now(), repeating: .seconds(2), leeway: .milliseconds(300))

// 3 Create Handler
timer.setEventHandler{
    print("Hello")
}

// 4 Create cacel block
timer.setCancelHandler {
    print("Timer cancel")
}

// Run timer
timer.resume()
