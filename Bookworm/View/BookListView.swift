//
//  BookView.swift
//  Bookworm
//
//  Created by Oleg Gavashi on 18.09.2023.
//

import SwiftUI

struct BookListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book>
    
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        BookView(book: book)
                    } label: {
                        HStack {
                            EmojiRating(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown")
                                    .font(.headline)
                                    .foregroundColor(book.rating == 1 ? Color.red : Color.primary)
                                
                                Text(book.author ?? "Unknown")
                                    .foregroundColor(.secondary)
                            }
                           
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    EditButton()
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        showSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                BookFormView()
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save()
    }
}


struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}
