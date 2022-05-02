//
//  StoreClient.swift
//  CopperTest
//
//  Created by Vadim Chistiakov on 30.04.2022.
//

import Foundation
import CoreData

final class StoreClient {
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private(set) lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
            
        container.loadPersistentStores(completionHandler: { (_, error) in
            guard let error = error as NSError? else { return }
            fatalError("Unresolved error: \(error), \(error.userInfo)")
        })
            
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    func saveOrders(orders: [Order]) {
        
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        
        taskContext.performAndWait {
            orders.forEach {
                self.convert($0, context: taskContext)
            }
            guard taskContext.hasChanges else { return }
            do {
                try taskContext.save()
            } catch {
                print("Error: \(error)\nCould not save Core Data context.")
            }
            taskContext.reset()
        }
    }
    
    private func convert(_ order: Order, context: NSManagedObjectContext) {
        let orderDB = OrderDB(context: context)
        orderDB.orderId = order.orderId
        orderDB.orderStatusRaw = order.orderStatus.rawValue
        orderDB.createdAt = Date(timeIntervalSince1970: (Double(order.createdAt) ?? 0) / 1000)
        orderDB.amount = Double(order.amount) ?? 0
        orderDB.currency = order.currency
        orderDB.orderTypeRaw = order.orderType.rawValue
    }
    
}
        
