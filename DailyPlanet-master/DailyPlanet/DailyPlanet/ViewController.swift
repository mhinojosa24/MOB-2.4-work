//
//  ViewController.swift
//  DailyPlanet
//
//  Created by Thomas Vandegriff on 2/7/19.
//  Copyright © 2019 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nasaDailyImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        fetchHeaderData()
        
        //TODO: Call function to fetch image data here
//        fetchNasaDailyImage()
        fetchCharacters()
    }

    //MARK: Data Fetch functions
    
    func fetchHeaderData() {
        
        let defaultSession = URLSession(configuration: .default)
        
        // Create URL
        let url = URL(string: "https://httpbin.org/headers")
        
        // Create Request
        let request = URLRequest(url: url!)
        
        // Create Data Task
        let dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            print("data is: ", data!)
            print("response is: ", response!)
            
        })
        dataTask.resume() // NOTE: tells to do the task
    }

    
    //CODE BASE for In-Class Activity I
    func fetchNasaDailyImage() {
     
        //TODO: Create session configuration here
        let defaultSession = URLSession(configuration: .default)
     
        //TODO: Create URL (...and send request and process response in closure...)
        if let url = URL(string: "https://apod.nasa.gov/apod/image/1906/solargraphBelgrado.jpg") {
     
           //TODO: Create Request here
            let request = URLRequest(url: url)
            //Create Data Task...
            let dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
     
                print("data is: ", data!)
                print("response is: ", response!)
     
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
     
                        //TODO: Insert downloaded image into imageView
                        self.nasaDailyImageView.image = image
                    }
                }
            })
            dataTask.resume()
        }
    }
    
    
    func fetchCharacters() {
        
        let defaultSession = URLSession(configuration: .default)
        
        if let url = URL(string: "https://swapi.co/api/starships/10/") {
            let request = URLRequest(url: url)
            
            let dataTask = defaultSession.dataTask(with: request) { (data, response, error) -> Void in
                print("data => ", data!)
                print("response => ", response!)
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(jsonObject)
                } catch let error as NSError{
                    print(error)
                }
            }
            dataTask.resume()
        }
    }
    
}

