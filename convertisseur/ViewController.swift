//
//  ViewController.swift
//  convertisseur
//
//  Created by Mattias on 04/02/2020.
//  Copyright © 2020 Mattias. All rights reserved.
//

import UIKit

let DEVISE = NSLocalizedString("devise_title", comment: "")
let DISTANCE = "Distance"
let TEMPERATURE = "Temperature"

class ViewController: UIViewController {

    @IBOutlet weak var deviseView: UIView!
    @IBOutlet weak var distanceView: UIView!
    @IBOutlet weak var temperatureView: UIView!
    
    let segueID = "Convert"
    var views: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        views = [deviseView, distanceView, temperatureView]
        borderRadius()
        // Do any additional setup after loading the view.
    }
    
    func borderRadius () {
        for v in views {
            v.layer.cornerRadius = 10
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID {
            if let convertController = segue.destination as?
                ConvertController {
                convertController.type = sender as? String
            }
        }
    }

    @IBAction func buttonAction(_ sender: UIButton) {
        switch sender.tag {
        case 0: performSegue(withIdentifier: segueID, sender: DEVISE)
        case 1: performSegue(withIdentifier: segueID, sender: DISTANCE)
        case 2: performSegue(withIdentifier: segueID, sender: TEMPERATURE)
        default:
            break
        }
    }
    
}

