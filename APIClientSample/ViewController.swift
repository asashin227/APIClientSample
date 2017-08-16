//
//  ViewController.swift
//  APIClientSample
//
//  Created by Asakura Shinsuke on 2017/08/15.
//  Copyright © 2017年 Asakura Shinsuke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UserRepository(userName: "asashin227").request() { result in
            switch result {
            case .Success(let responce):
                print(responce)
            case .Error(let error):
                print(error.localizedDescription)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

