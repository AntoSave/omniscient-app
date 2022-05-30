//
//  DigitalChartController.swift
//  omniscient
//
//  Created by DAVIDE RISI on 28/05/22.
//

import UIKit
import CoreData
import Charts

class DigitalChartController: UIViewController, ChartViewDelegate  {
    
    var barChart = BarChartView()
    var titleSensor: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = titleSensor
        barChart.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        barChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.width-20, height: self.view.frame.width)
        barChart.center = view.center
        view.addSubview(barChart)
        
//      Configuro il chart
        barChart.backgroundColor = .systemGray6
        barChart.rightAxis.enabled = false
        
        let yAxis = barChart.leftAxis
        yAxis.spaceBottom = 0 //Attacca all'asse x gli istogrammi
        yAxis.drawLabelsEnabled = false // Non mostra le label sull'asse y
        yAxis.drawGridLinesEnabled = false
//        yAxis.axisMinLabels = 0
//        yAxis.labelFont = .boldSystemFont(ofSize: 12)
//        yAxis.setLabelCount(2, force: true)
//        yAxis.labelTextColor = .black // Setto il colore dei numeri sull'asse y
//        yAxis.axisLineColor = .black //Setto il colore dell'asse a sinistra

        let xAxis = barChart.xAxis
        
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .boldSystemFont(ofSize: 12)
//        xAxis.setLabelCount(6, force: false)
        xAxis.labelTextColor = .black // Setto il colore dei numeri sull'asse y
        xAxis.axisLineColor = .black //Setto il colore dell'asse a sinistra
        xAxis.drawGridLinesEnabled = false
//        lineChart.animate(xAxisDuration: 0.5) //Setto un'animazione del grafico. Impiega 0.5 secondi a popolare il grafico
        
        
        
        
        let set: BarChartDataSet = setData()
        
//        set.colors = ChartColorTemplates.material() // Setto un template per le linee. Non fa al nostro caso
        

        
//      Inserisco i dati nel grafico
        let data = BarChartData(dataSet: set)
        data.setDrawValues(false)
        barChart.data = data
    }
    
    
    
    func setData() -> BarChartDataSet {
        
        //      Creo dei dati per testare
        
        var entries = [BarChartDataEntry]()
        
        for x in 0..<30 {
            entries.append(BarChartDataEntry(x: Double(x), y: 0))
            entries.append(BarChartDataEntry(x: Double(x)+0.5, y: 1))
        }
        
        let set = BarChartDataSet(entries: entries)
        
//        let set = BarChartDataSet(entries: [
//
//
//                BarChartDataEntry(x: 2, y: 1),
//                BarChartDataEntry(x: 3, y: 0),
//                BarChartDataEntry(x: 5, y: 1),
//                BarChartDataEntry(x: 7, y: 1),
//                BarChartDataEntry(x: 9, y: 0),
//                BarChartDataEntry(x: 4, y: 0)
//        ], label: "Movement")
                
        return set
    }
    
    
    func setTitle(title: String){
        titleSensor = title
    }
}