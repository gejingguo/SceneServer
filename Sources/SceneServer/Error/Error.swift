//
//  Error.swift
//  SceneServer
//
//  Created by andyge on 16/8/16.
//
//

import Foundation

/// 错误定义
public enum GameError: ErrorProtocol {
    /// 系统数组越界错误
    case ArrayIndexInvalid(String)
    /// 配置错误
    case InfoLoadFailed(String, String)
    /// 地图配置重复
    case MapConfigError(String)
}

extension GameError: CustomStringConvertible {
    /// 获取对应的错误码
    public var errCode: Int {
        switch self {
        case .ArrayIndexInvalid(_):
            return 1001
        case .InfoLoadFailed(_, _):
            return 1002
        case .MapConfigError(_):
            return 1003
        }
    }
    
    public var description: String {
        switch self {
        case .ArrayIndexInvalid(let msg):
            return "err:\(errCode), msg:\(msg)"
        case .MapConfigError(let msg):
            return "err:\(errCode), msg:\(msg)"
        case .InfoLoadFailed(let path, let msg):
            return "err:\(errCode), msg: info file(\(path)) load failed, \(msg)"
        }
    }
}
