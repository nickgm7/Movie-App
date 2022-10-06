//
//  ViewController.swift
//  MovieApp
//
//  Created by Nick Meyer on 2/14/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var genreInput: UITextField!
    @IBOutlet weak var ticketsInput: UITextField!
    
    @IBOutlet weak var searchedTitle: UITextField!
    @IBOutlet weak var searchedGenre: UITextField!
    @IBOutlet weak var searchedTickets: UITextField!
    
    @IBOutlet weak var iteratorOutput: UILabel!
    @IBOutlet weak var iteratorMessage: UILabel!
    
    
    @IBOutlet weak var searchMessage: UILabel!
    
    @IBOutlet weak var addMessage: UILabel!
    
    // create an infoDictionary object that stores the movie info
    var movieInfoDictionary:infoDictionary = infoDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    @IBAction func addMov(_ sender: UIBarButtonItem) {
        self.searchMessage.text = ""
        self.iteratorMessage.text = ""
        for i in self.movieInfoDictionary.movArray{
            if(i.contains("Title: \(titleInput.text!)"))
            {
                self.addMessage.text = "Movie already in favorites"
                // remove data from the text fields
                self.titleInput.text = ""
                self.genreInput.text = ""
                self.ticketsInput.text = ""
                return
            }
        }
        // check if input fields are empty
        if let  title = titleInput.text,
            let genre = genreInput.text,
            let tickets = Int16(ticketsInput.text!)
        {
            self.addMessage.text = ""
            movieInfoDictionary.add(title, genre, tickets)
            // remove data from the text fields
            self.titleInput.text = ""
            self.genreInput.text = ""
            self.ticketsInput.text = ""
            
            //update interator output
            self.iteratorOutput.text = self.movieInfoDictionary.getLatest()
        }
        else
        {
           // Alert if no input
           let alert = UIAlertController(title: "Data Input Error", message: "Data Inputs are either empty or incorrect types", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }
    }
    
    @IBAction func remove(_ sender: UIBarButtonItem) {// show the alert controller with data input text field
        self.addMessage.text = ""
        self.searchMessage.text = ""
        let alertController = UIAlertController(title: "Delete Record", message: "", preferredStyle: .alert)
        let searchAction = UIAlertAction(title: "Delete", style: .default) { (aciton) in
        let text = alertController.textFields!.first!.text!
        
        if (!text.isEmpty)
        {
            let title = text
            self.movieInfoDictionary.deleteRec(t: title)
            //update interator output
            self.iteratorOutput.text = self.movieInfoDictionary.getLatest()
            self.iteratorMessage.text = ""
         }
         else
         {
           // Alert if no input
           let alert = UIAlertController(title: "Data Input Error", message: "enter movie title to search", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        alertController.addTextField { (textField) in
        textField.placeholder = "enter movie title here"
        textField.keyboardType = .decimalPad
        }
        
        alertController.addAction(searchAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func previous(_ sender: UIBarButtonItem) {
        self.iteratorMessage.text = ""
        self.addMessage.text = ""
        self.searchMessage.text = ""
        if(movieInfoDictionary.movArray.isEmpty)
        {
            self.iteratorMessage.text = "No Movies"
        }
        else{
            
            let current = self.iteratorOutput.text!
            let update = self.movieInfoDictionary.getPrev(current)
            if (update != nil){
                self.iteratorOutput.text = update!
            }
            else{
                self.iteratorMessage.text = "Showing the first record"
            }
        }
        
    }
    
    @IBAction func next(_ sender: UIBarButtonItem) {
        self.iteratorMessage.text = ""
        self.addMessage.text = ""
        self.searchMessage.text = ""
        if(movieInfoDictionary.movArray.isEmpty)
        {
            self.iteratorMessage.text = "No Movies"
        }
        else{
            
            let current = self.iteratorOutput.text!
            let update = self.movieInfoDictionary.getNext(current)
            if (update != nil){
                self.iteratorOutput.text = update!
            }
            else{
                self.iteratorMessage.text = "No more records"
            }
        }
    }
    
    @IBAction func Edit(_ sender: UIBarButtonItem)
    {
        self.searchMessage.text = ""
        self.addMessage.text = ""
        // show the alert controller with data input text field
        let alertController = UIAlertController(title: "Edit Movie", message: "", preferredStyle: .alert)
        let editAction = UIAlertAction(title: "Edit", style: .default) { (aciton) in
            
            let text = alertController.textFields![0] as UITextField
            let newTickets = alertController.textFields![1] as UITextField
            
            if text.hasText && newTickets.hasText
            {
                let title = text
                let tickets = newTickets
                let n = self.movieInfoDictionary.search(t: title.text!)
                n?.tickets = Int16(tickets.text!)
                print(title.text!)
                print(tickets.text!)
                print("into dict")
                self.movieInfoDictionary.edit(String(title.text!), Int(tickets.text!)!)
                //update interator output
                self.iteratorOutput.text = self.movieInfoDictionary.getLatest()
                self.iteratorMessage.text = ""
             }
             else
             {
                   // Alert message will be displayed to the user if there is no input
                   let alert = UIAlertController(title: "Data Input Error", message: "enter movie title and tickets to edit", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "enter movie title here"
            textField.keyboardType = .decimalPad
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "enter new ticket count here"
            textField.keyboardType = .decimalPad
        }
        
        alertController.addAction(editAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func search(_ sender: UIBarButtonItem) {
        self.searchMessage.text = ""
        self.addMessage.text = ""
        // show the alert controller with data input text field
        let alertController = UIAlertController(title: "Movie Search", message: "", preferredStyle: .alert)
        
        let searchAction = UIAlertAction(title: "Search", style: .default) { (aciton) in
            
            let text = alertController.textFields!.first!.text!
            
            //find movie in model view
            if !text.isEmpty {
                let title = text
                let m =  self.movieInfoDictionary.search(t: title)
                if let x = m {
                    self.searchedTitle.text = x.title!
                    self.searchedGenre.text = x.genre!
                    self.searchedTickets.text = String(x.tickets!)
                }else{
                    self.searchMessage.text = "No search results"
                }
             }
             else {
                   // Alert message will be displayed to th user if there is no input
                   let alert = UIAlertController(title: "Data Input Error", message: "enter movie to search", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "enter movie here"
            textField.keyboardType = .decimalPad
        }
        
        alertController.addAction(searchAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

