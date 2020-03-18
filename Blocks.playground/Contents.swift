import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let workItem = DispatchWorkItem(qos: .utility, flags: .detached) {
    print("Performing workItem")
}

let queue = DispatchQueue(label: "name queue", qos: .utility, attributes: .concurrent, autoreleaseFrequency: .workItem, target: DispatchQueue.global(qos: .userInitiated))
//label: имя очереди
//qos: .utility - приоритет
//attributes: .concurrent - какая очередь
//autoreleaseFrequency: workItem, //пока не нужно
//target - переназначить очередь обьекта ///пока не нужно

queue.asyncAfter(deadline: .now() + 1, execute: workItem) // в очередь поместили  workItem
workItem.notify(queue: .main) {
    print("WORKITEM COMPLETED")
}

workItem.isCancelled // проверка или отменена работа = false

workItem.cancel() // отменить работу

workItem.isCancelled // проверка или отменена работа = true


workItem.wait()
