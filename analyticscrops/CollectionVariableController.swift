//
//  CollectionVariableController.swift
//  analyticscrops
//
//  Created by Veevart on 5/26/17.
//  Copyright © 2017 aniespica. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class CollectionVariableController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate{
    
    var variable: Variable? {
        didSet {
            navigationItem.title = variable?.Name
            inputContainerView.variable = variable
            collectionView?.addSubview(inputContainerView)
            
            if variable?.Formula != nil || variable?.Sensor == true {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                if (variable?.isModify)! == true {
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                }
            }
            observeVariables()
        }
    }
    
    var values = [Value]()
    func observeVariables(){
        
        
        let ref = FIRDatabase.database().reference().child("Company/-KeLBwQFDwrcMKyiwdDy/Crops").child((variable?.CropId)!).child("Lotes").child((variable?.ParentId)!).child("Variables").child((variable?.Id)!).child("Values")
        ref.keepSynced(true)
        ref.observe(.childAdded, with: { (snapshot) in
            if var dictionary = snapshot.value as? [String:AnyObject]{
                
                if let val = dictionary["Average"] as AnyObject? {
                    dictionary["Date"] = snapshot.key as AnyObject?
                    dictionary["Value"] = val
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let date = dateFormatter.date(from: (self.variable?.StartDate!)!)
                    let valDate = dateFormatter.date(from: "\(snapshot.key) 00:00:00")
                    dateFormatter.dateFormat = "yyyy-MMM-dd"
                    
                   // print(dictionary)
                    if date != nil && valDate != nil {
                        if date! <= valDate! {
                            let value = Value(dictionary: dictionary)
                            self.values.append(value)
                            
                            DispatchQueue.main.async {
                                self.collectionView?.reloadData()
                            }
                        }
                        
                    }
                    
                }
                
            }
        })
        
    }
    
    
    let cellId = "cellId"
    
    lazy var inputContainerView: VariableInfoView = {
        let variableInfoView = VariableInfoView(frame: CGRect(x: 0, y: -500, width: self.view.frame.width, height: 500))
        return variableInfoView
    }()
    
    var swipeUpRecognizer = UISwipeGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addIcon = UIImage(named: "add")!
        let addButton = UIBarButtonItem(image: addIcon,  style: .plain, target: self, action: #selector(handleAddValue))
        
        navigationItem.rightBarButtonItems = [addButton]
        collectionView?.contentInset = UIEdgeInsets(top: 500, left: 0, bottom: 8, right: 0)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(CropLotesCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return values.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CropLotesCell
        
        let value = values[indexPath.row]
        
        if let val = value.Value?.description{
            cell.textLabel.text = "Promedio del día: \(val)"
        }
        
        cell.detailTextLabel.text = value.Date
        
        return cell
    }
    
    var lastIndexPath = IndexPath()
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
    let addValue = AddValue()
    func handleAddValue(){
        addValue.variable = variable
        addValue.showAddValue()
    }
}
