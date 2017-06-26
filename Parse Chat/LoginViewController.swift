//
//  LoginViewController.swift
//  Parse Chat
//
//  Created by Josh Olumese on 6/26/17.
//  Copyright © 2017 Josh Olumese. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func Login(_ sender: Any) {
        
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let alertController = UIAlertController(title: "Username and Password Required", message: "Please enter a username and password.", preferredStyle: .alert)
        let errorAlertController = UIAlertController(title: "Incorrect Username or Password", message: "Please try again.", preferredStyle: .alert)
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if self.usernameTextField.text?.isEmpty == true || self.passwordTextField.text?.isEmpty == true{
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                // add the cancel action to the alertController
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            
            }
            
            if let error = error{
                print("User log in failed: \(error.localizedDescription)")
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                // add the cancel action to the alertController
                errorAlertController.addAction(cancelAction)
                self.present(errorAlertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
                
                
            }
            else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
            }
        }
        
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameTextField.text
        //newUser.email = emailLabel.text
        newUser.password = passwordTextField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
