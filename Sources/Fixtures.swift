import Foundation
import DataModelsKit

struct Fixtures {
    private func registerApps() throws {
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
        }
    }
    
    private func registerTags() {
        typealias TypeTuple = (name: String, type: ActionType)
        let tags: [TypeTuple] = [
            (name: "Proposal creation", type: .proposalCreated),
            (name: "Proposal dhanged", type: .statusChanged)
        ]
        
        print("##################################")
        print("[X] Registering tags")
        tags.forEach { value in
            let tag = Tag()
            tag.name = value.name
            tag.identifier = value.type
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
        
        try registerApps()
        registerTags()
        
        print("Finished load fixtures")
    }
}
