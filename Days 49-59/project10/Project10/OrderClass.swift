//
//  OrderModel.swift
//  Project10
//
//  Created by User on 2021-10-31.
//  Copyright © 2021 Paul Hudson. All rights reserved.
//

import Foundation

class OrderClass: ObservableObject, Codable {
    @Published var order = Order()

    enum CodingKeys: CodingKey {
        case order
    }


        init() { }

        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            order = try container.decode(Order.self, forKey: .order)
        }


        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            try container.encode(order, forKey: .order)
        }
}
