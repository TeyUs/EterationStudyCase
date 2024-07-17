//
//  Products.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 13.07.2024.
//

import Foundation

// MARK: - Product
struct Product: Codable, Hashable {
    let createdAt: String?
    let name: String?
    let image: String?
    let price: String?
    let description: String?
    let model: String?
    let brand: String?
    let id: String?
    var numberOfCart: Int? = 0
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}

typealias Products = [Product]


var demoProducts: Products = [
    .init(createdAt: "2023-07-17T07:21:02.529Z", name: "Bentley Focus 111111", image: "https://loremflickr.com/640/480/food", price: "51.00", description: "Quasi adipisci sint veniam delectus. Illum laboriosam minima dignissimos natus earum facere consequuntur eius vero. Itaque facilis at tempore ipsa. Accusamus nihil fugit velit possimus expedita error porro aliquid. Optio magni mollitia veritatis repudiandae tenetur nemo. Id consectetur fuga ipsam quidem voluptatibus sed magni dolore.\nFacilis commodi dolores sapiente delectus nihil ex a perferendis. Totam deserunt assumenda inventore. Incidunt nesciunt adipisci natus porro deleniti nisi incidunt laudantium soluta. Nostrum optio ab facilis quisquam.\nSoluta laudantium ipsa ut accusantium possimus rem. Illo voluptatibus culpa incidunt repudiandae placeat animi. Delectus id in animi incidunt autem. Ipsum provident beatae nisi cumque nulla iure.", model: "CTS", brand: "Lamborghini", id: "1", numberOfCart: 0),
    .init(createdAt: "2023-07-17T07:21:02.529Z", name: "Bentley Focus 222222", image: "https://loremflickr.com/640/480/food", price: "51.00", description: "Quasi adipisci sint veniam delectus. Illum laboriosam minima dignissimos natus earum facere consequuntur eius vero. Itaque facilis at tempore ipsa. Accusamus nihil fugit velit possimus expedita error porro aliquid. Optio magni mollitia veritatis repudiandae tenetur nemo. Id consectetur fuga ipsam quidem voluptatibus sed magni dolore.\nFacilis commodi dolores sapiente delectus nihil ex a perferendis. Totam deserunt assumenda inventore. Incidunt nesciunt adipisci natus porro deleniti nisi incidunt laudantium soluta. Nostrum optio ab facilis quisquam.\nSoluta laudantium ipsa ut accusantium possimus rem. Illo voluptatibus culpa incidunt repudiandae placeat animi. Delectus id in animi incidunt autem. Ipsum provident beatae nisi cumque nulla iure.", model: "CTS", brand: "Lamborghini", id: "1", numberOfCart: 2),
    .init(createdAt: "2023-07-17T07:21:02.529Z", name: "Bentley Focus 33333", image: "https://loremflickr.com/640/480/food", price: "51.00", description: "Quasi adipisci sint veniam delectus. Illum laboriosam minima dignissimos natus earum facere consequuntur eius vero. Itaque facilis at tempore ipsa. Accusamus nihil fugit velit possimus expedita error porro aliquid. Optio magni mollitia veritatis repudiandae tenetur nemo. Id consectetur fuga ipsam quidem voluptatibus sed magni dolore.\nFacilis commodi dolores sapiente delectus nihil ex a perferendis. Totam deserunt assumenda inventore. Incidunt nesciunt adipisci natus porro deleniti nisi incidunt laudantium soluta. Nostrum optio ab facilis quisquam.\nSoluta laudantium ipsa ut accusantium possimus rem. Illo voluptatibus culpa incidunt repudiandae placeat animi. Delectus id in animi incidunt autem. Ipsum provident beatae nisi cumque nulla iure.", model: "CTS", brand: "Lamborghini", id: "1", numberOfCart: 0)
]
