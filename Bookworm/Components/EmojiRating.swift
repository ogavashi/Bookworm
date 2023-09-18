//
//  EmojiRating.swift
//  Bookworm
//
//  Created by Oleg Gavashi on 18.09.2023.
//

import SwiftUI

struct EmojiRating: View {
    let rating: Int16
    
    var body: some View {
        switch rating {
        case 1:
            return Text("🙈")
        case 2:
            return Text("😔")
        case 3:
            return Text("🙂")
        case 4:
            return Text("😊")
        default:
            return Text("🤩")
        }
    }
}

struct EmojiRating_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRating(rating: 4)
    }
}
