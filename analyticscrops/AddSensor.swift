//
//  addSensor.swift
//  analyticscrops
//
//  Created by Veevart on 5/26/17.
//  Copyright © 2017 aniespica. All rights reserved.
//

import UIKit
import Firebase

class AddSensor: NSObject , UITextFieldDelegate {
    
    var lote: Lote? {
        didSet {}
    }
    
    let blackView = UIView()
    
    let editContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        return view
    }()
    
    //title - Crear Lote
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Añadir Sensor"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor(r: 20, g: 46, b: 83)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 119, g: 137, b: 162)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Subtitle - Información
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "  Información"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(r: 20, g: 46, b: 83)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(r: 231, g: 236, b: 244)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(r: 231, g: 236, b: 244).cgColor
        label.layer.cornerRadius = 10
        return label
    }()
    
    //Name
    let nameContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Nombre"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(r: 119, g: 137, b: 162)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameText: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = UIColor(r: 20, g: 46, b: 83)
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(r: 119, g: 137, b: 162).cgColor
        tf.layer.cornerRadius = 5
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    //Serial
    let serialContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let serialTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Serial"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(r: 119, g: 137, b: 162)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let serialText: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = UIColor(r: 20, g: 46, b: 83)
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(r: 119, g: 137, b: 162).cgColor
        tf.layer.cornerRadius = 5
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = UIKeyboardType.numberPad
        return tf
    }()
    
    let saveCropBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(r: 23, g: 121, b: 186)
        btn.tintColor = UIColor.white
        btn.setTitle("Guardar", for: .normal)
        btn.layer.cornerRadius = 5
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let cancelCropBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(r: 186, g: 23, b: 23)
        btn.tintColor = UIColor.white
        btn.setTitle("Cancelar", for: .normal)
        btn.layer.cornerRadius = 5
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    func showAddSensor(){
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.7)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(editContainer)
            
            editContainer.frame = CGRect(x: ( window.frame.width - ( window.frame.width - 200 ) ) / 2, y: ( window.frame.height - 500 ) / 2, width: window.frame.width - 200, height: 500)
            editContainer.alpha = 0
            blackView.frame = window.frame
            blackView.alpha = 0
            
            setupView()
            
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 1
                self.editContainer.alpha = 1
            })
        }
        
        self.cancelCropBtn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        self.saveCropBtn.addTarget(self, action: #selector(handleAddCrop), for: .touchUpInside)
        
    }
    
    let shadowView = UIView()
    
    func handleAddCrop(){
        
        let request = NSMutableURLRequest(url: URL(string:"http://52.17.165.162:8080/upsert/sensor")!)
        
        request.httpMethod = "POST"
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid, let name = self.nameText.text?.description, let serial = self.serialText.text?.description else {
            return
        }
        
        request.addValue("\(uid)", forHTTPHeaderField: "uid")
        
        
        var postSting = "Name=\(name)&Serial=\(serial)&Variable=SoilMoistureReal"
        
        if let cropid = lote?.ParentId {
            postSting = "\(postSting)&Crop=\(cropid)"
        }
        
        if let loteid = lote?.Id {
            postSting = "\(postSting)&Lotes=\(loteid)"
        }
        
        request.httpBody = postSting.data(using: .utf8)
        
        let sendRequest = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            guard error == nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 201 {
                // check for http errors
                print("error")
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            } else {
                print("success")
                DispatchQueue.main.async(execute: {
                    self.handleDismiss()
                })
            }
            
            
        })
        
        sendRequest.resume()
        
    }
    
    func setupView(){
        
        editContainer.addSubview(titleLabel)
        editContainer.addSubview(separatorLine)
        editContainer.addSubview(subtitleLabel)
        editContainer.addSubview(saveCropBtn)
        editContainer.addSubview(cancelCropBtn)
        
        titleLabel.topAnchor.constraint(equalTo: editContainer.topAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: editContainer.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: editContainer.widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        separatorLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        separatorLine.leftAnchor.constraint(equalTo: editContainer.leftAnchor).isActive = true
        separatorLine.widthAnchor.constraint(equalTo: editContainer.widthAnchor).isActive = true
        separatorLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        subtitleLabel.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 10).isActive = true
        subtitleLabel.centerXAnchor.constraint(equalTo: editContainer.centerXAnchor).isActive = true
        subtitleLabel.widthAnchor.constraint(equalTo: editContainer.widthAnchor, constant: -20 ).isActive = true
        subtitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        saveCropBtn.bottomAnchor.constraint(equalTo: editContainer.bottomAnchor, constant: -20).isActive = true
        saveCropBtn.rightAnchor.constraint(equalTo: editContainer.rightAnchor, constant: -20).isActive = true
        saveCropBtn.widthAnchor.constraint(equalToConstant: 90).isActive = true
        saveCropBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        cancelCropBtn.bottomAnchor.constraint(equalTo: editContainer.bottomAnchor, constant: -20).isActive = true
        cancelCropBtn.rightAnchor.constraint(equalTo: saveCropBtn.leftAnchor, constant: -20).isActive = true
        cancelCropBtn.widthAnchor.constraint(equalToConstant: 90).isActive = true
        cancelCropBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //Inputs
        editContainer.addSubview(nameContainerView)
        editContainer.addSubview(serialContainerView)
        
        //Nombre
        nameContainerView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10).isActive = true
        nameContainerView.leftAnchor.constraint(equalTo: editContainer.leftAnchor, constant: 20).isActive = true
        nameContainerView.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        nameContainerView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        nameContainerView.addSubview(nameTextLabel)
        nameContainerView.addSubview(nameText)
        
        nameTextLabel.topAnchor.constraint(equalTo: nameContainerView.topAnchor, constant: 10).isActive = true
        nameTextLabel.leftAnchor.constraint(equalTo: nameContainerView.leftAnchor).isActive = true
        nameTextLabel.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        nameTextLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        nameText.topAnchor.constraint(equalTo: nameTextLabel.bottomAnchor, constant: 10).isActive = true
        nameText.leftAnchor.constraint(equalTo: nameContainerView.leftAnchor).isActive = true
        nameText.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        nameText.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        //Serial
        serialContainerView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10).isActive = true
        serialContainerView.rightAnchor.constraint(equalTo: editContainer.rightAnchor, constant: -20).isActive = true
        serialContainerView.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        serialContainerView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        serialContainerView.addSubview(serialTextLabel)
        serialContainerView.addSubview(serialText)
        
        serialTextLabel.topAnchor.constraint(equalTo: serialContainerView.topAnchor, constant: 10).isActive = true
        serialTextLabel.rightAnchor.constraint(equalTo: serialContainerView.rightAnchor).isActive = true
        serialTextLabel.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        serialTextLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        serialText.topAnchor.constraint(equalTo: serialTextLabel.bottomAnchor, constant: 10).isActive = true
        serialText.rightAnchor.constraint(equalTo: serialContainerView.rightAnchor).isActive = true
        serialText.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        serialText.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
    }
    
    func handleDismiss(){
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            self.editContainer.alpha = 0
            
            self.nameText.text = ""
            self.serialText.text = ""
        }
        
    }
    
    override init() {
        super.init()
    }
}
