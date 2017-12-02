//
//  testeViewController.swift
//  MiniChallenge5
//
//  Created by Vinícius Cano Santos on 09/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    //Declaração da constraint da imagem do círculo
    @IBOutlet weak var circleImageTopConstraint: NSLayoutConstraint!
    
    // Declaração das contraints dos botões
    @IBOutlet weak var playButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var locationsMapButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var aboutButtonConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TESTE
        let circuitDataManager: CircuitDataManager = CircuitDataManager()
        
        //CRIAR CIRCUITO
//        var circuit: Circuit = Circuit();
//        circuit.bows.append(Bow(latitude: 10, longitude: 20))
//        circuit.bows.append(Bow(latitude: 20, longitude: 30))
//        circuit.bows.append(Bow(latitude: 30, longitude: 40))
//        circuit.bows.append(Bow(latitude: 40, longitude: 50))
//        circuit.bows.append(Bow(latitude: 50, longitude: 60))
//        circuitDataManager.create(circuit: circuit, callback: {print("***CEATED CIRCUIT: \($0)***")})
        
        //LER TODOS OS CIRCUITOS
//        print("***Circuits***\n")
//        circuitDataManager.read(callback: {$0.forEach({print("Circuit: \($0)\n")})})
        
        //LER POR ID
//        print("***Circuits***\n")
//        circuitDataManager.readById(id: 25, callback: {print("Read Circuit: \($0)\n")})
//        circuitDataManager.readById(id: 26, callback: {print("Read Circuit: \($0)\n")})
//        circuitDataManager.readById(id: 27, callback: {print("Read Circuit: \($0)\n")})
//        circuitDataManager.readById(id: 28, callback: {print("Read Circuit: \($0)\n")})
//        circuitDataManager.readById(id: 29, callback: {print("Read Circuit: \($0)\n")})
        
        //DELETAR CIRCUITO
//        print("***Circuits***\n")
//        circuitDataManager.delete(id: 22, callback: {print("Deleted circuit: \($0)\n")})
//        circuitDataManager.delete(id: 21, callback: {print("Deleted circuit: \($0)\n")})
//        circuitDataManager.delete(id: 20, callback: {print("Deleted circuit: \($0)\n")})
        
        //LER LOCALIZAÇÃO DOS CIRCUITOS
//        print("***Localizações***\n")
//        circuitDataManager.getCircuitLocations(callback: {$0.forEach({print("Circuit Location: \($0)")})})
        
        //TESTE
        
        //Coloca imagem e filtro no background da view
        let backgroundImage = UIImageView(frame: self.view.frame)
        let filterImage = UIImageView(frame: self.view.frame)
        
        backgroundImage.image = UIImage(named: "background_image")
        filterImage.image = UIImage(named: "filter")
        
        self.view.insertSubview(filterImage, at: 0)
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        
        // Deixa a navigation bar transparente
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        // Deixa a navigation bar sem sombra
            navigationController?.navigationBar.shadowImage = UIImage()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Constraints
        circleImageTopConstraint.constant = self.view.frame.size.height * 0.149
        
        playButtonConstraint.constant = self.view.frame.size.height * 0.523
        locationsMapButtonConstraint.constant = self.view.frame.size.height * 0.652
        aboutButtonConstraint.constant = self.view.frame.size.height * 0.779
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