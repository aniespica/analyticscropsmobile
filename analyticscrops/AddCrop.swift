//
//  AddCrop.swift
//  analyticscrops
//
//  Created by Veevart on 5/25/17.
//  Copyright © 2017 aniespica. All rights reserved.
//

import UIKit
import Firebase

class AddCrop: NSObject, UITextFieldDelegate {
    
    
    var isEdit = Bool()
    
    var crop: Crop? {
        didSet {
            
            nameText.text = crop?.Name
            startDateText.text = crop?.StartDate
            cropVarietyText.text = crop?.CropVariety
            irrigationTypeText.text = crop?.IrrigationType
            fieldCapacityText.text = crop?.FieldCapacity?.description
            laraText.text = crop?.Lara?.description
            areaText.text = crop?.Area?.description
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  "yyyy-MM-dd HH:mm:ss"
            
            let date = dateFormatter.date(from: (crop?.StartDate)!)
            if date != nil {
                dateDatePicker.date = date!
            }
            
            if let isCheck = crop?.isCalculate {
                isCalculateText.isChecked = isCheck
            }
            
            titleLabel.text = "Editar Cultivo"
            
            isEdit = true
        }
    }
    
    let blackView = UIView()
    
    let editContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        return view
    }()
    
    //title - Crear Cultivo
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Crear Cultivo"
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
    
    //Area
    let areaContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let areaTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Area del Cultivo"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(r: 119, g: 137, b: 162)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let areaText: UITextField = {
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
    
    //Variedad de cultivo
    
    let cropVarietyContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cropVarietyTextLabel: UILabel = {
        let tv = UILabel()
        tv.text = "Variedad de Cultivo"
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.textColor = UIColor(r: 119, g: 137, b: 162)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let cropVarietyText: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = UIColor(r: 20, g: 46, b: 83)
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(r: 119, g: 137, b: 162).cgColor
        tf.layer.cornerRadius = 5
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    //Capacidad de campo
    let fieldCapacityContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let fieldCapacityTextLabel: UILabel = {
        let tv = UILabel()
        tv.text = "Capacidad de Campo"
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.textColor = UIColor(r: 119, g: 137, b: 162)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let fieldCapacityText: UITextField = {
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
    
    //Tipo de riego
    let irrigationTypeContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let irrigationTypeTextLabel: UILabel = {
        let tv = UILabel()
        tv.text = "Tipo de Riego"
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.textColor = UIColor(r: 119, g: 137, b: 162)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let irrigationTypeText: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = UIColor(r: 20, g: 46, b: 83)
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(r: 119, g: 137, b: 162).cgColor
        tf.layer.cornerRadius = 5
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    //Lara
    let laraContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let laraTextLabel: UILabel = {
        let tv = UILabel()
        tv.text = "LARA"
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.textColor = UIColor(r: 119, g: 137, b: 162)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let laraText: UITextField = {
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
    
    //Se calcula los valores
    let isCalculateContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let isCalculateTextLabel: UILabel = {
        let tv = UILabel()
        tv.text = "Se Calcula los Valores"
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.textColor = UIColor(r: 119, g: 137, b: 162)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let isCalculateText: CheckBox = {
        let tv = CheckBox(frame: CGRect(x: 0, y: 0, width: 200, height: 190))
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
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
    
    func showAddCrop(){
        
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
        
        self.areaText.delegate = self
        self.laraText.delegate = self
        self.fieldCapacityText.delegate = self
        self.startDateText.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDate)))
        self.isCalculateText.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleIsCalculate)))
        self.addDateBtn.addTarget(self, action: #selector(handleAddDate), for: .touchUpInside)
        self.cancelCropBtn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        self.saveCropBtn.addTarget(self, action: #selector(handleAddCrop), for: .touchUpInside)
        
    }
    
    func handleIsCalculate(){
        let isCalculate = isCalculateText.isChecked
        if  isCalculate {
            areaText.isUserInteractionEnabled = true
            areaText.backgroundColor = UIColor.white
            laraText.isUserInteractionEnabled = true
            laraText.backgroundColor = UIColor.white
            fieldCapacityText.isUserInteractionEnabled = true
            fieldCapacityText.backgroundColor = UIColor.white
            isCalculateText.isChecked = false
        } else {
            areaText.isUserInteractionEnabled = false
            areaText.backgroundColor = UIColor.lightGray
            laraText.isUserInteractionEnabled = false
            laraText.backgroundColor = UIColor.lightGray
            fieldCapacityText.isUserInteractionEnabled = false
            fieldCapacityText.backgroundColor = UIColor.lightGray
            isCalculateText.isChecked = true
        }
        
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
    
    func handleAddCrop(){
        
        let request = NSMutableURLRequest(url: URL(string:"http://52.17.165.162:8080/add/crop")!)
    
        request.httpMethod = "POST"
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid, let name = self.nameText.text?.description else {
            return
        }
        
        request.addValue("\(uid)", forHTTPHeaderField: "uid")
        
        
        
        guard let startDate = self.startDateText.text, let cropVariety = self.cropVarietyText.text, let IrrigationType = self.irrigationTypeText.text else {
            return print("miss")
        }
        
       var postSting = "Name=\(name)&StartDate=\(startDate)&CropVariety=\(cropVariety)&IrrigationType=\(IrrigationType)&isCalculate=\(self.isCalculateText.isChecked)"
        
        if let FieldCapacity = self.fieldCapacityText.text {
            postSting = "\(postSting)&FieldCapacity=\(FieldCapacity)"
        }
        
        if let Lara = self.laraText.text {
            postSting = "\(postSting)&Lara=\(Lara)"
        }
        
        if let Area = self.areaText.text {
            postSting = "\(postSting)&FieldCapacity=\(Area)"
        }
        
        if isEdit, let cropid = crop?.Id {
            
//            guard let cropid = crop?.Id else {
//                return print("no id")
//            }
            postSting = "\(postSting)&cropid=\(cropid)"
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
        editContainer.addSubview(nameContainerView)
        editContainer.addSubview(areaContainerView)
        editContainer.addSubview(irrigationTypeContainerView)
        editContainer.addSubview(laraContainerView)
        editContainer.addSubview(startDateContainerView)
        editContainer.addSubview(cropVarietyContainerView)
        editContainer.addSubview(fieldCapacityContainerView)
        editContainer.addSubview(isCalculateContainerView)
        
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
        
        //Tipo de riego
        irrigationTypeContainerView.topAnchor.constraint(equalTo: nameContainerView.bottomAnchor, constant: 10).isActive = true
        irrigationTypeContainerView.leftAnchor.constraint(equalTo: editContainer.leftAnchor, constant: 20).isActive = true
        irrigationTypeContainerView.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        irrigationTypeContainerView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        irrigationTypeContainerView.addSubview(irrigationTypeTextLabel)
        irrigationTypeContainerView.addSubview(irrigationTypeText)
        
        irrigationTypeTextLabel.topAnchor.constraint(equalTo: irrigationTypeContainerView.topAnchor, constant: 10).isActive = true
        irrigationTypeTextLabel.leftAnchor.constraint(equalTo: irrigationTypeContainerView.leftAnchor).isActive = true
        irrigationTypeTextLabel.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        irrigationTypeTextLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        irrigationTypeText.topAnchor.constraint(equalTo: irrigationTypeTextLabel.bottomAnchor, constant: 10).isActive = true
        irrigationTypeText.leftAnchor.constraint(equalTo: irrigationTypeContainerView.leftAnchor).isActive = true
        irrigationTypeText.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        irrigationTypeText.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        //LARA
        laraContainerView.topAnchor.constraint(equalTo: irrigationTypeContainerView.bottomAnchor, constant: 10).isActive = true
        laraContainerView.leftAnchor.constraint(equalTo: editContainer.leftAnchor, constant: 20).isActive = true
        laraContainerView.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        laraContainerView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        laraContainerView.addSubview(laraTextLabel)
        laraContainerView.addSubview(laraText)
        
        laraTextLabel.topAnchor.constraint(equalTo: laraContainerView.topAnchor, constant: 10).isActive = true
        laraTextLabel.leftAnchor.constraint(equalTo: laraContainerView.leftAnchor).isActive = true
        laraTextLabel.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        laraTextLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        laraText.topAnchor.constraint(equalTo: laraTextLabel.bottomAnchor, constant: 10).isActive = true
        laraText.leftAnchor.constraint(equalTo: laraContainerView.leftAnchor).isActive = true
        laraText.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        laraText.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        //Area
        areaContainerView.topAnchor.constraint(equalTo: laraContainerView.bottomAnchor, constant: 10).isActive = true
        areaContainerView.leftAnchor.constraint(equalTo: editContainer.leftAnchor, constant: 20).isActive = true
        areaContainerView.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        areaContainerView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        areaContainerView.addSubview(areaTextLabel)
        areaContainerView.addSubview(areaText)
        
        areaTextLabel.topAnchor.constraint(equalTo: areaContainerView.topAnchor, constant: 10).isActive = true
        areaTextLabel.leftAnchor.constraint(equalTo: areaContainerView.leftAnchor).isActive = true
        areaTextLabel.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        areaTextLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        areaText.topAnchor.constraint(equalTo: areaTextLabel.bottomAnchor, constant: 10).isActive = true
        areaText.leftAnchor.constraint(equalTo: areaContainerView.leftAnchor).isActive = true
        areaText.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        areaText.heightAnchor.constraint(equalToConstant: 35).isActive = true

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
        
        //Variedad de cultivo
        cropVarietyContainerView.topAnchor.constraint(equalTo: startDateContainerView.bottomAnchor, constant: 10).isActive = true
        cropVarietyContainerView.rightAnchor.constraint(equalTo: editContainer.rightAnchor, constant: -20).isActive = true
        cropVarietyContainerView.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        cropVarietyContainerView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        cropVarietyContainerView.addSubview(cropVarietyTextLabel)
        cropVarietyContainerView.addSubview(cropVarietyText)
        
        cropVarietyTextLabel.topAnchor.constraint(equalTo: cropVarietyContainerView.topAnchor, constant: 10).isActive = true
        cropVarietyTextLabel.rightAnchor.constraint(equalTo: cropVarietyContainerView.rightAnchor).isActive = true
        cropVarietyTextLabel.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        cropVarietyTextLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        cropVarietyText.topAnchor.constraint(equalTo: cropVarietyTextLabel.bottomAnchor, constant: 10).isActive = true
        cropVarietyText.rightAnchor.constraint(equalTo: cropVarietyContainerView.rightAnchor).isActive = true
        cropVarietyText.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        cropVarietyText.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        //Capacidad de campo
        fieldCapacityContainerView.topAnchor.constraint(equalTo: cropVarietyContainerView.bottomAnchor, constant: 10).isActive = true
        fieldCapacityContainerView.rightAnchor.constraint(equalTo: editContainer.rightAnchor, constant: -20).isActive = true
        fieldCapacityContainerView.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        fieldCapacityContainerView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        fieldCapacityContainerView.addSubview(fieldCapacityTextLabel)
        fieldCapacityContainerView.addSubview(fieldCapacityText)
        
        fieldCapacityTextLabel.topAnchor.constraint(equalTo: fieldCapacityContainerView.topAnchor, constant: 10).isActive = true
        fieldCapacityTextLabel.rightAnchor.constraint(equalTo: fieldCapacityContainerView.rightAnchor).isActive = true
        fieldCapacityTextLabel.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        fieldCapacityTextLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        fieldCapacityText.topAnchor.constraint(equalTo: fieldCapacityTextLabel.bottomAnchor, constant: 10).isActive = true
        fieldCapacityText.rightAnchor.constraint(equalTo: fieldCapacityContainerView.rightAnchor).isActive = true
        fieldCapacityText.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        fieldCapacityText.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        //Calcular
        isCalculateContainerView.topAnchor.constraint(equalTo: fieldCapacityContainerView.bottomAnchor, constant: 10).isActive = true
        isCalculateContainerView.rightAnchor.constraint(equalTo: editContainer.rightAnchor, constant: -20).isActive = true
        isCalculateContainerView.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        isCalculateContainerView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        isCalculateContainerView.addSubview(isCalculateTextLabel)
        isCalculateContainerView.addSubview(isCalculateText)
        
        isCalculateTextLabel.topAnchor.constraint(equalTo: isCalculateContainerView.topAnchor, constant: 10).isActive = true
        isCalculateTextLabel.rightAnchor.constraint(equalTo: isCalculateContainerView.rightAnchor).isActive = true
        isCalculateTextLabel.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        isCalculateTextLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        isCalculateText.topAnchor.constraint(equalTo: isCalculateTextLabel.bottomAnchor, constant: 10).isActive = true
        isCalculateText.leftAnchor.constraint(equalTo: isCalculateContainerView.leftAnchor).isActive = true
        isCalculateText.widthAnchor.constraint(equalToConstant: 50).isActive = true
        isCalculateText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    func handleDismiss(){
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            self.editContainer.alpha = 0
            
            self.isCalculateText.isChecked = false
            self.fieldCapacityText.text = ""
            self.cropVarietyText.text = ""
            self.startDateText.text = ""
            self.nameText.text = ""
            self.laraText.text = ""
            self.areaText.text = ""
            self.irrigationTypeText.text = ""
        }
        
    }
    
    override init() {
        super.init()
    }

}
