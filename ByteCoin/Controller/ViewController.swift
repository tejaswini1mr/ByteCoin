//
//  ViewController.swift
//  ByteCoin
//
//  Created by Tejaswini MR on 11/09/2019.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,CoinManagerDeligate {
    
    
    var coinManager=CoinManager()
    func didUpdatelastPrice(price: String, currency: String) {
        
        DispatchQueue.main.async {
            self.bitcoinsLabel.text=price
            self.currencyLabel.text=currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {//to determine how many columns we need in our picker
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count   //how many rows the picker should have to pick
    }
    
    
    @IBOutlet weak var bitcoinsLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource=self
        currencyPicker.delegate=self
        coinManager.deligate
            = self//adding viweController class as datasource to currency picker.
        // Do any additional setup after loading the view.
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]//it will load  picker data to picker
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let currency1=coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: currency1)
        
        
    }
    


}


    
    
    
    


