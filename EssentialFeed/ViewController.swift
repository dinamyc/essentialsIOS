//
//  ViewController.swift
//  EssentialFeed
//
//  Created by Jose Luis Enriquez on 17/04/2023.
//

import UIKit

class ViewController: UIViewController {
    var elements = [2, 3, 4, 6]
    override func viewDidLoad() {
        super.viewDidLoad()
        elements.append(73)
        print(elements)
    }
}

