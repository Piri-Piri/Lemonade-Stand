//
//  ViewController.swift
//  Lemonade Stand
//
//  Created by David Pirih on 23.09.14.
//  Copyright (c) 2014 piri-piri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var lemonsLabel: UILabel!
    @IBOutlet weak var icecubesLabel: UILabel!
    
    @IBOutlet weak var purchaseLemonsLabel: UILabel!
    @IBOutlet weak var purchaseIcecubesLabel: UILabel!
    
    @IBOutlet weak var lemonsForMixLabel: UILabel!
    @IBOutlet weak var icecubesForMixLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    var supplies = Supplies(initialMoney: 10, initialLemons: 1, initialIcecubes: 1)
    var price = Price()
    
    var purchasedLemons = 0
    var purchasedIceCubes = 0
    var lemonsForMix = 0
    var icecubesForMix = 0
    
    var weatherRange:[[Int]] = [[5, 9, 7, 4], [15, 11, 17, 13], [27, 21, 23, 26]]
    var weatherToday:[Int] = [0, 0, 0, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupWeather()
        updateMainView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // MARK: Helper Functions
    
    func setupWeather() {
        let weatherIndex = Int(arc4random_uniform(UInt32(weatherRange.count)))
        switch weatherIndex {
        case 0: weatherImageView.image = UIImage(named: "Cold")
        case 1: weatherImageView.image = UIImage(named: "Mild")
        case 2: weatherImageView.image = UIImage(named: "Warm")
        default: weatherImageView.image = UIImage(named: "")
        }
        println("WeatherIndex: \(weatherIndex)")
        weatherToday = weatherRange[weatherIndex]
    }
    
    func computeCustomerVisitForWeatherToday() -> Int {
        return Int(arc4random_uniform(UInt32(computeAverage(weatherToday))))
    }
    
    func computeAverage(data: [Int]) -> Int {
        var sum = 0
        
        for x in data {
            sum += x
        }
        println("Average: \(Int(ceil(Double(sum) / Double(data.count))))")
        return Int(ceil(Double(sum) / Double(data.count)))
    }
    
    func updateMainView() {
        moneyLabel.text = "$\(supplies.money)"
        lemonsLabel.text = "\(supplies.lemons) Lemons"
        icecubesLabel.text = "\(supplies.icecubes) Ice Cubes"
        
        purchaseLemonsLabel.text = "\(purchasedLemons)"
        purchaseIcecubesLabel.text = "\(purchasedIceCubes)"
        
        lemonsForMixLabel.text = "\(lemonsForMix)"
        icecubesForMixLabel.text = "\(icecubesForMix)"
    }
    
    func reset() {
        purchasedLemons = 0
        purchasedIceCubes = 0
        lemonsForMix = 0
        icecubesForMix = 0
        
        setupWeather()
        updateMainView()
    }
    
    func hardReset() {
        reset()
        supplies = Supplies(initialMoney: 10, initialLemons: 1, initialIcecubes: 1)
    }
    
    func showAlertWithText(header:String = "Warning", message:String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func computeRevenue() -> Int {
        var revenue = 0
        var customerRatio: Double
        
        var mixRatio:Double = Double(lemonsForMix)
        // we should avoid divide by zero
        if icecubesForMix != 0 {
            mixRatio = Double(lemonsForMix) / Double(icecubesForMix)
        }
        
        let customers = computeCustomerVisitForWeatherToday()
        println("Customers: \(customers)")

        for var i = 0; i < customers; i++ {
            customerRatio = Double(arc4random_uniform(UInt32(101))) / 100
            
            if customerRatio < 0.4 && mixRatio > 1 {
                revenue++
                supplies.money += 1
                println("Match: Customer Preference: \(customerRatio) and Lemonade mix: \(mixRatio)")
            }
            else if customerRatio > 0.6 && mixRatio < 1 {
                revenue++
                supplies.money += 1
                println("Match: Customer Preference: \(customerRatio) and Lemonade mix: \(mixRatio)")
            }
            else if customerRatio <= 0.6 && customerRatio >= 0.4 && mixRatio == 1 {
                revenue++
                supplies.money += 1
                println("Match: Customer Preference: \(customerRatio) and Lemonade mix: \(mixRatio)")
            }
            else {
                println("No Match: Customer Preference: \(customerRatio) and Lemonade mix: \(mixRatio)")
            }
        }
        return revenue
    }
    
    // MARK: IBActions
    
    @IBAction func purchaseLemonsAction(sender: AnyObject) {
        if supplies.money < price.lemonPrice {
            showAlertWithText(message: "Not enough my to buy more supplies!")
        } else {
            purchasedLemons += 1
            supplies.lemons += 1
            supplies.money -= price.lemonPrice
        
            updateMainView()
        }
    }
    
    @IBAction func unpurchaseLemonsAction(sender: AnyObject) {
        if purchasedLemons > 0 {
            purchasedLemons -= 1
            supplies.lemons -= 1
            supplies.money += price.lemonPrice
            
            updateMainView()
        }
    }
    

    @IBAction func purchaseIcecubesAction(sender: AnyObject) {
        if supplies.money < price.icecubePrice {
            showAlertWithText(message: "Not enough my to buy more supplies!")
        } else {
            purchasedIceCubes += 1
            supplies.icecubes += 1
            supplies.money -= price.icecubePrice
            
            updateMainView()
        }
    }
    
    
    @IBAction func unpurchaseIcecubesAction(sender: AnyObject) {
        if purchasedIceCubes > 0 {
            purchasedIceCubes -= 1
            supplies.icecubes -= 1
            supplies.money += price.icecubePrice

            updateMainView()
        }
    }
    
    @IBAction func addLemonsForMixAction(sender: AnyObject) {
        if supplies.lemons > 0 {
            lemonsForMix += 1
            supplies.lemons -= 1
            
            updateMainView()
        }
    }
    
    @IBAction func removeLemonsForMixAction(sender: AnyObject) {
        if lemonsForMix > 0 {
            lemonsForMix -= 1
            supplies.lemons += 1
            
            updateMainView()
        }
    }
    
    
    @IBAction func addIcecubesForMixAction(sender: AnyObject) {
        if supplies.icecubes > 0 {
            icecubesForMix += 1
            supplies.icecubes -= 1
            
            updateMainView()
        }
    }
    
    
    @IBAction func removeIcecubessForMixAction(sender: AnyObject) {
        if icecubesForMix > 0 {
            icecubesForMix -= 1
            supplies.icecubes += 1
            
            updateMainView()
        }
    }
    
    @IBAction func startDayAction(sender: AnyObject) {
        if lemonsForMix > 0 {
            let revenue = computeRevenue()
            if (revenue > 0) {
                showAlertWithText(header: "You got paid!", message: "Your mix matches your customers preference! Revenue: \(revenue)")
            }
            else {
                showAlertWithText(header: "Bad Day!", message: "Your mix did NOT matches your customers preference!")
            }
            
            if supplies.icecubes == 0 && supplies.lemons == 0 && supplies.money < 1 {
                showAlertWithText(header: "Game over!", message: "You have lost all yout money!")
                hardReset()
            }
            
            reset()
        } else {
            showAlertWithText(message: "You have to add at least a lemon!")
        }
    }
}

