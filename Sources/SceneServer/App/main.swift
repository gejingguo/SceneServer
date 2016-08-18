import Foundation
//import Info
//import Error

print("Hello, world!")

do {
    try InfoLoader.sharedInstance.loadAll(path: "./Publish/Info")
} catch {
    if let err = error as? GameError {
        print(err)
    }
    exit(-1)
}

if let info = MapInfo.sharedManager.get(infoId: 1001) {
    print(info)
}



