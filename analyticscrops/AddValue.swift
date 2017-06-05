//
//  addValue.swift
//  analyticscrops
//
//  Created by Veevart on 5/26/17.
//  Copyright © 2017 aniespica. All rights reserved.
//

import UIKit
import Firebase

class AddValue: NSObject, UITextFieldDelegate {
    
   var variable: Variable? {
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
        label.text = "Añadir Valor"
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
    let valueContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let valueTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Valor"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(r: 119, g: 137, b: 162)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let valueText: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = UIColor(r: 20, g: 46, b: 83)
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(r: 119, g: 137, b: 162).cgColor
        tf.layer.cornerRadius = 5
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = UIKeyboardType.numbersAndPunctuation
        return tf
    }()
    
    //Fecha de inicio
    let startDateContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let startDateTextLabel: UILabel = {
        let tv = UILabel()
        tv.text = "Fecha de Inicio"
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.textColor = UIColor(r: 119, g: 137, b: 162)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var startDateText: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = UIColor(r: 20, g: 46, b: 83)
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(r: 119, g: 137, b: 162).cgColor
        tf.layer.cornerRadius = 5
        tf.translatesAutoresizingMaskIntoConstraints = false
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
    
    func showAddValue(){
        
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
        
        self.valueText.delegate = self
        self.startDateText.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDate)))
        self.addDateBtn.addTarget(self, action: #selector(handleAddDate), for: .touchUpInside)
        self.cancelCropBtn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        self.saveCropBtn.addTarget(self, action: #selector(handleAddValue), for: .touchUpInside)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if Double(textField.text!) != nil && string == "."  {
            if textField.text?.range(of: ".") != nil {
                return false
            }
            return true
        }
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    let shadowView = UIView()
    
    let dateDatePicker: UIDatePicker = {
        let date = UIDatePicker()
        date.layer.borderWidth = 1.0
        date.layer.borderColor = UIColor(r:202, g:202, b:202).cgColor
        date.layer.cornerRadius = 5.0
        date.backgroundColor = UIColor.white
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    let addDateBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(r: 23, g: 121, b: 186)
        btn.tintColor = UIColor.white
        btn.setTitle("Añadir", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let cancelDateBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(r: 186, g: 23, b: 23)
        btn.tintColor = UIColor.white
        btn.setTitle("Cancelar", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    func handleDate(){
        
        if let window = UIApplication.shared.keyWindow {
            
            shadowView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            window.addSubview(shadowView)
            shadowView.alpha = 0
            shadowView.frame = window.frame
            
            window.addSubview(dateDatePicker)
            window.addSubview(addDateBtn)
            window.addSubview(cancelDateBtn)
            
            dateDatePicker.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
            dateDatePicker.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
            dateDatePicker.widthAnchor.constraint(equalTo: window.widthAnchor, constant:-200).isActive = true
            dateDatePicker.heightAnchor.constraint(equalToConstant: 200).isActive = true
            
            addDateBtn.topAnchor.constraint(equalTo: dateDatePicker.bottomAnchor).isActive = true
            addDateBtn.rightAnchor.constraint(equalTo: dateDatePicker.rightAnchor).isActive = true
            addDateBtn.widthAnchor.constraint(equalTo: dateDatePicker.widthAnchor, multiplier: 0.5).isActive = true
            addDateBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            cancelDateBtn.topAnchor.constraint(equalTo: dateDatePicker.bottomAnchor).isActive = true
            cancelDateBtn.leftAnchor.constraint(equalTo: dateDatePicker.leftAnchor).isActive = true
            cancelDateBtn.widthAnchor.constraint(equalTo: dateDatePicker.widthAnchor, multiplier: 0.5).isActive = true
            cancelDateBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            //actions
            shadowView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissDate)))
            cancelDateBtn.addTarget(self, action: #selector(handleDismissDate), for: .touchUpInside)
            dateDatePicker.alpha = 0
            cancelDateBtn.alpha = 0
            addDateBtn.alpha = 0
            UIView.animate(withDuration: 0.5, animations: {
                self.shadowView.alpha = 1
                self.dateDatePicker.alpha = 1
                self.cancelDateBtn.alpha = 1
                self.addDateBtn.alpha = 1
            })
            
            
        }
    }
    
    func handleAddValue(){
        
        let request = NSMutableURLRequest(url: URL(string:"http://52.17.165.162:8080/upsert/value")!)
        
        request.httpMethod = "POST"
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid, let value = self.valueText.text?.description, let startDate = self.startDateText.text else {
            return
        }
        
        request.addValue("\(uid)", forHTTPHeaderField: "uid")
        
        var postSting = "Value=\(value)&StringDate=\(startDate)"
        
        if let varid = variable?.Id {
            postSting = "\(postSting)&varid=\(varid)"
        }
        
        if let cropid = variable?.CropId {
            postSting = "\(postSting)&cropid=\(cropid)"
        }
        
        if let loteid = variable?.ParentId {
            postSting = "\(postSting)&loteid=\(loteid)"
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
    
    func handleAddDate(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        startDateText.text = "\(dateFormatter.string(from: dateDatePicker.date)) 00:00:00"
        self.handleDismissDate()
    }
    
    func handleDismissDate(){
        UIView.animate(withDuration: 0.5) {
            self.shadowView.alpha = 0
            self.dateDatePicker.alpha = 0
            self.cancelDateBtn.alpha = 0
            self.addDateBtn.alpha = 0
        }
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
        editContainer.addSubview(valueContainerView)
        editContainer.addSubview(startDateContainerView)
        
        //Nombre
        valueContainerView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10).isActive = true
        valueContainerView.leftAnchor.constraint(equalTo: editContainer.leftAnchor, constant: 20).isActive = true
        valueContainerView.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        valueContainerView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        valueContainerView.addSubview(valueTextLabel)
        valueContainerView.addSubview(valueText)
        
        valueTextLabel.topAnchor.constraint(equalTo: valueContainerView.topAnchor, constant: 10).isActive = true
        valueTextLabel.leftAnchor.constraint(equalTo: valueContainerView.leftAnchor).isActive = true
        valueTextLabel.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        valueTextLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        valueText.topAnchor.constraint(equalTo: valueTextLabel.bottomAnchor, constant: 10).isActive = true
        valueText.leftAnchor.constraint(equalTo: valueContainerView.leftAnchor).isActive = true
        valueText.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        valueText.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        //Fecha de inicio
        startDateContainerView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10).isActive = true
        startDateContainerView.rightAnchor.constraint(equalTo: editContainer.rightAnchor, constant: -20).isActive = true
        startDateContainerView.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        startDateContainerView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        startDateContainerView.addSubview(startDateTextLabel)
        startDateContainerView.addSubview(startDateText)
        
        startDateTextLabel.topAnchor.constraint(equalTo: startDateContainerView.topAnchor, constant: 10).isActive = true
        startDateTextLabel.rightAnchor.constraint(equalTo: startDateContainerView.rightAnchor).isActive = true
        startDateTextLabel.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        startDateTextLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        startDateText.topAnchor.constraint(equalTo: startDateTextLabel.bottomAnchor, constant: 10).isActive = true
        startDateText.rightAnchor.constraint(equalTo: startDateContainerView.rightAnchor).isActive = true
        startDateText.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        startDateText.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
    }
    
    func handleDismiss(){
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            self.editContainer.alpha = 0
            
            self.startDateText.text = ""
            self.valueText.text = ""
        }
        
    }
    
    override init() {
        super.init()
    }
    
}
