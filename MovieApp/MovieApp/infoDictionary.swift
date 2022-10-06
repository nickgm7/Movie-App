//
//  infoDictionary.swift
//  MovieApp
//
//  Created by Nick Meyer on 2/14/22.
//

import Foundation
class infoDictionary
{
    var infoRepository : [String:movieRecord] = [String:movieRecord] ()
    var movArray = [String]()
    init() { }
    
    //updates the movie array for the next and prev functionality
    func edit(_ title:String, _ tickets:Int){
        var index:Int = 0
        for i in movArray{
            print(i)
            if (i.contains(title))
            {
                print("match")
                let ticketChange = i.lastIndex(of: ":") ?? i.endIndex
                let newElement = i[...ticketChange] + " " + String(tickets)
                movArray[index] = String(newElement)
                print(newElement)
            }
            index += 1
        }
    }
    
    //return nil if no prev and prev element if prev
    func getPrev(_ element:String) -> String?
    {
        print("gettingPrev")
        var prev:String? = nil
        var index:Int = 0
        //find element and check if there is an element before
        for i in movArray{
            if (i.contains(element))
            {
                if(index - 1 >= 0)
                {
                    prev = movArray[index-1]
                }
            }
            index += 1
        }
        return prev
    }
    //return nil if no next and next element if next
    func getNext(_ element:String) -> String?
    {
        print("gettingNext")
        var nex:String? = nil
        var index:Int = 0
        //find element and check if there is an element after
        for i in movArray{
            if (i.contains(element))
            {
                if(index + 1 < movArray.endIndex)
                {
                    nex = movArray[index+1]
                }
            }
            index += 1
        }
        return nex
    }
    //return the latest addition to the array
    func getLatest() -> String
    {
        if(movArray.endIndex > 0)
        {
            return movArray[movArray.endIndex - 1]
        }
        else{
            return ""
        }
        
    }
    
    func add(_ title:String, _ genre:String, _ tickets:Int16)
    {
        //add item to dictionary
        let mRecord =  movieRecord(t: title, g:genre, ts: tickets)
        infoRepository[mRecord.title!] = mRecord
        //add dictionary item to movArray
        movArray.append("Title: \(title)    Genre: \(genre)     Tickets: \(tickets)")
        //print array
        for i in movArray
        {
            print(i)
        }
        print("*********")
        
    }
    
    func search(t:String) -> movieRecord?
    {
        var found = false
        
        for (title, _) in infoRepository
        {
            if title == t
            {
                found = true
                    break
            }
        }
        if found
        {
           return infoRepository[t]
        }
        else
        {
            return nil
        }
    }
    
    func deleteRec(t:String)
    {
        infoRepository[t] = nil
        var c:Int = 0
        for i in movArray{
            if(i.contains(t))
            {
                movArray.remove(at:c)
            }
            c += 1
        }
    }
}
