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
    
    //İçerideki favorileri silmek için.
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
    
    
    //Yazılan notları kaydetmek için kullanacağız.
    func saveNote(text: String, gameName: String, noteDate: String) -> Notes? {
        //CoreDatadaki note'a erişiyorum.
        print("save note'a girdi")
        let entity = NSEntityDescription.entity(forEntityName: "Notes", in: managedContext)!
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        //Entityden olan bir obje oluşturuyorum ve buna text'i setliyorum.
        print(text)
        note.setValue(text, forKey: "noteText")
        note.setValue(gameName, forKey: "gameName")
        note.setValue(noteDate, forKey: "NoteDate")
        do {
            print("kaydetti")
            try managedContext.save()
            return note as? Notes
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    //İçerideki note arrayini alabilmek için fonksiyon yazdım.
    func getNotes() -> [Notes] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Notes")
        do {
            let notes = try managedContext.fetch(fetchRequest)
            return notes as! [Notes]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    //İçerideki notlardan update etmek için.
    func updateNote(previousText: String, currentText: String, noteDate: String) -> Bool {
        print("coredata update note")
        print(previousText)
        print(currentText)
        var success = true
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Notes")
        fetchRequest.predicate = NSPredicate(format: "noteText = %@", previousText) //Requestte gelen önceki text'e göre cora datada arama yapıyorum.
        do {
            let test = try managedContext.fetch(fetchRequest)
            if test.count >= 1 {
                let objectUpdate = test[0] as! NSManagedObject
                print(currentText)
                objectUpdate.setValue(currentText, forKey: "noteText") //Yeni gelen texte göre update işlemini yapıyorum.
                objectUpdate.setValue(noteDate, forKey: "noteDate")
                try managedContext.save() // look in AppDelegate.swift for this function
                success = true
            }
        } catch {
            print(error)
        }
        return success
    }
    
    //İçerideki notlardan silmek için.
    func deleteNote(note: Notes) {
        managedContext.delete(note)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}



