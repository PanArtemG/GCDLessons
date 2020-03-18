//
//  SecondViewController.swift
//  GSD
//
//  Created by Artem Panasenko on 17.03.2020.
//  Copyright © 2020 Artem Panasenko. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatot: UIActivityIndicatorView!
    
    fileprivate var imageUrl: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        
        set {
            activityIndicatot.stopAnimating()
            activityIndicatot.isHidden = true
            
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImage()
        delay(3) {
            self.loginAlert()
        }
    }
    
    // Set TIMEOUT
    fileprivate func delay(_ delay: Int, clousere: @escaping () -> ()) { // @escaping - clousere не замкнут а передается в эту функцию
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            clousere()
        }
    }
    
    //Создаем ALERT CONROLLER
    fileprivate func loginAlert() {
        let ac = UIAlertController(title: "Зарегистрированы???", message: "Введи логин и пароль", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Reset", style: .default, handler: nil)
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField{(usernameTF) in
            usernameTF.placeholder = "Enter login"
        }
        
        ac.addTextField{(usernamePaswordTF) in
            usernamePaswordTF.placeholder = "Enter password"
            usernamePaswordTF.isSecureTextEntry = true
        }
        // Отобразить текстовые поля
        self.present(ac, animated: true, completion: nil)
    }
    
    //Создаем метод для полученя изображения
    fileprivate func fetchImage() {
        imageUrl = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")
        
        activityIndicatot.startAnimating()
        activityIndicatot.isHidden = false
        
        // !!!!!!!!!! Применяем GSD !!!!!!!!!!
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageUrl, let imageData = try? Data(contentsOf: url) else { return }
            // Возвращаемся в главный поток
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
}

