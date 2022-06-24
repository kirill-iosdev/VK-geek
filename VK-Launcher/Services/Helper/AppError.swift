//
//  AppError.swift
//  VK-Launcher
//
//  Created by Kirill on 19.06.2022.
//

import Foundation

enum AppError: Error {
    case noDataProvided
    case failedToDecode
    case errorTask
    case notCorrectUrl
}
