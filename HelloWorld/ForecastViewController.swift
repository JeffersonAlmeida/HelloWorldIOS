//
//  ForecastViewController.swift
//  HelloWorld
//
//  Created by ios7061 on 08/05/17.
//  Copyright © 2017 ios7061. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    
    @IBOutlet weak var wheatherCondition: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var min: UILabel!
    @IBOutlet weak var max: UILabel!
    
    var contact: Contact?
    
    let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?lat=-23.588453&lon=-46.632103&APPID=f7a351305e34142acae48fef35b69386&units=metric"
    
    let IMAGE_URL = "http://openweathermap.org/img/w/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.contact != nil {
            let lat = contact?.lat ?? 0
            let log = contact?.log ?? 0
            let latPlusLog = "&lat=\(lat)&lon=\(log)"
            let endpoint = URL(string: BASE_URL + latPlusLog)
            print (endpoint)
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: endpoint!) { (data, response, error ) in
                let response = response as? HTTPURLResponse
                if response?.statusCode == 200 {
                    print("Sucesso")
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject] {
                            let main = json["main"] as! [ String: AnyObject ]
                            
                            let wheather = json["weather"]![0] as! [ String: AnyObject ]
                            let condition = wheather["main"] as! String
                            
                            let min = main["temp_min"] as! Double
                            let max = main["temp_max"] as! Double
                            
                            let icon = wheather["icon"] as! String
                            self.getImage(icon: icon)
                            
                            DispatchQueue.main.async {
                                self.min.text = min.description
                                self.max.text = max.description
                                self.wheatherCondition.text = condition.description
                            }
                        }
                        
                    }catch let error as NSError {
                        print("Error no parse do JSON")
                    }
                    
                }else{
                    print("Ocorreu algum problema com a requisição!")
                }
                
            }
            task.resume()
            
        }
    }
    
    private func getImage(icon: String){
        let endpoint = URL(string: IMAGE_URL + icon + ".png")
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: endpoint!) { (data, response, error ) in
            let httpResponse = response as! HTTPURLResponse
            if  httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data!)
                }
            }else{
                print("Ocorreu algum problema com o download da imagem!")
            }
        }
        
        task.resume()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
