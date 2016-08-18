//
//  InfoLoader.swift
//  SceneServer
//
//  Created by andyge on 16/8/17.
//
//

import Foundation

/// 策划配置加载管理
public class InfoLoader {
    /// 单例对象
    public static var sharedInstance = InfoLoader()
    
    /// 默认初始化
    public init() {
        
    }
    
    /// 加载所有表格配置
    public func loadAll(path: String) throws {
        try MapInfo.sharedManager.load(jsonPath: path + "/" + "mapinfo.json")
    }
}
