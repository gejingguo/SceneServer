//
//  ConstValue.swift
//  SceneServer
//
//  Created by andyge on 16/8/20.
//
//

import Foundation

/// 系统常量
public class ConstValue {
    /// 地图格子最大数量
    static let mapGridMaxWidth = 400
    static let mapGridMaxHeight = 400
    /// 格子单位长度
    static let mapGridUnitSize = 0.1
    /// 地图最大宽度
    static var mapMaxWidth: Double {
        return Double(mapGridMaxWidth) * mapGridUnitSize
    }
    /// 地图最大高度
    static var mapMaxHeight: Double {
        return Double(mapGridMaxHeight) * mapGridUnitSize
    }
    
}
