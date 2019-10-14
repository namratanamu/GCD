//
//  ViewController.swift
//  gcd
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // doLongAsyncTaskInSerialQueue()
        //doLongsyncTaskInSerialQueue()
        //doLongAsyncTaskInConcurrentQueue()
        //doLongsyncTaskInConcurrentQueue()
        blockOperationTest1()
        //testQOS()
        //updateUI()
        //checkDispatchAfter()
        
    }
func doLongAsyncTaskInSerialQueue()
{
    let serialQueue=DispatchQueue(label: "com.queue.serial");
    for i in 1...10
    {
        serialQueue.async
        {
            if Thread.isMainThread
            {
                print("Task running in main thread \(i)");
                
            }
            else
            {
                print("Task running in background thread \(i)");
            }
            //let imageURL=URL(string:"https://s-media-cache-ak0.pinimg.com/736x/cf/0c/4a/cf0c4ad4e44827dabd080b9ed7312d8d.jpg")!
            //let data=try!Data(contentsOf : imageURL)
            //print("\(i) completed downloading")
            
        }
        
    }
}
    
    func doLongsyncTaskInSerialQueue()
    {
        let serialQueue=DispatchQueue(label: "com.queue.serial");
        for i in 1...10
        {
            serialQueue.sync
                {
                if Thread.isMainThread
                {
                    print("Task running in main thread\(i) ");
                    
                }
                else
                {
                    print("Task running in background thread\(i)");
                }
                //let imageURL=URL(string:"https://s-media-cache-ak0.pinimg.com/736x/cf///0c/4a/cf0c4ad4e44827dabd080b9ed7312d8d.jpg")!
                //let data=try!Data(contentsOf : imageURL)
               // print("\(i) completed downloading")
                
            }
            
        }
    }
        func doLongAsyncTaskInConcurrentQueue()
        {
            let concurrentQueue=DispatchQueue(label: "com.concurrent.queue", attributes: .concurrent)
            
            for i in 1...10
            {
                concurrentQueue.async
                    {
                        if Thread.isMainThread
                        {
                            print("Task running in main thread \(i)");
                            
                        }
                        else
                        {
                            print("Task running in background thread\(i)");
                        }
                     //   let imageURL=URL(string:"https://s-media-cache-ak0.pinimg.com///736x/cf/0c/4a/cf0c4ad4e44827dabd080b9ed7312d8d.jpg")!
                      //  let data=try!Data(contentsOf : imageURL)
                       // print("\(i) completed downloading")
                        
                }
                
            }
        }

    func testQOS()
    {
        let queue1 = DispatchQueue(label: "com.Qos.queue1", qos: DispatchQoS.userInitiated)
        let queue2 = DispatchQueue(label: "com.Qos.queue2", qos: DispatchQoS.background)
        queue1.async {
            for i in 1...10
            {
                print("😀")
            }
            
        }
        queue2.async {
            for i in 1...5
            {
            print("👿")
            }
            
        }
        

    }
    
    func updateUI()
    {
        DispatchQueue.main.async {
            print("Update UI here");

    }

        


    }
    func doLongsyncTaskInConcurrentQueue()
    {
        let concurrentQueue=DispatchQueue(label: "com.concurrent.queue", attributes: .concurrent)
        
        for i in 1...10
        {
            concurrentQueue.sync
                {
                    if Thread.isMainThread
                    {
                        print("Task running in main thread\(i)");
                        
                    }
                    else
                    {
                        print("Task running in background thread\(i)");
                    }
                   // let imageURL=URL(string:"https://s-media-cache-ak0.pinimg.com/736x/cf/0c/4a/cf0c4ad4e44827dabd080b9ed7312d8d.jpg")!
                   // let data=try!Data(contentsOf : imageURL)
                   // print("\(i) completed downloading")
                    
                }
            
            
            /* Task may run in main thread when you use sync in GCD. Sync runs a block on a given queue and waits for it to complete which results in blocking main thread or main queue.Since the main queue needs to wait until the dispatched block completes, main thread will be available to process blocks from queues other than the main queue.Therefore there is a chance of the code executing on the background queue may actually be executing on the main thread. Since its concurrent queue, tasks may not finish in the order they are added to queue. But with synchronous operation it does although they may be processed by different threads. So, it behaves as this is the serial queue.*/
        }
    
    }
    
    func blockOperationTest1()
    {
        let operationQueue = OperationQueue()
        let operation1 : BlockOperation = BlockOperation (block:
            {
            self.doCalculations()
            })
            let operation2 : BlockOperation = BlockOperation (block: {
                
                self.doSomeMoreCalculations()
               })
        operation1.addDependency(operation2)

            operationQueue.addOperation(operation2)
       
        operationQueue.addOperation(operation1)
        //operationQueue.cancelAllOperations()
        
        
        //main queue
//        let operationQueueM:OperationQueue = OperationQueue.main
//        operationQueueM.addOperation(operation1)
//        operationQueueM.addOperation(operation2)
        
        }
        
    
        func doCalculations(){
            print("do Calculations")
            for i in 100...105{
                print("i in do calculations is \(i)")
                sleep(1)
            }
        }
        
        func doSomeMoreCalculations(){
            print("do Some More Calculations")
            for j in 1...5{
                print("j in do some more calculations is \(j)")
                sleep(1)
            }
            
        }

    func checkDispatchAfter() {
        let deadlineTime = DispatchTime.now() + .seconds(5)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            print("test")
        }    }


}
/*The information regarding the importance and priority of the tasks is called in GCD Quality of Service (QoS). In truth, QoS is an enum with specific cases, and by providing the proper QoS value upon the queue initialisation you specify the desired priority. If no QoS is defined, then a default priority is given by to the queue. The available options along with some documentation can be found here, and make sure that you’ll see that webpage. The following list summarises the available QoS cases, also called QoS classes. The first class means the highest priority, the last one the lowest priority:

userInteractive
userInitiated
default
utility
background
unspecified*/
