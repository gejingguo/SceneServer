//
//  Scene.swift
//  SwiftRPG
//
//  Created by andyge on 16/6/26.
//
//

import Foundation
import Util
import Info

/// 弱引用，不托管生命周期
struct ObjectEntry {
    weak var object: GameObject? = nil
}

/// 场景类
public class Scene {
    /// 唯一实例ID
    public var uid: UInt32 = 0
    /// 配置Info
    public weak var info: MapInfo?
    /// 地图宽度
    public var width = 0.0
    /// 地图高度
    public var height = 0.0
    /// 地图场景中所有物件列表
    var objectDic = [UInt64: ObjectEntry]()
    
    /// 初始化
    public required init(info: MapInfo) {
        self.uid = 0
        self.info = info
        self.width = info.width
        self.height = info.height
    }
    
    /// 
    deinit {
    }
}


/// 场景基本物件管理
extension Scene {
    /// 增加场景物件
    public func add(object: GameObject) throws {
        self.objectDic[object.uid] = ObjectEntry(object: object)
        object.scene = self
    }
    
    /// 删除场景物件
    public func remove(object: GameObject) throws {
        self.objectDic.removeValue(forKey: object.uid)
        object.scene = nil
    }
    
    /// 删除场景物件
    public func remove(uid: UInt64) throws {
        //self.objectDic.removeValue(forKey: uid)
        if let object = self.getGameObject(uid: uid) {
            try self.remove(object: object)
        }
    }
    
    /// 获取场景物件
    public func getGameObject(uid: UInt64) -> GameObject? {
        return self.objectDic[uid]?.object
    }
    
    /// 物件坐标更新后要调用该方法，更改物件所在屏
    public func onGameObjectPosChanged(object: GameObject, oldPos: Vector2D) throws {
    
    }
    
    /// 帧更新
    public func update(date: Date) throws {
    
    }
    
}

