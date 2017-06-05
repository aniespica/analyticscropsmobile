//
//  VariableInfoView.swift
//  analyticscrops
//
//  Created by Veevart on 5/26/17.
//  Copyright © 2017 aniespica. All rights reserved.
//

import UIKit
import Firebase
import Charts

class VariableInfoView: UIView {
    
    var variable: Variable? {
        didSet {
            observeValues()
        }
    }
    
    var values = [Value]()
    var valuesDictionary = [String: Value]()
    func observeValues(){
        
        let ref = FIRDatabase.database().reference().child("Company/-KeLBwQFDwrcMKyiwdDy/Crops").child((variable?.CropId)!).child("Lotes").child((variable?.ParentId)!).child("Variables").child((variable?.Id)!).child("Values")
        ref.keepSynced(true)
        ref.observe(.childAdded, with: { (snapshot) in
            if var dictionary = snapshot.value as? [String:AnyObject]{
                
                if let val = dictionary["Average"] as AnyObject? {
                    dictionary["Date"] = snapshot.key as AnyObject?
                    dictionary["Value"] = val
                    let value = Value(dictionary: dictionary)
                    self.valuesDictionary[snapshot.key] = value
                
                    DispatchQueue.main.async {
                        self.updateChartWithData()
                    }
                }
                
            }
        })
        
        ref.observe(.childChanged, with: { (snapshot) in
            if var dictionary = snapshot.value as? [String:AnyObject]{
                
                if let val = dictionary["Average"] as AnyObject? {
                    dictionary["Date"] = snapshot.key as AnyObject?
                    dictionary["Value"] = val
                    let value = Value(dictionary: dictionary)
                    self.valuesDictionary[snapshot.key] = value
                    self.valuesDictionary.updateValue(value, forKey: snapshot.key)
                    
                    DispatchQueue.main.async {
                        self.updateChartWithData()
                    }
                }
            }
        })
        
    }
    
    func updateChartWithData() {
        var dataEntries: [ChartDataEntry] = []
        var months = [String]()
        self.values = Array(self.valuesDictionary.values)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.values.sort { (a, b) -> Bool in
            let aDate = dateFormatter.date(from: a.Date!)
            let bDate = dateFormatter.date(from: b.Date!)
            if aDate != nil && bDate != nil{
                return aDate! < bDate!
            }
            return false
        }
        
        //print(self.values)
        for i in 0..<self.values.count {
            if self.values[i].Value != nil{
                let dataEntry = ChartDataEntry(x: Double(i), y: Double(self.values[i].Value!))
                months.append(self.values[i].Date!)
                dataEntries.append(dataEntry)
            }
        }
        
        let chartDataSet = LineChartDataSet(values: dataEntries, label: variable?.Name)
        
        let chartData = LineChartData(dataSet: chartDataSet)
        chartData.notifyDataChanged()
        chartContainerView.data = chartData
        chartContainerView.xAxis.valueFormatter = XValsFormatter(xVals: months)
        chartContainerView.xAxis.axisMinimum = Double(0)
        chartContainerView.xAxis.axisMaximum = Double(months.count - 1)
        
    }
    
    let variableInfoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let infoTitle: UILabel = {
        let tv = UILabel()
        tv.text = "INFORMACIÓN"
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.backgroundColor = UIColor(r: 80, g: 109, b: 131)
        tv.textColor = UIColor.white
        tv.textAlignment = .center
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let lotesTitle: UILabel = {
        let tv = UILabel()
        tv.text = "VALORES"
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.backgroundColor = UIColor(r: 80, g: 109, b: 131)
        tv.textColor = UIColor.white
        tv.textAlignment = .center
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    //Chart
    let chartContainerView: LineChartView = {
        let lchart = LineChartView()
        lchart.translatesAutoresizingMaskIntoConstraints = false
        return lchart
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Info title
        addSubview(infoTitle)
        infoTitle.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        infoTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        infoTitle.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        infoTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //Lotes title
        addSubview(lotesTitle)
        lotesTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        lotesTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lotesTitle.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        lotesTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        //Area
        addSubview(chartContainerView)
        chartContainerView.topAnchor.constraint(equalTo: infoTitle.bottomAnchor).isActive = true
        chartContainerView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        chartContainerView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        chartContainerView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -100).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
}

class XValsFormatter: NSObject, IAxisValueFormatter {
    
    let xVals: [String]
    init(xVals: [String]) {
        self.xVals = xVals
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return xVals[Int(value)]
    }
    
}
