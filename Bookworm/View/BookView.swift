//
//  BookView.swift
//  Bookworm
//
//  Created by Oleg Gavashi on 18.09.2023.
//

import SwiftUI

struct BookView: View {
    let book: Book
    
    @State private var showAlert = false
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x:-5, y: -5)
            }
            VStack(alignment: .leading) {
                Text(book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                if let review = book.review {
                    VStack(alignment: .leading) {
                        Text("Review:")
                            .font(.title)
                            .padding(.bottom, 1)
                        
                        Text(review)
                        
                    }
                    .padding(.vertical)
                }
                Divider()
                    .padding()
                
                Rating(rating: .constant(Int(book.rating)), label: "Rating:")
            }
            .padding(.horizontal)
        }
        .navigationTitle(book.title ?? "Unknown book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book?", isPresented: $showAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    showAlert.toggle()
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(Color.red)
                }
            }
        }
    }
    
    func deleteBook() {
        moc.delete(book)
        
        //        try? moc.save()
        dismiss()
    }
}
