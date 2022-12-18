//
//  CoreDataManager.swift
//  RAWGVideoGames
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

import CoreData
import UIKit

final class CoreDataManager {
    static let shared = CoreDataManager()
    private let managedContext: NSManagedObjectContext!
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    //Favorileri kaydetmek için kullanacağız.
    func saveFavorite(favoriteGameName: String, gameId: Int) -> Games? {
        //CoreDatadaki note'a erişiyorum.
        let entity = NSEntityDescription.entity(forEntityName: "Games", in: managedContext)!
        let favoriteGame = NSManagedObject(entity: entity, insertInto: managedContext)
        //Entityden olan bir obje oluşturuyorum ve buna text'i setliyorum.
        favoriteGame.setValue(favoriteGameName, forKey: "gameName")
        favoriteGame.setValue(gameId, forKey: "gameId")
        do {
            try managedContext.save()
            return favoriteGame as? Games
        } catch let error as NSError {
            print("Could not game. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    //İçerideki tüm favori arrayini alabilmek için fonksiyon yazdım.
    func getFavorites() -> [Games] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Games")
        do {
            let games = try managedContext.fetch(fetchRequest)
            return games as! [Games]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    //İçerideki gönderilen id'ye ait arrayini alabilmek için fonksiyon yazdım.
    func getSelectedFavorite(id: Int) -> Bool {
        let fetchRequest: NSFetchRequest<Games> = Games.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "gameId = %@", String(id))
        let results = try? managedContext.fetch(fetchRequest)
        return results?.count != 0
    }
    
    //İçerideki notlardan silmek için.
    func deleteFavorite(gameId: Int) {
        let fetchRequest: NSFetchRequest<Games> = Games.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "gameId = %@ ", String(gameId))
        if let favorite = try? managedContext.fetch(fetchRequest).first {
            managedContext.delete(favorite)
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
}



