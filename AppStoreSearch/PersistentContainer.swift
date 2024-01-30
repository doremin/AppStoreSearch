//
//  PersistentContainer.swift
//  AppStoreSearch
//
//  Created by doremin on 1/29/24.
//

import CoreData

enum PersistentContainerError: Error {
  case readFail(Error)
  case saveFail(Error)
  case deleteFail(Error)
}

protocol PersistentContainer {
  func saveContext()
}

final class PersistentContainerImpl: PersistentContainer {

  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "AppStoreSearch")
    container.loadPersistentStores { (_, error) in
      if let error = error as NSError? {
        // TODO: Logging
        assertionFailure("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()
  
  // MARK: Core Data Save Context
  func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        // TODO: Logging
        let error = error as NSError
        assertionFailure("Unresolved error \(error), \(error.userInfo)")
      }
    }
  }
  
  func perform(_ task: @escaping (NSManagedObjectContext) -> Void) {
    persistentContainer.performBackgroundTask(task)
  }
}
