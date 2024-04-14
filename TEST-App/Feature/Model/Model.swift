//
//  Model.swift
//  TEST-App
//
//  Created by pnkbksh on 14/04/24.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct CoveragesMediaModel: Codable {
    let id, title: String?
    let language: Language?
    let thumbnail: Thumbnail?
    let mediaType: Int?
    let coverageURL: String?
    let publishedAt, publishedBy: String?
    let backupDetails: BackupDetails?
}

struct BackupDetails: Codable {
    let pdfLink: String?
    let screenshotURL: String?
}

enum Language: String, Codable {
    case english = "english"
    case hindi = "hindi"
}

struct Thumbnail: Codable {
    let id: String?
    let version: Int?
    let domain: String?
    let basePath: String?
    let key: String?
    let qualities: [Int]?
    let aspectRatio: Double?
}

