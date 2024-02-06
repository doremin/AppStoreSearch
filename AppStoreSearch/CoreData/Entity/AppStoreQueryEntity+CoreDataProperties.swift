//
//  AppStoreQueryEntity+CoreDataProperties.swift
//  AppStoreSearch
//
//  Created by doremin on 2/5/24.
//
//

import Foundation
import CoreData


extension AppStoreQueryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppStoreQueryEntity> {
        return NSFetchRequest<AppStoreQueryEntity>(entityName: "AppStoreQueryEntity")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var query: String?

}

extension AppStoreQueryEntity : Identifiable {

}

extension AppStoreQueryEntity {
  
  var domain: SearchHistory {
    return .init(query: query ?? "")
  }
  
  convenience init(history: SearchHistory, insertInto context: NSManagedObjectContext) {
    self.init(context: context)
    query = history.query
    createdAt = Date()
  }
  
}
