//
//  CollectionCropController.swift
//  analyticscrops
//
//  Created by Veevart on 5/21/17.
//  Copyright © 2017 aniespica. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class CollectionLoteController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate{
    
    var startObserve = true
    var lote: Lote? {
        didSet {
            navigationItem.title = lote?.Name
            inputContainerView.lote = lote
            collectionView?.addSubview(inputContainerView)
            
            if startObserve == true {
                observeVariables()
                observeChange()
            }
            
            startObserve = false
            
        }
    }
    
    func observeChange(){
        
        let lotesRef = FIRDatabase.database().reference().child("Company/-KeLBwQFDwrcMKyiwdDy/Crops/\((lote?.ParentId)!)/Lotes")
        lotesRef.keepSynced(true)
        lotesRef.observe(.childChanged, with: { (snapshot) in
            if self.lote?.Id == snapshot.key {
                if var dictionary = snapshot.value as? [String:AnyObject]{
                    dictionary["ParentId"] = self.lote?.ParentId as AnyObject?
                    dictionary["Id"] = snapshot.key as AnyObject?
                    self.lote = Lote(dictionary: dictionary)
                
                    DispatchQueue.main.async {
                        self.inputContainerView.lote = self.lote
                    }
                }
            }
        })
        
    }
    
    var vars = [Variable]()
    func observeVariables(){
        
        let lotesRef = FIRDatabase.database().reference().child("Company/-KeLBwQFDwrcMKyiwdDy/Crops").child((lote?.ParentId)!).child("Lotes").child((lote?.Id)!).child("Variables")
        lotesRef.keepSynced(true)
        lotesRef.observe(.childAdded, with: { (snapshot) in
            
            if var dictionary = snapshot.value as? [String:AnyObject]{
                dictionary["ParentId"] = self.lote?.Id as AnyObject?
                dictionary["CropId"] = self.lote?.ParentId as AnyObject?
                dictionary["Id"] = snapshot.key as AnyObject?
                dictionary["StartDate"] = self.lote?.StartDate as AnyObject?
                //print(dictionary)
                let variable = Variable(dictionary: dictionary)
                self.vars.append(variable)
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        })
        
    }
    
    
    let cellId = "cellId"
    
    lazy var inputContainerView: LoteInfoView = {
        let loteInfoView = LoteInfoView(frame: CGRect(x: 0, y: -500, width: self.view.frame.width, height: 500))
        
        return loteInfoView
    }()
    
    var swipeUpRecognizer = UISwipeGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let editIcon = UIImage(named: "edit")
        let addIcon = UIImage(named: "add")!
        
        let editButton   = UIBarButtonItem(image: editIcon,  style: .plain, target: self, action: #selector(handleEdit))
        let addButton = UIBarButtonItem(image: addIcon,  style: .plain, target: self, action: #selector(handleAddSensor))
        
        navigationItem.rightBarButtonItems = [addButton, editButton]
        collectionView?.contentInset = UIEdgeInsets(top: 500, left: 0, bottom: 8, right: 0)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(CropLotesCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vars.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CropLotesCell
        
        let variable = vars[indexPath.row]
        
        cell.textLabel.text = variable.Name
        cell.detailTextLabel.text = variable.DetailText

        return cell
    }
    
    var lastIndexPath = IndexPath()
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("open variable")
        let variable = self.vars[indexPath.row]
        self.showLoteController(variable)
    }
    
    func showLoteController(_ variable: Variable){
        let collectionVariableController = CollectionVariableController(collectionViewLayout: UICollectionViewFlowLayout())
        collectionVariableController.variable = variable
        navigationController?.pushViewController(collectionVariableController, animated: true)
    }
    
    
    let addSensor = AddSensor()
    let addLote = AddLote()
    
    func handleEdit(){
        addLote.lote = lote
        addLote.showAddLote()
    }
    
    func handleAddSensor(){
        addSensor.lote = lote
        addSensor.showAddSensor()
    }
    
}

