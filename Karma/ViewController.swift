//
//  ViewController.swift
//  Karma
//
//  Created by Christopher Betz on 1/23/19.
//  Copyright © 2019 Betz Software LLC. All rights reserved.
//

import UIKit
import PassKit

class ViewController: UIViewController {
    @IBOutlet weak var passButton: PKAddPassButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func addPassTapped(_ sender: PKAddPassButton) {
        
        guard let url = URL(string: "http://localhost:8080/user/betzsoftware") else { return }
        guard let passData = try? Data(contentsOf: url) else { return }

        do {
            let pass = try PKPass(data: passData)

            let passLibrary = PKPassLibrary()
            if passLibrary.containsPass(pass) {
                UIApplication.shared.open(pass.passURL!, options: [:])
            } else {
                if let vc = PKAddPassesViewController(pass: pass) {
                    self.present(vc, animated: true, completion: nil)
                }
            }
        } catch {
            // display an error
            let alertController = UIAlertController(
                title: "Unable to add pass",
                message: "Please try again",
                preferredStyle: .alert)
            alertController.addAction(
                UIAlertAction(title: "Close", style: .cancel) { (action) in
                    // Do nothing.
            })
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        /*if let filepath = Bundle.main.path(forResource: "Karma", ofType: "pkpass") {
            let pkfile : Data = NSData(contentsOfFile: filepath)! as Data
            do {
                let pass : PKPass = try PKPass(data: pkfile)
                let vc = PKAddPassesViewController(pass: pass) as! PKAddPassesViewController
                self.present(vc, animated: true, completion: nil)
            } catch {
                
            }
        } else {
            print("Boarding pass not found.")
        }*/
        
    }
}

