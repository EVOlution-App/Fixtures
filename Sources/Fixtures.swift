import Foundation
import DataModelsKit
import Meow

struct Fixtures {
    private func getApp() throws -> ObjectId? {
        guard let app = try App.findOne() else {
            return nil
        }
        
        return app._id
    }

    private func registerApps() throws -> ObjectId? {
        print("##################################")
        print("[X] Registering apps")
        let app = App()
        app.name = "EVOlution"
        app.key = UUID().uuidString
        app.createdAt = Date()
        app.updatedAt = Date()
        
        do {
            try app.save()
            
            if let name = app.name, let key = app.key {
                print("[Saved] App: \(name) - Key: \(key)")
            }
        }
        catch {
            print("[Error][Not Saved] App: \(app.name ?? "---"))")
            return nil
        }
        
        return app._id
    }
    
    private func existingTags() throws -> Bool {
        let count = try Tag.count()
        guard count > 0 else {
            return false
        }
        
        return true
    }

    private func registerTags(to app: ObjectId) throws {
        typealias TypeTuple = (name: String, type: ActionType)
        let tags: [TypeTuple] = [
            (name: "Proposal creation", type: .proposalCreated),
            (name: "Proposal changed", type: .statusChanged)
        ]
        
        print("##################################")
        print("[X] Registering tags")
        try tags.forEach { value in
            let tag = Tag()
            tag.name = value.name
            tag.identifier = value.type
            tag.app = try Reference(to: app)
            tag.createdAt = Date()
            tag.updatedAt = Date()
            
            do {
                try tag.save()
                
                if let name = tag.name, let identifier = tag.identifier?.rawValue {
                    print("[Saved] Tag: \(name) - Identifier: \(identifier)")
                }
            }
            catch {
                print("[Error][Not Saved] Tag: \(tag.name ?? "---")")
            }
        }
    }

    func start() throws {
        print("Starting to load fixtures to database")

        var value: ObjectId?
        if let objectID = try getApp() {
            print("We found one app existing...")
            value = objectID
        }
        else if let objectID = try registerApps() {
            print("Any app was found... Creating a new one!")
            value = objectID
        }
        
        guard let app = value else {
            return
        }
        
        if try !existingTags() {
            try registerTags(to: app)
        }

        print("Finished load fixtures")
    }
}
