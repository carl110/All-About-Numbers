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
    
    private var triviaType = String()
    private var numberFact = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundSetup(image: UIImage(named: "numberVortex")!)
        hideKeyboardWhenTappedAround()
        titleLabelSetup()
        segmentControlSetup()
        buttonAndTextFieldSetup()
        labelSetup()
    }
    
    func titleLabelSetup() {
        titleLabel.text = "All About Numbers"
        titleLabel.titleLabelSetUp()
        titleLabel.backgroundColor = UIColor.Shades.transparentWhite
    }
    
    func segmentControlSetup() {
        //Set titles for segments
        typeSelector.setTitle("Math", forSegmentAt: 0)
        typeSelector.setTitle("Number", forSegmentAt: 1)
        typeSelector.setTitle("Year", forSegmentAt: 2)
        typeSelector.backgroundColor = UIColor.Shades.transparentWhite
    }
    
    func buttonAndTextFieldSetup() {
        confirmNumberButton.setTitle("Confirm", for: .normal)
        confirmNumberButton.titleButtonSetup()
        
        numberTextField.setAutoTextSize()
        numberTextField.keyboardType = UIKeyboardType.numberPad
        numberTextField.clearsOnInsertion = true
    }
    
    func labelSetup() {
        
        recievedText.text = "Select Math, Number or Year above and enter your number in the box. Or if you prefer don't enter a number and recieve a random fact/trivia."
        recievedText.titleLabelSetUp()
        recievedText.roundCorners(for: .allCorners, cornerRadius: 8)
        recievedText.backgroundColor = UIColor.Shades.transparentWhite
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
                print("error calling GET on numberAPI")
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
                
                //check for the individual data
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
                    self.recievedText.text = "\(apiType)\n\n\(text)".titlecased()
                }
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }
    
    func setTypeAndNumber() {
        //set type for API URL from segmentedcontroller selection
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
        //Check if text field is empty, if it is set entity to random
        if let textField = numberTextField.text, textField.isEmpty {
            numberFact = "Random"
        } else {
            numberFact = numberTextField.text!
        }
    }
    
    @IBAction func confirmNumberButton(_ sender: Any) {
        setTypeAndNumber()
        makeGetCall(number: numberFact, type: triviaType)
    }
}

