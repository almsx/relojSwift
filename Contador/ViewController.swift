//
//  ViewController.swift
//  Contador
//
//  Created by Alberto Luebbert M. on 31/03/17.
//  Copyright © 2017 Alberto Luebbert M. All rights reserved.
//

import UIKit

import Foundation

class Servicios{
    
    init() {
        
    }
    
    public func descargarWS(){
        let urlCompleto = "http://rest-service.guides.spring.io/greeting"
        
        
        let objetoUrl = URL(string:urlCompleto)
        
        
        
        let tarea = URLSession.shared.dataTask(with: objetoUrl!) { (datos, respuesta, error) in
            
            if error != nil {
                
                print(error!)
                
            } else {
                
                do{
                    let json = try JSONSerialization.jsonObject(with: datos!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    print("***")
                    print(json)
                    print("***")
                    
                }catch {
                    
                    print("El Procesamiento del JSON tuvo un error")
                    
                }
                
            }
            
        }
        
        tarea.resume()
    }
    
    public func downloadPlaces(){
    
        let session = URLSession.shared
        let apiURL = URL(string: "http://api.androidhive.info/contacts/")
        //let apiURL = URL(string: "http://ans.globalhitss.com//api/bbva/usuarios")
        
        
        let urlRequest = URLRequest(url: apiURL!)
        
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            
            if error == nil {
                
                do {
                    print ("si se logro")
                    let newJSONData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Dictionary<String, AnyObject>
                    //let allKeys = newJSONData.keys
                    let allKeys = newJSONData
                    print (allKeys)
                    
                }
                
                catch {
                    print("hubo un error en el parseo")
                }
                
            }
            else {
                print("fallo la descarga")
            }
            
            
        })
        
        task.resume()
        
    
    }
    
    
}

class ViewController: UIViewController {
    
    var counter = 0
    var timer = Timer()
    
    public func ponerReloj(){
        
        let fechaHoy = Date()
        let calendar = Calendar.current
        let hora = calendar.component(.hour, from: fechaHoy)
        let minutos = calendar.component(.minute, from: fechaHoy)
        let segundos = calendar.component(.second, from: fechaHoy)
        
        var medirSegundos = String(segundos)
        let resultadoSegundos = medirSegundos.characters.count
        
        var medirMinutos = String(minutos)
        let resultadoMinutos = medirMinutos.characters.count
        
        let minutosTotal : String
        let segundosTotal : String
        
        if resultadoMinutos == 1 {
            minutosTotal = "0\(minutos)"
        } else {
            minutosTotal = String(minutos)
        }
        
        if resultadoSegundos == 1 {
            segundosTotal = "0\(segundos)"
        } else {
            segundosTotal = String(segundos)
        }
        

        
        print("******** La Hora exacta es \(hora):\(minutosTotal):\(segundosTotal)")
        textos.text = "\(hora):\(minutosTotal):\(segundosTotal)"
        
        
    }

    override func viewDidLoad() {
        
        //super.viewDidLoad()
        //Comente la linea de arriba
        
        // Do any additional setup after loading the view, typically from a nib.
        let places = Servicios()
        places.descargarWS()
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ponerReloj), userInfo: nil, repeats: true)
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


    @IBOutlet weak var textos: UILabel!
    
    
    @IBAction func tocarBoton(_ sender: Any) {
        
        //El codigo que se encuentre aquí se va a ejecutar
        textos.text = "bye!"
        
    }
}
