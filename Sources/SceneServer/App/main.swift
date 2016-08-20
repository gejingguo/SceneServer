import Foundation
//import Info
//import Error


//print("Hello, world!")

/*
let subject = "{\"title\" : \" hello world!!\" }"
do {
    guard let data = subject.data(using: .utf8) else  {
        print("Unable to convert string to data")
        exit(1)
    }
    let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
    //XCTAssertEqual(result?["title"] as? String, " hello world!!")
    print(result)
} catch{
    print("Error thrown: \(error)")
}

let str = "{ \"name\": \"100\", }"
let json = try JSONSerialization.jsonObject(with: str.data(using: .utf8)!, options: [])
print(json.dynamicType)
let dic = json as! [String : AnyObject]
print(dic)
*/
let rootPath = "/Users/andyge/project/SceneServer"
do {
    try InfoLoader.sharedInstance.loadAll(path: rootPath + "/Publish/Info")
    try MapBlockManager.sharedInstance.loadAll(path: rootPath + "/Publish/MapBlock")
    
} catch {
    //if let err = error as? GameError {
    //    print(err)
    //}
    print(error)
    exit(-1)
}

if let info = MapInfo.sharedManager.get(infoId: 1001) {
    print(info)
}

if let block = MapBlockManager.sharedInstance.getMapBlock(map: 1001) {
    print("(12, 34) moveable:", try block.isMoveable(x: 12, y: 23))
    print("(15, 46) moveable:", try block.isMoveable(x: 15, y: 46))
    print("(45, 23) moveable:", try block.isMoveable(x: 45, y: 23))
    print("(18, 34) moveable:", try block.isMoveable(x: 18, y: 34))
}


