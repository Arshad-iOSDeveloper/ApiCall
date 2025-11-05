//
//  Post.swift
//  ApiCall
//
//  Created by Arshad Shaik on 29/10/25.
//

import Foundation

// Model to send and receive data
struct Post: Codable {
    let title: String
    let titleDescription: String
    let userId: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case titleDescription = "body"
        case userId
    }
}
