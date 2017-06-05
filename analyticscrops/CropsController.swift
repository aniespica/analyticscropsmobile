//
//  ViewController.swift
//  analyticscrops
//
//  Created by Veevart on 5/20/17.
//  Copyright © 2017 aniespica. All rights reserved.
//

import UIKit
import Firebase

class CropsController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        let addIcon = UIImage(named: "add")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: addIcon, style: .plain, target: self, action: #selector(handleAddCrop))
        
        checkIfUserIsLoggedIn()
        
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    let addCrop = AddCrop()
    
    func handleAddCrop(){
        addCrop.showAddCrop()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
//        if #available(iOS 9, *){
        let request = NSMutableURLRequest(url: URL(string:"http://52.17.165.162:8080/delete/crop")!)
//        
//        }else{
//            var request = URLRequest(url: URL(string:"http://52.17.165.162:8080/delete/crop")!)
//              let session = URLSession()
//        }
        
        request.httpMethod = "POST"
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
        
        request.addValue("\(uid)", forHTTPHeaderField: "uid")
        
        var postSting = String()
        if let cropid = crops[indexPath.row].Id {
            postSting = "cropid=\(cropid)"
        }
        
        
        request.httpBody = postSting.data(using: .utf8)
        let sendRequest = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            print("Data: \(data)")
            
            guard error == nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                print("response = \(response)")
                
                let alertController = UIAlertController(title: "Destructive", message: "Los datos son incorrectos o a occurrido algun error con el servicio.", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
                
                // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    (result : UIAlertAction) -> Void in
                    print("OK")
                }
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                self.cropsDictionary.removeValue(forKey: self.crops[indexPath.row].Id!)
                self.attemptReloadOfTable()
            }
            
            
        })
        
        sendRequest.resume()

    }
    func checkIfUserIsLoggedIn(){
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            fetchUserAndSetupNavBarTitle()
        }
    }
    
    func handleLogout(){
        
        do{
            try FIRAuth.auth()?.signOut()
        }catch let logoutError{
            print(logoutError)
        }
        let loginCtrl = LoginController()
        present(loginCtrl, animated: true, completion: nil)
    }
    
    func fetchUserAndSetupNavBarTitle(){
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            return
        }
        
        FIRDatabase.database().reference().child("Company/-KeLBwQFDwrcMKyiwdDy/Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if var dictionary = snapshot.value as? [String: AnyObject] {
                dictionary["Id"] = uid as AnyObject?
                let user = User(dictionary: dictionary)
                self.setupNavBarWithUser(user)
            }
            
        }, withCancel: nil)
    
    }
    
    func setupNavBarWithUser(_ user:User){
        
        fetchCrops();
        
        let titleView = UIView()
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        //        titleView.backgroundColor = UIColor.redColor()
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(containerView)
        
        let profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        
        containerView.addSubview(profileImageView)
        
        //ios 9 constraint anchors
        //need x,y,width,height anchors
        profileImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let nameLabel = UILabel()
        
        containerView.addSubview(nameLabel)
        nameLabel.text = user.Name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        //need x,y,width,height anchors
        nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        
        containerView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        
        self.navigationItem.titleView = titleView
        //self.navigationItem.title = user.Name
        
//        titleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showChatController)))
        
    }
    
    func showCropController(_ crop: Crop){
        let collectionCropController = CollectionCropController(collectionViewLayout: UICollectionViewFlowLayout())
        collectionCropController.crop = crop    
        navigationController?.pushViewController(collectionCropController, animated: true)
    }
    
    var crops = [Crop]()
    var cropsDictionary = [String: Crop]()
    func fetchCrops(){
        
        let ref = FIRDatabase.database().reference().child("Company/-KeLBwQFDwrcMKyiwdDy/Crops")
        ref.keepSynced(true)
        ref.observe(.childAdded, with: { (snapshot) in
            
            if var dictionary = snapshot.value as? [String:AnyObject]{
                
                dictionary["Id"] = snapshot.key as AnyObject?
                let crop = Crop(dictionary: dictionary)
                self.cropsDictionary[snapshot.key] = crop
                
                self.attemptReloadOfTable()
                
            }
        })
        
        ref.observe(.childChanged, with: { (snapshot) in
            if var dictionary = snapshot.value as? [String:AnyObject]{
                
                dictionary["Id"] = snapshot.key as AnyObject?
                let crop = Crop(dictionary: dictionary)
                self.cropsDictionary.updateValue(crop, forKey: snapshot.key)
                self.attemptReloadOfTable()
                
            }
        })
        
        ref.observe(.childRemoved, with: { (snapshot) in
            self.cropsDictionary.removeValue(forKey: snapshot.key)
            self.attemptReloadOfTable()
        })
    }
    
    func attemptReloadOfTable(){
        self.crops = Array(self.cropsDictionary.values)
        DispatchQueue.main.async(execute: {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            self.crops.sort { (a, b) -> Bool in
                let aDate = dateFormatter.date(from: a.StartDate!)
                let bDate = dateFormatter.date(from: b.StartDate!)
                if aDate != nil && bDate != nil{
                    return aDate! > bDate!
                }
                return false
            }
            
            self.tableView.reloadData()
        })
    }
    
    let cellId = "cellId"
    
    //Table setups
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crops.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let crop = crops[indexPath.row]
        cell.textLabel?.text = crop.Name
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: crop.StartDate!)
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy MMM dd HH:mm"
        
        if date != nil {
            let dateText = dateFormatter.string(from: date!)

            cell.detailTextLabel?.text = dateText
        }
       
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let crop = self.crops[indexPath.row]
        self.showCropController(crop)
    }
    
    

}

