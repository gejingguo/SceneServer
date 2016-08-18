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
    /// 配置错误
    case InfoFileLoadFailed(String)
    case InfoJsonParseFailed(String, String)
}

extension GameError: CustomStringConvertible {
    /// 获取对应的错误码
    public var errCode: Int {
        switch self {
        case .InfoFileLoadFailed(_):
            return 1001
        case .InfoJsonParseFailed(_):
            return 1002
        }
    }
    
    public var description: String {
        switch self {
        case .InfoFileLoadFailed(let path):
            return "err:\(errCode), msg: info file(\(path)) load failed."
        case .InfoJsonParseFailed(let path, let msg):
            return "err:\(errCode), msg: info file(\(path)) json parse failed, \(msg)."
        }
    }
}


