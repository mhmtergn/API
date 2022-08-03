//
//  Petition.swift
//  RestfulAPI
//
//  Created by Mehmet Ergün on 2022-08-03.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
    var url: String
}
