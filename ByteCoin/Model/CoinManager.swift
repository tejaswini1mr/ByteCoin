//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Tejaswini MR on 11/09/2019.
//

import Foundation
protocol CoinManagerDeligate {
    func didUpdatelastPrice(price:String,currency:String)
    func didFailWithError(error:Error)
}


struct CoinManager {
    
    var deligate:CoinManagerDeligate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "6386A27F-9F14-45D0-82BD-3CB40239581B"
    
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency:String){
        let urlString="\(baseURL)/\(currency)?apikey=\(apiKey)"
        //print(urlString)
        if let url=URL(string: urlString){
            let session=URLSession(configuration: .default)
            let task=session.dataTask(with: url){ (data,response,error) in
            if error != nil{
                self.deligate?.didFailWithError(error:error!)
                return
            }
                //print(data)
                if let safeData=data{
                    if let bitCoinPrice=self.parseJSON(safeData){
                        let priceString=String(format: "%0.2f", bitCoinPrice)
                        self.deligate?.didUpdatelastPrice(price: priceString, currency: currency)
                    
                }
            }
            
        }
            task.resume()
        
    }
    }
    func parseJSON(_ data:Data) -> Double? {
        let decoder=JSONDecoder()
        do{
            let decodeData=try decoder.decode(CoinData.self, from: data)
            let lastPrice=decodeData.rate
            print(lastPrice)
            return lastPrice
            //let lastprice=decodeData.last
            
        }catch{
            deligate?.didFailWithError(error: error)
            return nil
        }
    }

    
}

