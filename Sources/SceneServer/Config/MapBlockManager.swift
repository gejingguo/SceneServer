//
//  MapBlockManager.swift
//  SceneServer
//
//  Created by andyge on 16/8/19.
//
//

import Foundation

/// 地图阻挡配置管理
public class MapBlockManager {
    /// 阻挡列表
    private var mapBlockDic = [Int: MapBlock]()
    
    /// 单例
    public static var sharedInstance = MapBlockManager()
    
    /// 初始化
    private init() {
        
    }
    
    /// 添加配置
    public func add(block: MapBlock) throws {
        if self.mapBlockDic[block.mapId] != nil {
            throw GameError.MapConfigError("mapblock map:\(block.mapId) has existed.")
        }
        self.mapBlockDic[block.mapId] = block
    }
    
    /// 获取配置
    public func getMapBlock(map: Int) -> MapBlock? {
        return self.mapBlockDic[map]
    }
    
    /// 加载目录中所有地图阻挡配置
    public func loadAll(path: String) throws {
        let files = try FileManager.default().contentsOfDirectory(atPath: path)
        for file in files {
            if file.hasSuffix(".json") {
                print("load mapblock \(file)")
                let block = MapBlock()
                try block.load(path: path + "/" + file)
                print("load mapblock ok.")
                try self.add(block: block)
            }
        }
    }
}
