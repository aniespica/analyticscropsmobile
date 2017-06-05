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

class CollectionCropController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate{
    
    var startObserve = true
    var crop: Crop? {
        didSet {
            navigationItem.title = crop?.Name
            inputContainerView.crop = crop
            collectionView?.addSubview(inputContainerView)
            
            if startObserve == true {
                observeLotes()
                obserChange()
            }
            
            startObserve = false
            
        }
    }
    
    
    func obserChange() {
        
        let ref = FIRDatabase.database().reference().child("Company/-KeLBwQFDwrcMKyiwdDy/Crops/")
        ref.observe(.childChanged, with: { (snapshot) in
            if self.crop?.Id == snapshot.key {
                if var dictionary = snapshot.value as? [String:AnyObject]{
                    dictionary["Id"] = snapshot.key as AnyObject?
                    self.crop = Crop(dictionary: dictionary)
                    DispatchQueue.main.async {
                        self.inputContainerView.crop = self.crop
                    }
                }
            }
        })
        
    }
    
    var lotes = [Lote]()
    func observeLotes(){
        
        let lotesRef = FIRDatabase.database().reference().child("Company/-KeLBwQFDwrcMKyiwdDy/Crops/\((crop?.Id)!)/Lotes")
        lotesRef.keepSynced(true)
        lotesRef.observe(.childAdded, with: { (snapshot) in
            
            if var dictionary = snapshot.value as? [String:AnyObject]{
                dictionary["ParentId"] = self.crop?.Id as AnyObject?
                dictionary["Id"] = snapshot.key as AnyObject?
                let lote = Lote(dictionary: dictionary)
                self.lotes.append(lote)
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        })
        
    }
    
    
    let cellId = "cellId"
    
    lazy var inputContainerView: CropInfoView = {
        let cropInfoView = CropInfoView(frame: CGRect(x: 0, y: -500, width: self.view.frame.width, height: 500))
        return cropInfoView
    }()
    
    var swipeUpRecognizer = UISwipeGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let editIcon = UIImage(named: "edit")
        let addIcon = UIImage(named: "add")!
        
        let editButton   = UIBarButtonItem(image: editIcon,  style: .plain, target: self, action: #selector(handleEdit))
        let addButton = UIBarButtonItem(image: addIcon,  style: .plain, target: self, action: #selector(handleAddLote))
        
        navigationItem.rightBarButtonItems = [addButton, editButton]
        collectionView?.contentInset = UIEdgeInsets(top: 500, left: 0, bottom: 8, right: 0)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(CropLotesCell.self, forCellWithReuseIdentifier: cellId)
    
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lotes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CropLotesCell
        
        let lote = lotes[indexPath.row]
        
        cell.textLabel.text = lote.Name
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: lote.StartDate!)
        dateFormatter.dateFormat = "yyyy MMM dd HH:mm"
        
        if date != nil {
            let dateText = dateFormatter.string(from: date!)
            
            cell.detailTextLabel.text = dateText
        }
        
        let swipeRight = UIPanGestureRecognizer(target: self, action: #selector(CollectionCropController.handleTap(recognizer:)))
        swipeRight.delegate = self
        
        cell.addGestureRecognizer(swipeRight)
        
        return cell
    }
    
    var lastIndexPath = IndexPath()
    
    func handleTap(recognizer: UIPanGestureRecognizer) {
        
        
        let point = recognizer.location(in: self.collectionView)
        let indexpath = self.collectionView?.indexPathForItem(at: point)
        
        if indexpath == nil{ return }
        
        guard let cell = self.collectionView?.cellForItem(at: indexpath!) as? CropLotesCell else{
            
            return
            
        }
        
        switch recognizer.state {
        case .began:
            print("began")
            print(point)
            
        case .changed:
            
            print("changed")
            print(point)
            
        case .cancelled:
            print("cancelled")
            
        case .ended:
            print("ended")
            print(point)
            
            cell.deleteButton.translatesAutoresizingMaskIntoConstraints = false
            
            cell.textContainerView.translatesAutoresizingMaskIntoConstraints = false
            
            if cell.textContainerView.leftAnchor.constraint(equalTo: (collectionView?.leftAnchor)!).constant > cell.deleteButton.leftAnchor.constraint(equalTo: (self.collectionView?.leftAnchor)!).constant {
            
            }else{
                
                UIView.animate(withDuration: 0.5, animations:{
                    cell.textContainerView.leftAnchor.constraint(equalTo: (self.collectionView?.leftAnchor)!, constant: point.x).isActive = true
                    cell.deleteButton.leftAnchor.constraint(equalTo: (self.collectionView?.leftAnchor)!).isActive = true
                    self.view.layoutIfNeeded()
                })
            
            }
            
        default:
            print("default")
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lote = self.lotes[indexPath.row]
        self.showLoteController(lote)
    }
    
    func showLoteController(_ lote: Lote){
        let collectionLoteController = CollectionLoteController(collectionViewLayout: UICollectionViewFlowLayout())
        collectionLoteController.lote = lote
        navigationController?.pushViewController(collectionLoteController, animated: true)
    }
    
    
    let addCrop = AddCrop()
    let addLote = AddLote()

    func handleEdit(){
        addCrop.crop = crop
        addCrop.showAddCrop()
    }
    
    func handleAddLote(){
        addLote.crop = crop
        addLote.showAddLote()
    }

}

class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "checked")! as UIImage
    let uncheckedImage = UIImage(named: "unchecked")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: Selector(("buttonClicked:")), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
