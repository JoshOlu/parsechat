//
//  ChatViewController.swift
//  
//
//  Created by Josh Olumese on 6/26/17.
//
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var chatTableView: UITableView!
    
    @IBOutlet weak var chatMessageField: UITextField!
    

    var chats: [PFObject] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.dataSource = self
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        
        // Auto size row height based on cell autolayout constraints
        chatTableView.rowHeight = UITableViewAutomaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        chatTableView.estimatedRowHeight = 50
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendButton(_ sender: Any) {
        let chatMessage = PFObject(className: "Message_fbu2017")
        chatMessage["text"] = chatMessageField.text ?? ""
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.chatMessageField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        let message = chats[indexPath.row]
        let chat = message["text"]
        
        if let user = message["user"] as? PFUser {
            // User found! update username label with username
            cell.usernameLabel.text = user.username
        } else {
            // No user found, set default username
            cell.usernameLabel.text = "🤖"
        }

        
        cell.messageLabel.text = chat as! String
        
        return cell
        
        
    }
    
    func onTimer() {
        var query = PFQuery(className: "Message_fbu2017")
        query.includeKey("user")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
        
            if error == nil{
                self.chats = posts!
                self.chatTableView.reloadData()
            } else {
                print(error)
            }
        }
        
        }
                    // The getObjectInBackgroundWithId methods are asynchronous, so any code after this will run
        // immediately.  Any code that depends on the query result should be moved
        // inside the completion block above.
    
    
    
    
   
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
