//
//  addLote.swift
//  analyticscrops
//
//  Created by Veevart on 5/25/17.
//  Copyright © 2017 aniespica. All rights reserved.
//

import UIKit
import Firebase

class AddLote: NSObject, UITextFieldDelegate{
    
    
    var isEdit = Bool()
    var cropid = String()
    let cellId = "cellId"
    
    var lote: Lote? {
        didSet {
            
            nameText.text = lote?.Name
            startDateText.text = lote?.StartDate
            areaText.text = lote?.Area?.description
            fieldTypeText.text = lote?.FieldType
            fieldCapacityText.text = lote?.FieldCapacity?.description
            laraText.text = lote?.Lara?.description
            cropid = (lote?.ParentId)!
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  "yyyy-MM-dd HH:mm:ss"
            
            let date = dateFormatter.date(from: (lote?.StartDate)!)
            if date != nil {
                dateDatePicker.date = date!
            }
            
            titleLabel.text = "Editar Lote"
            
            isEdit = true
        }
    }
    
    var crop: Crop? {
        didSet {
            cropid = (crop?.Id)!
        }
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
        label.text = "Crear Lote"
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
    
    //Subtitle - Valores iniciales
    let subtitle2Label: UILabel = {
        let label = UILabel()
        label.text = "  Valores Iniciales"
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
    
    //Tipo de Cultivo
    let fieldTypeContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let fieldTypeTextLabel: UILabel = {
        let tv = UILabel()
        tv.text = "Tipo de Campo"
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.textColor = UIColor(r: 119, g: 137, b: 162)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let fieldTypeText: UITextField = {
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
    
    //Init variable
    let initValContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let initValTextLabel: UILabel = {
        let tv = UILabel()
        tv.text = "Humedad del suelo"
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.textColor = UIColor(r: 119, g: 137, b: 162)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let initValText: UITextField = {
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
    
    func showAddLote(){
        
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
        self.initValText.delegate = self
        self.startDateText.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDate)))
        self.addDateBtn.addTarget(self, action: #selector(handleAddDate), for: .touchUpInside)
        self.cancelCropBtn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        self.saveCropBtn.addTarget(self, action: #selector(handleAddCrop), for: .touchUpInside)
        
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
        
        let request = NSMutableURLRequest(url: URL(string:"http://52.17.165.162:8080/upsert/lote")!)
        
        request.httpMethod = "POST"
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid, let name = self.nameText.text?.description else {
            return
        }
        
        request.addValue("\(uid)", forHTTPHeaderField: "uid")
        
        var fcNumb = NSNumber()
        if let fcInt = Int((self.fieldCapacityText.text)!) {
            fcNumb = NSNumber(value:fcInt)
        }
        
        var laraNumb = NSNumber()
        if let laraInt = Int((self.laraText.text)!) {
            laraNumb = NSNumber(value:laraInt)
        }
        
        var areaNumb = NSNumber()
        if let areaInt = Int((self.areaText.text)!) {
            areaNumb = NSNumber(value:areaInt)
        }
        
        guard let startDate = self.startDateText.text, let fieldType = self.fieldTypeText.text else {
            return print("miss")
        }
        
        
        var postSting = "Name=\(name)&StartDate=\(startDate)&FieldType=\(fieldType)&FieldCapacity=\(fcNumb)&Lara=\(laraNumb)&Area=\(areaNumb)&cropid=\(cropid)"
        
        if let initVal = self.initValText.text{
            postSting = "\(postSting)&initVal=\(initVal)"
        }

        if isEdit {
            
            guard let loteid = lote?.Id else {
                return print("no id")
            }
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
        editContainer.addSubview(subtitle2Label)
        
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
        editContainer.addSubview(fieldTypeContainerView)
        editContainer.addSubview(laraContainerView)
        editContainer.addSubview(startDateContainerView)
        editContainer.addSubview(fieldCapacityContainerView)
        editContainer.addSubview(initValContainerView)
        
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
        fieldTypeContainerView.topAnchor.constraint(equalTo: nameContainerView.bottomAnchor, constant: 10).isActive = true
        fieldTypeContainerView.leftAnchor.constraint(equalTo: editContainer.leftAnchor, constant: 20).isActive = true
        fieldTypeContainerView.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        fieldTypeContainerView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        fieldTypeContainerView.addSubview(fieldTypeTextLabel)
        fieldTypeContainerView.addSubview(fieldTypeText)
        
        fieldTypeTextLabel.topAnchor.constraint(equalTo: fieldTypeContainerView.topAnchor, constant: 10).isActive = true
        fieldTypeTextLabel.leftAnchor.constraint(equalTo: fieldTypeContainerView.leftAnchor).isActive = true
        fieldTypeTextLabel.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        fieldTypeTextLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        fieldTypeText.topAnchor.constraint(equalTo: fieldTypeTextLabel.bottomAnchor, constant: 10).isActive = true
        fieldTypeText.leftAnchor.constraint(equalTo: fieldTypeContainerView.leftAnchor).isActive = true
        fieldTypeText.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        fieldTypeText.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        //LARA
        laraContainerView.topAnchor.constraint(equalTo: fieldTypeContainerView.bottomAnchor, constant: 10).isActive = true
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
        
        
        //Area
        areaContainerView.topAnchor.constraint(equalTo: startDateContainerView.bottomAnchor, constant: 10).isActive = true
        areaContainerView.rightAnchor.constraint(equalTo: editContainer.rightAnchor, constant: -20).isActive = true
        areaContainerView.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        areaContainerView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        areaContainerView.addSubview(areaTextLabel)
        areaContainerView.addSubview(areaText)
        
        areaTextLabel.topAnchor.constraint(equalTo: areaContainerView.topAnchor, constant: 10).isActive = true
        areaTextLabel.rightAnchor.constraint(equalTo: areaContainerView.rightAnchor).isActive = true
        areaTextLabel.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        areaTextLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        areaText.topAnchor.constraint(equalTo: areaTextLabel.bottomAnchor, constant: 10).isActive = true
        areaText.rightAnchor.constraint(equalTo: areaContainerView.rightAnchor).isActive = true
        areaText.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        areaText.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        //Capacidad de campo
        fieldCapacityContainerView.topAnchor.constraint(equalTo: areaContainerView.bottomAnchor, constant: 10).isActive = true
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
        
        //Subtitle2
        subtitle2Label.topAnchor.constraint(equalTo: laraContainerView.bottomAnchor, constant: 10).isActive = true
        subtitle2Label.centerXAnchor.constraint(equalTo: editContainer.centerXAnchor).isActive = true
        subtitle2Label.widthAnchor.constraint(equalTo: editContainer.widthAnchor, constant: -20 ).isActive = true
        subtitle2Label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //Init Variable
        initValContainerView.topAnchor.constraint(equalTo: subtitle2Label.bottomAnchor, constant: 10).isActive = true
        initValContainerView.leftAnchor.constraint(equalTo: editContainer.leftAnchor, constant: 20).isActive = true
        initValContainerView.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        initValContainerView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        initValContainerView.addSubview(initValTextLabel)
        initValContainerView.addSubview(initValText)
        
        initValTextLabel.topAnchor.constraint(equalTo: initValContainerView.topAnchor, constant: 10).isActive = true
        initValTextLabel.leftAnchor.constraint(equalTo: initValContainerView.leftAnchor).isActive = true
        initValTextLabel.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        initValTextLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        initValText.topAnchor.constraint(equalTo: initValTextLabel.bottomAnchor, constant: 10).isActive = true
        initValText.leftAnchor.constraint(equalTo: initValContainerView.leftAnchor).isActive = true
        initValText.widthAnchor.constraint(equalTo: editContainer.widthAnchor, multiplier: 0.5, constant: -40).isActive = true
        initValText.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
    }
    
    func handleDismiss(){
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            self.editContainer.alpha = 0
            
            self.fieldCapacityText.text = ""
            self.fieldTypeText.text = ""
            self.startDateText.text = ""
            self.nameText.text = ""
            self.laraText.text = ""
            self.areaText.text = ""
        }
        
    }
    
    override init() {
        super.init()
    }
    
}
