//
//  MapBlock.swift
//  SceneServer
//
//  Created by andyge on 16/8/19.
//
//

import Foundation

/// 地图阻挡配置
/// 地图不可走坐标列表
public class MapBlock: CustomStringConvertible {
    /// 地图编号
    public private(set) var mapId = 0
    /// 地图宽度
    public private(set) var width = 0
    /// 地图高度
    public private(set) var height = 0
    /// 阻挡标记数组
    private var blocks = [Bool]()
    
    public init() {
        //self.blocks = Array(repeating: <#T##Element#>, count: <#T##Int#>)
    }
    
    /// 获取索引
    private func index(x: Int, y: Int) throws -> Int{
        let index = y * width + x
        if index < 0 || index >= self.blocks.count {
            throw GameError.ArrayIndexInvalid("mapblock(\(self.mapId), \(width), \(height)) set (\(x),\(y)) failed.")
        }
        return index
    }
    
    /// 设置阻挡标记
    public func set(x: Int, y: Int) throws {
        let index = try self.index(x: x, y: y)
        //print("block set:",index, x, y)
        self.blocks[index] = true
    }
    
    /// 检查坐标是否可走
    public func isMoveable(x: Int, y: Int) throws -> Bool {
        let index = try self.index(x: x, y: y)
        //print("block moveable:",index, x, y)
        return !self.blocks[index]
    }
    
    /// 描述
    public var description: String {
        return "mapblock(\(mapId), \(width), \(height)"
    }
    
    /// 加载配置
    public func load(path: String) throws {
        print("mapblock load path:", path)
        guard let fh = FileHandle(forReadingAtPath: path) else {
            throw GameError.MapConfigError("map conf(\(path)) open file failed.")
        }
        //let fjson = JSON(data: fh.availableData, options: [])
        guard let json = try JSONSerialization.jsonObject(with: fh.availableData, options: []) as? [String: AnyObject] else {
            throw GameError.MapConfigError("map conf(\(path)) file parse failed.")
        }
        guard let mapId = json["mapId"] as? Int else {
            throw GameError.MapConfigError("map conf(\(path)) mapId node not found.")
        }
        guard let width = json["width"] as? Int else {
            throw GameError.MapConfigError("map conf(\(path)) width node not found.")
        }
        guard let height = json["height"] as? Int else {
            throw GameError.MapConfigError("map conf(\(path)) height node not found.")
        }
        guard let blocks = json["blocks"] as? [AnyObject] else {
            throw GameError.MapConfigError("map conf(\(path)) blocks node not found.")
        }
        if mapId <= 0 {
            throw GameError.MapConfigError("map conf(\(path)) mapId(\(mapId)) invalid.")
        }
        if width <= 0 || width > ConstValue.mapGridMaxWidth {
            throw GameError.MapConfigError("map conf(\(path)) mapId(\(width)) invalid.")
        }
        if height <= 0 || height > ConstValue.mapGridMaxHeight {
            throw GameError.MapConfigError("map conf(\(path)) mapId(\(height)) invalid.")
        }
        self.mapId = mapId
        self.width = width
        self.height = height
        self.blocks.append(contentsOf: [Bool](repeating: false, count: self.width*self.height))
        for block in blocks {
            guard let pos = block as? [String: AnyObject] else {
                throw GameError.MapConfigError("map conf(\(path)) block pos(\(block)) format invalid.")
            }
            let x = pos["x"] as? Int ?? 0
            let y = pos["y"] as? Int ?? 0
            try self.set(x: x, y: y)
        }
    }
}
