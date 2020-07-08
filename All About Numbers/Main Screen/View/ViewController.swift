//
//  ViewController.swift
//  All About Numbers
//
//  Created by Carl Wainwright on 06/07/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var confirmNumberButton: UIButton!
    @IBOutlet weak var recievedText: UILabel!
    @IBOutlet weak var typeSelector: UISegmentedControl!
    
    private var triviaType = "Math"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUp()
        segmentControlSetup()
        labelSetup()
    }
    
    func setUp() {
        backgroundSetup(image: UIImage(named: "numberVortex")!)
        titleLabel.text = "Number Trivia"
        titleLabel.titleLabelSetUp()
        confirmNumberButton.setTitle("Confirm", for: .normal)
//        confirmNumberButton.backgroundColor = UIColor.Yellows.standardYellow
        confirmNumberButton.titleButtonSetup()

        numberTextField.setAutoTextSize()
    }
    
    func segmentControlSetup() {

        //Set titles for segments
        typeSelector.setTitle("Math", forSegmentAt: 0)
        typeSelector.setTitle("Number", forSegmentAt: 1)
        typeSelector.setTitle("Year", forSegmentAt: 2)
        
    }
    
    func labelSetup() {
        
        recievedText.text = "Select Math, Number or Year above and enter your number in the box. Or if you prefer don't enter a number and recieve a random fact/trivia."
//        recievedText.numberOfLines = 0
        recievedText.titleLabelSetUp()
    }

    

    func makeGetCall(number: String, type: String) {

    // Set up the URL request
      let apiURL: String = "http://numbersapi.com/" + number + "/" + type + "?json"
     
        guard let url = URL(string: apiURL) else {
        print("Error: cannot create URL")
       return
      }

      let urlRequest = URLRequest(url: url)
      
      // set up the session
      let config = URLSessionConfiguration.default
      let session = URLSession(configuration: config)

      //  make the request
      let task = session.dataTask(with: urlRequest) {
        (data, response, error) in
        // check for any errors
        guard error == nil else {
          print("error calling GET on /todos/1")
          print(error!)
          return
        }

        // make sure there is data
        guard let responseData = data else {
          print("Error: did not receive data")
          return
        }

        // parse the result as JSON
        do {
          guard let factText = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
            print("error trying to convert data to JSON")
            return
          }

          // now we have the todo, let's just print it to prove we can access it
          print("The todo is: " + factText.description)

          // the todo object is a dictionary
          // so we just access the title using the "title" key
          // so check for a title and print it if we have one
          guard let text = factText["text"] as? String else {
            print("Could not get text from JSON")
            return
          }
            
            guard let apiType = factText["type"] as? String else {
              print("Could not getb type from JSON")
              return
            }

            //Bring to main queue
            DispatchQueue.main.async {
                self.recievedText.text = "\(text)"
            }

        } catch  {
          print("error trying to convert data to JSON")
          return
        }

      }

      task.resume()

    }
    
    func setType() {
        switch typeSelector.selectedSegmentIndex {
        case 0:
            triviaType = "math"
        case 1:
            triviaType = ""
        case 2:
            triviaType = "year"
        default:
            break
        }
    }
    
    @IBAction func confirmNumberButton(_ sender: Any) {
        
        
        setType()
        
        var numberFact = "Random"
        
        
        //Check if text field is empty, if it is set entity to random
        if let textField = numberTextField.text, textField.isEmpty {
            numberFact = "Random"
        } else {
            numberFact = numberTextField.text!
        }
        
        makeGetCall(number: numberFact, type: triviaType)

    }

}

