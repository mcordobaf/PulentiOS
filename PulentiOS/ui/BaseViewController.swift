//
//  BaseViewController.swift
//  PulentiOS
//
//  Created by Marco Cordoba Fernandez on 10/12/19.
//  Copyright © 2019 mcordobaf. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var dataSaved:DataSaved = DataSaved.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
