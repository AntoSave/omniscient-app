//
//  PersistanceController.swift
//  smartTrip
//
//  Created by Antonio Langella on 15/02/22.
//
import CoreData
import SwiftUI

struct PersistanceController{
    static let shared = PersistanceController(inMemory: true) //Singleton. Sto costruendo la classe stessa!!!
    //TODO: In fase di produzione togliere inMemory: true
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false){
        container = NSPersistentContainer(name: "Model") //il nome del modello dev'essere lo stesso del file
        if inMemory { //Se inMemory == true, i dati vanno salvati in un file temporaneo
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        //Altrimenti genera lui il nome del file ed esso non sarà volatile
        container.loadPersistentStores(completionHandler: {storeDescription,error in
            if let error = error as NSError?{
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }) //completionHandler viene eseguita dopo il caricamento e gestisce eventuali errori in fase di caricamento
    }
    
    static var preview: PersistanceController = { //Parte extra per gestire le preview.
        let result = PersistanceController(inMemory: true) //Inizializza un contenitore volatile con elementi fittizzi
        let viewContext = result.container.viewContext
        generateDummyContent(context: viewContext)
        do{
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    private static func generateDummyContent(context: NSManagedObjectContext){
        let bedroom = Room(context: context)
        bedroom.name = "Camera da letto"
        let camera = Camera(context: context)
        camera.name = "Telecamera 1"
        camera.domain = "wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mp4"
        camera.port = 554
        camera.username = nil
        camera.password = nil
        camera.composition = bedroom
        let camera2 = Camera(context: context)
        camera2.name = "Telecamera 2"
        camera2.domain = "wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mp4"
        camera2.port = 554
        camera2.username = nil
        camera2.password = nil
        camera2.composition = bedroom
    }
}
