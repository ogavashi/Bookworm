//
//  Rating.swift
//  Bookworm
//
//  Created by Oleg Gavashi on 18.09.2023.
//

import SwiftUI

struct Rating: View {
    @Binding var rating: Int
    
    var label = ""
    var maximumRating = 5
    
    var offImage = Image(systemName: "heart")
    var inImage = Image(systemName: "heart.fill")
    
    var color = Color.red
    
    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            Spacer()
            ForEach(1...maximumRating, id: \.self) { number in
                image(for: number)
                    .foregroundColor(color)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return  offImage
        }
        return inImage
    }
}

struct Rating_Previews: PreviewProvider {
    static var previews: some View {
        Rating(rating: .constant(4))
    }
}
