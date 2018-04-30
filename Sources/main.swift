import Foundation

import Meow

import DataModelsKit

// Configuration
let environment = ProcessInfo.processInfo.environment
let databaseURL = environment["MONGODB_CONNECTION_URI"] ?? "mongodb://evolution:password@localhost:27017/evolution"

// Database
try Meow.init(databaseURL)

// Load fixtures
let fixtures = Fixtures()
try fixtures.start()
