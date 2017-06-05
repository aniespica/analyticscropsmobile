//
//  CropLotesCell.swift
//  analyticscrops
//
//  Created by Veevart on 5/24/17.
//  Copyright © 2017 aniespica. All rights reserved.
//

import UIKit

class CropLotesCell: UICollectionViewCell {
    
    let textContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let deleteButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.red
        view.setTitle("Eliminar", for: UIControlState.normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textLabel: UILabel = {
        let tv = UILabel()
        tv.text = "Some text sample..."
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let detailTextLabel: UILabel = {
        let tv = UILabel()
        tv.text = "Some text sample..."
        tv.font = UIFont.systemFont(ofSize: 12)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textContainerView)
        addSubview(deleteButton)
        
        setupTexts()
        
    }
    
    func setupTexts(){
        
        deleteButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -100).isActive = true
        deleteButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        deleteButton.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        //textContainerView
        //x, y, width, heigth
        textContainerView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        textContainerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textContainerView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        textContainerView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        textContainerView.addSubview(textLabel)
        textContainerView.addSubview(detailTextLabel)
        textContainerView.addSubview(separatorView)
        
        
        textLabel.leftAnchor.constraint(equalTo: textContainerView.leftAnchor, constant:50).isActive = true
        textLabel.topAnchor.constraint(equalTo: textContainerView.topAnchor, constant: 1).isActive = true
        textLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        textLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        detailTextLabel.leftAnchor.constraint(equalTo: textContainerView.leftAnchor, constant:50).isActive = true
        detailTextLabel.topAnchor.constraint(equalTo: textLabel.topAnchor, constant: 20).isActive = true
        detailTextLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        detailTextLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        separatorView.leftAnchor.constraint(equalTo: textContainerView.leftAnchor).isActive = true
        separatorView.topAnchor.constraint(equalTo: textContainerView.bottomAnchor).isActive = true
        separatorView.widthAnchor.constraint(equalTo: textContainerView.widthAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
