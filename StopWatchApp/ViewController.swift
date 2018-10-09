//
//  ViewController.swift
//  StopWatchApp
//
//  Created by Hanif Salafi on 09/10/18.
//  Copyright © 2018 Telkom University. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var viewBG: UIView!
    
    @IBOutlet weak var LabTableView: UITableView!

    @IBOutlet weak var btnStartStop: UIView!
    @IBOutlet weak var btnLapReset: UIView!
    
    
    var timer = Timer()
    var minutes : Int = 0
    var seconds : Int = 0
    var fractions : Int = 0
    var stopwatchString : String = ""
    var laps : [String] = []
    
    
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblLap: UILabel!
    
    @IBOutlet weak var lblStopwatch: UILabel!
    
    var startStopWatch : Bool = true
    var addLap : Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblStopwatch.text = "00:00.00"
        LabTableView.separatorStyle = .none
        
        let tapAction1 = UITapGestureRecognizer(target: self, action: #selector(startStop(gesture:)))
        btnStartStop.addGestureRecognizer(tapAction1)
        let tapAction2 = UITapGestureRecognizer(target: self, action: #selector(lapReset(gesture:)))
        btnLapReset.addGestureRecognizer(tapAction2)
    }
    
    @objc func startStop(gesture : UITapGestureRecognizer){
        if startStopWatch == true {
            
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateStopwatch), userInfo: nil, repeats: true)
            startStopWatch = false
            lblStart.text = "Stop"
            lblStart.textColor = UIColor.init(red: 1, green: 0, blue: 0, alpha: 1)
            lblLap.text = "Lap"
            lblLap.textColor = UIColor.init(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
            
            addLap = true
            
        } else {
            
            timer.invalidate()
            startStopWatch = true
            lblStart.text = "Start"
            lblStart.textColor = UIColor.init(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
            lblLap.text = "Reset"
            lblLap.textColor = UIColor.init(red: 1, green: 0, blue: 0, alpha: 1)
            
            addLap = false
        }
    }
    
    @objc func lapReset(gesture: UITapGestureRecognizer){
        if addLap == true {
            
            LabTableView.separatorStyle = .singleLine
            
            laps.insert(stopwatchString, at: 0)
            LabTableView.reloadData()
            
        } else {
            
            addLap = false
            lblLap.text = "Lap"
            
            laps.removeAll(keepingCapacity: false)
            LabTableView.reloadData()
            LabTableView.separatorStyle = .none
            
            fractions = 0
            seconds = 0
            minutes = 0
            
            stopwatchString = "00:00.00"
            lblStopwatch.text = stopwatchString
            lblLap.textColor = UIColor.init(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
            
        }
    }
    
    @objc func updateStopwatch () {
        
        fractions += 1
        
        if fractions == 100 {
            seconds += 1
            fractions = 0
        }
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
//        if minutes > 9 {
//            minutesString = "\(minutes)"
//        } else {
//            minutesString = "0\(minutes)"
//        }
        
        stopwatchString = "\(minutesString):\(secondsString).\(fractionsString)"
        lblStopwatch.text = stopwatchString
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
        
        cell.backgroundColor = viewBG.backgroundColor
        
        cell.textLabel?.text = "Lap \(laps.count-indexPath.row)"
        cell.detailTextLabel?.text = laps[indexPath.row]
        
        return cell
    }
    
    
}

