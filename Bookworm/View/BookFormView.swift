//
//  BookFormView.swift
//  Bookworm
//
//  Created by Oleg Gavashi on 18.09.2023.
//

import SwiftUI

struct BookFormView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var book = BookForm()
    
    var body: some View {
        NavigationView {
            Form {
                Section("Book info") {
                    TextField("Book title", text: $book.title)
                    TextField("Book author", text: $book.author)
                    
                    Picker("Genre", selection: $book.genre) {
                        ForEach(BookForm.genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Book review") {
                    TextEditor(text: $book.review)
                    Rating(rating: $book.rating, label: "Rate a book")
                }
            }
            .navigationTitle("Add book")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        saveBook()
                    } label: {
                        Text("Confrom")
                    }
                    .disabled(!book.isFilled)
                }
            }
        }
    }
    
    func saveBook() {
        let formBook = Book(context: moc)
        formBook.author = book.author
        formBook.genre = book.genre
        formBook.rating = Int16(book.rating)
        formBook.review = book.review
        formBook.title = book.title
        formBook.id = UUID()
            
        try? moc.save()
        dismiss()
    }
}

struct BookFormView_Previews: PreviewProvider {
    static var previews: some View {
        BookFormView()
    }
}
