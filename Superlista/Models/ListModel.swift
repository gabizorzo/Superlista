//
//  ListModel.swift
//  Superlista
//
//  Created by Thaís Fernandes on 10/05/21.
//

import Foundation

struct ListModel: Identifiable, Decodable, Encodable {
    let id: String
    let title: String
    let items: [String: [ItemModel]]
    let favorite: Bool
    
    init(id: String = UUID().uuidString, title: String, items: [String: [ItemModel]] = [:], favorite: Bool = false) {
        
        self.id = id
        self.title = title
        self.items = items
        self.favorite = favorite
    }
    
    func toggleFavorite() -> ListModel {
        return ListModel(id: id, title: title, items: items, favorite: !favorite)
    }
    
    func editTitle(newTitle: String) -> ListModel {
        return ListModel(id: id, title: newTitle, items: items, favorite: favorite)
    }
    
    func addItem(_ product: ProductModel) -> ListModel {
        var newItemsList = items
        
        if let _ = items[product.category] {
            newItemsList[product.category]?.append(ItemModel(product: product))
        } else {
            newItemsList[product.category] = [ItemModel(product: product)]
        }
        
        return ListModel(id: id, title: title, items: newItemsList, favorite: favorite)
    }
    
    func removeItem(from row: IndexSet, of category: String) -> ListModel {
        var newItemsList = items
        
        newItemsList[category]?.remove(atOffsets: row)
        
        if let rowList = newItemsList[category] {
            
            if rowList.isEmpty {
                newItemsList.removeValue(forKey: category)
            }
            
        }
        
        return ListModel(id: id, title: title, items: newItemsList, favorite: favorite)
    }
    
    func addComment(_ comment: String, to item: ItemModel) -> ListModel {
        
        var newItemsList = items
        
        if let rows = items[item.product.category],
           let index = rows.firstIndex(where: { $0.id == item.id }) {
            
            newItemsList[item.product.category]?[index] = item.editComment(newComment: comment)
        }
        
        return ListModel(id: id, title: title, items: newItemsList, favorite: favorite)
    }
    
    func toggleCompletion(of item: ItemModel) -> ListModel {
        
        var newItemsList = items
        
        if let rows = items[item.product.category],
           let index = rows.firstIndex(where: { $0.id == item.id }) {
            
            newItemsList[item.product.category]?[index] = item.toggleCompletion()
        }
        
        return ListModel(id: id, title: title, items: newItemsList, favorite: favorite)
    }
}
