//
//  AnalogChartController.swift
//  omniscient
//
//  Created by DAVIDE RISI on 28/05/22.
//

import UIKit
import CoreData
import Charts

class AnalogChartController: UIViewController, ChartViewDelegate   {
    
    var lineChart = LineChartView()
    var titleSensor: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = titleSensor
        lineChart.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lineChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.width-20, height: self.view.frame.width)
        lineChart.center = view.center
        view.addSubview(lineChart)
        
//      Configuro il chart
        lineChart.backgroundColor = .systemGray6
        lineChart.rightAxis.enabled = false
        lineChart.doubleTapToZoomEnabled = false //Disattivo la possibilità di zoomare il grafico
        
        let yAxis = lineChart.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .black // Setto il colore dei numeri sull'asse y
//        yAxis.labelPosition = .insideChart
        yAxis.axisLineColor = .black //Setto il colore dell'asse a sinistra
        yAxis.drawGridLinesEnabled = false
        
        
        let xAxis = lineChart.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .boldSystemFont(ofSize: 12)
        xAxis.setLabelCount(6, force: false)
        xAxis.labelTextColor = .black // Setto il colore dei numeri sull'asse y
//        xAxis.labelPosition = .insideChart
        xAxis.axisLineColor = .black //Setto il colore dell'asse a sinistra
        xAxis.drawGridLinesEnabled = false
//        lineChart.animate(xAxisDuration: 0.5) //Setto un'animazione del grafico. Impiega 0.5 secondi a popolare il grafico
        
        
        
        
        let set: LineChartDataSet = setData()
//        set.colors = ChartColorTemplates.material() // Setto un template per le linee. Non fa al nostro caso
        
        set.drawCirclesEnabled = false //Non voglio i cerchi sul grafico
        set.mode = .horizontalBezier //Smussa un po' le curve rendendo più analogico il grafico
        set.lineWidth = 4 //Setto lo spessore della linea
        set.setColor(.black) //Setto il colore della linea
        
        
//      Se voglio colorare l'integrale abilito queste istruzioni
//        set.fill = Fill(color: .white)
//        set.fillAlpha = 0.8
//        set.drawFilledEnabled = true

        
//      Inserisco i dati nel grafico
        let data = LineChartData(dataSet: set)
        data.setDrawValues(false)
        lineChart.data = data
    }
    
    
    
    func setData() -> LineChartDataSet {
        
        //      Creo dei dati per testare
        let set = LineChartDataSet(entries: [
                ChartDataEntry(x: 1, y: 2),
                ChartDataEntry(x: 2, y: 5),
                ChartDataEntry(x: 3, y: 3),
                ChartDataEntry(x: 5, y: 4),
                ChartDataEntry(x: 7, y: 1),
                ChartDataEntry(x: 9, y: 2),
                ChartDataEntry(x: 4, y: 2)
        ], label: "Temperatura")
                
        return set
    }
    
    
    func setTitle(title: String){
        titleSensor = title
    }
    
}
    
