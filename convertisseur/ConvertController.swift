//
//  ConvertController.swift
//  convertisseur
//
//  Created by Mattias on 04/02/2020.
//  Copyright © 2020 Mattias. All rights reserved.
//

import UIKit

enum Choice {
    case device, distance, temperature
}

class ConvertController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var entryView: UIView!
    
    @IBOutlet weak var toDoLabel: UILabel!
    
    @IBOutlet weak var dataTextField: UITextField!
    
    @IBOutlet weak var resultView: UIView!
    
    @IBOutlet weak var resultLabel: UILabel!
    var type: String?
    
    
    let euros = "euros"
    let dollar = "dollars"
    var isReverse = false
    let km = "kilomètre"
    let mi = "miles"
    let celsius = "celsius"
    let fahrenheit = "fahrenheit"
    let format = "%.2f"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let choice = type {
            titleLabel.text = "Convertisseur de: " + choice
            chooseType(choice)
        } else {
            dismiss(animated: true, completion: nil)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func chooseType(_ choice: String) {
        switch choice {
        case DEVISE: setup(euros, dollar)
        case DISTANCE: setup(km, mi)
        case TEMPERATURE: setup(celsius, fahrenheit)
        default: break
        }
    }
    
    func setup (_ primary: String,_ secondary: String) {
        if !isReverse{
            titleLabel.text = String(format: NSLocalizedString("convert_to", comment: ""), primary, secondary)
            toDoLabel.text = "Entrez le nombre de " + primary
        } else {
            titleLabel.text = "Convertir " + secondary + " en " + primary
            toDoLabel.text = "Entrez le nombre de " + secondary
        }
    }
    
    func calculate() {
        if let monType = type, let texte = dataTextField.text, let double = Double(texte) {
            switch monType {
            case DEVISE:
                resultLabel.text = isReverse ? euros(double) : dollar(double)
            case TEMPERATURE:
                resultLabel.text = isReverse ? celsius(double) : fahrenheit(double)
            case DISTANCE:
                resultLabel.text = isReverse ? km(double) : mi(double)
            default:
                break
            }
        }
    }
    
    func euros(_ dollars: Double) -> String {
        return String(format: format, (dollars * 0.81)) + "€"
    }
    
    func dollar(_ euros: Double) -> String {
        return String(format: format, (euros / 0.81)) + "$"
    }
    
    func km(_ mi: Double) -> String {
        return String(format: format, (mi / 0.621)) + "km"
    }
    
    func mi(_ km: Double) -> String {
        return String(format: format, (km * 0.621)) + "mi"
    }
    
    func celsius(_ fahrenheit: Double) -> String {
        return String(format: format, ((fahrenheit - 32) / 1.8)) + "°C"
    }
    
    func fahrenheit(_ celsius: Double) -> String {
        return String(format: format, ((celsius * 1.8) + 32)) + "°F"
    }
    
    @IBAction func changeButton(_ sender: Any) {
        guard let type = type else {return}
        isReverse = !isReverse
        chooseType(type)
        calculate()
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func textChanged(_ sender: UITextField) {
        calculate()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

class CornerView: UIView {
    
    @IBInspectable var corner: CGFloat = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = self.corner
    }
}
