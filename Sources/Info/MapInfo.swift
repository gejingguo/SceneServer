//
//  SceneInfo.swift
//  SceneServer
//
//  Created by andyge on 16/8/16.
//
//

import Foundation
import SwiftyJSON

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
    /// 
    public var description: String = ""
    
    public init() {
        
    }
    
    public var infoKey: InfoKey {
        return InfoKey(id1: infoId, id2: 0, id3: 0)
    }
    
    /// 加载配置
    public func load(json: JSON) throws {
        self.infoId = json["infoId"].intValue
        self.isStatic = json["isStatic"].boolValue
        self.width = json["width"].doubleValue
        self.height = json["height"].doubleValue
        self.description = json.description
    }
    
    /// 分配实例
    public static func alloc() throws -> InfoProtocol {
        return MapInfo()
    }
    
    /// 单例
    public static var sharedManager = InfoManager<MapInfo>()
}
