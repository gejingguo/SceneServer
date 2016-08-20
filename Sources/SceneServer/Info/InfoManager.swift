//
//  InfoManager.swift
//  SceneServer
//
//  Created by andyge on 16/8/16.
//
//

import Foundation

/// 配置Key
public struct InfoKey {
    public var id1 = 0
    public var id2 = 0
    public var id3 = 0
}

/// 配置协议
public protocol InfoProtocol {
    /// KEY字段
    var infoKey: InfoKey { get }
    /// 加载数据
    func load(fields: [String: AnyObject]) throws
    /// 分配对象
    static func alloc() throws -> InfoProtocol
}

/// 配置管理器
public class InfoManager<T: InfoProtocol> {
    /// 配置字典
    private var infoDic = [InfoKey: T]()
    
    /// 单例实例对象
    //public static var sharedInstance = InfoManager<T>()
    
    /// 构造
    public init() {
    }
    
    /// 获取配置
    public func get(infoId: Int) -> T? {
        let key = InfoKey(id1: infoId, id2: 0, id3: 0)
        return self.infoDic[key]
    }
    
    public func get(key1: Int, key2: Int) -> T? {
        let key = InfoKey(id1: key1, id2: key2, id3: 0)
        return self.infoDic[key]
    }
    
    public func get(key1: Int, key2: Int, key3: Int) -> T? {
        let key = InfoKey(id1: key1, id2: key2, id3: key3)
        return self.infoDic[key]
    }
    
    /// 加载数据
    public func load(jsonPath: String) throws {
        guard let fh = FileHandle(forReadingAtPath: jsonPath) else {
            throw GameError.InfoLoadFailed(jsonPath, "open file failed.")
        }
        //let fjson = JSON(data: fh.availableData, options: [])
        //print(String(bytes: fh.availableData, encoding: String.Encoding.utf8))
        guard let fjson = try JSONSerialization.jsonObject(with: fh.availableData, options: []) as? [String: AnyObject] else {
            throw GameError.InfoLoadFailed(jsonPath, "file parse failed.")
        }
        guard let rows = fjson["rows"] as? [AnyObject] else {
            throw GameError.InfoLoadFailed(jsonPath, "rows array node null")
        }
        var rowCount = 0
        for row in rows {
            rowCount += 1
            guard let fields = row as? [String: AnyObject] else {
                throw GameError.InfoLoadFailed(jsonPath, "row:\(rowCount) parse failed.")
            }
            
            let info = try T.alloc()
            try info.load(fields: fields)
            if self.infoDic[info.infoKey] != nil {
                throw GameError.InfoLoadFailed(jsonPath, "row:\(rowCount) info key has existed.")
            }
            self.infoDic[info.infoKey] = info as? T
        }
    }
}

extension InfoKey: Hashable {
    /// Hashable协议实现
    public var hashValue: Int {
        get {
            if id2 == 0 && id3 == 0 {
                return id1;
            }
            else if id3 == 0 {
                return "\(self.id1),\(self.id2)".hashValue
            }
            else {
                return "\(self.id1),\(self.id2),\(self.id3)".hashValue
            }
        }
    }
}

public func ==(left: InfoKey, right: InfoKey) -> Bool {
    return left.id1 == right.id1 && left.id2 == right.id2 && left.id3 == right.id3
}
