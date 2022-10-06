//
//  movieRecord.swift
//  MovieApp
//
//  Created by Nick Meyer on 2/14/22.
//

import Foundation
class movieRecord
{
    var title:String? = nil
    var genre:String? = nil
    var tickets:Int16? = nil
    
    init(t:String, g:String, ts:Int16) {
        self.title = t
        self.genre = g
        self.tickets = ts
    }
    
    func change_tickets(newTotal:Int16)
    {
        self.tickets = newTotal;
    }
    
}
