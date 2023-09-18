//
//  BookForm.swift
//  Bookworm
//
//  Created by Oleg Gavashi on 18.09.2023.
//

import Foundation

struct BookForm {
    static let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var title: String = ""
    var author: String = ""
    var rating: Int = 3
    var review: String = ""
    var genre: String = genres[0]
    
    var isFilled: Bool {
        !(title.isEmpty || author.isEmpty || genre.isEmpty)
    }
}
