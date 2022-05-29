//
//  ViewController.swift
//  PushNotification
//
//  Created by Dmitry Sokoltsov on 27.05.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var CountNewNotification: UILabel!
    
    var numberOfNewNotification = "\(imageUrls.count)"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CountNewNotification.text = "У вас новых \(numberOfNewNotification) уведомлений"
    }

    @IBAction func showImageButton(_ sender: Any) {
    }
    
}

