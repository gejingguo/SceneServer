//
//  SceneInfo.swift
//  SceneServer
//
//  Created by andyge on 16/8/16.
//
//

import Foundation

/// 地图配置
public class MapInfo: InfoProtocol, CustomStringConvertible {
    ///
    public var infoId: Int = 0
    /// 是否是静态大地图（非副本地图)
    public var isStatic: Bool = true
    /// 地图宽度
    public var width: Double = 0
    /// 地图高度
    public var height: Double = 0

    
    public init() {
        
    }
    
    public var infoKey: InfoKey {
        return InfoKey(id1: infoId, id2: 0, id3: 0)
    }
    
    /// 加载配置
    public func load(fields: [String: AnyObject]) throws {
        self.infoId = fields["infoId"] as? Int ?? 0
        self.isStatic = fields["isStatic"] as? Bool ?? false
        self.width = fields["width"] as? Double ?? 0
        self.height = fields["height"] as? Double ?? 0
        //self.description = fields.description
    }
    
    ///
    public var description: String {
        return "MapInfo(infoId:\(infoId), satic:\(isStatic), width:\(width), height:\(height))"
    }
    
    /// 分配实例
    public static func alloc() throws -> InfoProtocol {
        return MapInfo()
    }
    
    /// 单例
    public static var sharedManager = InfoManager<MapInfo>()
}
