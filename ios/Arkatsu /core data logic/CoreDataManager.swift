//
//  CoreDataManager.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 25.02.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import CoreData
import Foundation

struct CoreDataManager {

  static let shared = CoreDataManager()


  let persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "ArkatsuDataModel")
    container.loadPersistentStores(completionHandler: { (storDescription, err) in
      if let err = err {
        fatalError("Error: \(err)")
      }
    })
    return container
  }()


  func isAchievementDone(withName name: String) -> Bool {
    let achievements = getAllAchievements()
    for achievement in achievements {
      if achievement.name == name {
        return achievement.isDone
      }
    }

    return false
  }


  func toggleAchievement(withName name: String) {
    let context = CoreDataManager.shared.persistentContainer.viewContext
    let achievements = getAllAchievements()
    for achievement in achievements {
      if achievement.name == name {
        achievement.isDone = !achievement.isDone

        do {
            try context.save()
        } catch let err {
            return
        }

        return
      }
    }

    createAchievement(withName: name)
  }


  func createAchievement(withName name: String) {
    let context = CoreDataManager.shared.persistentContainer.viewContext
    let entity = NSEntityDescription.insertNewObject(forEntityName: "Achievement", into: context)

    entity.setValue(false, forKey: "isDone")
    entity.setValue(name, forKey: "name")

    do {
        try context.save()
    } catch let err {
        print(err)
    }
  }


  private func getAllAchievements() -> [Achievement] {

    let context = persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<Achievement>(entityName: "Achievement")
    do {
      let result = try context.fetch(fetchRequest)
      return result
    } catch let err {
      return []
    }

  }
}
