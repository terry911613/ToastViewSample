//
//  ViewController.swift
//  ToastViewSample
//
//  Created by Terry Lee on 2020/4/24.
//  Copyright © 2020 Terry Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func toastButton(_ sender: UIButton) {
        ToastView.showNotification(message: "ToastView Demo")
    }
}

