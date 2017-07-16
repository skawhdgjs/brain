//
//  ViewController.swift
//  Brain
//
//  Created by nam on 2016. 11. 29..
//  Copyright © 2016년 nam. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var name: NSTextField!
    @IBOutlet weak var age: NSTextField!
    @IBOutlet weak var opinion: NSTextField!
    
    @IBOutlet weak var lookMri: NSImageView!
    @IBOutlet weak var urlVisual: NSTextField!
    @IBOutlet weak var result: NSTextField!
    
    @IBOutlet weak var progress: NSProgressIndicator!
    
    @IBOutlet weak var registerMRI: NSButton!
    @IBOutlet weak var workstation: NSButton!
  
    @IBOutlet weak var male: NSButton!
    @IBOutlet weak var female: NSButton!
  
    @IBOutlet weak var q1Y: NSButton!
    @IBOutlet weak var q1N: NSButton!
    @IBOutlet weak var q2Y: NSButton!
    @IBOutlet weak var q2N: NSButton!
    @IBOutlet weak var q3Y: NSButton!
    @IBOutlet weak var q3N: NSButton!
    @IBOutlet weak var q4Y: NSButton!
    @IBOutlet weak var q4N: NSButton!
    @IBOutlet weak var q5N: NSButton!
    @IBOutlet weak var q5Y: NSButton!
    @IBOutlet weak var q6N: NSButton!
    @IBOutlet weak var q6Y: NSButton!

    var query : [Bool] = [false, false, false, false, false, false]
    var curDir = "/Users/nam/tensorflow/brainN/tf_files/"
    
    var imageURL:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        //self.progress.isHidden = true
        
        
        // Get current directory path from file   -- not use 
        /*
        let path = FileManager.default.currentDirectoryPath
        let filename = path + "/configure.txt"
        
        print("filename : \(filename)\n")
        
        let fileURL = URL(fileURLWithPath: filename)
        
        var curDirpath = ""
        
        do {
            curDirpath = try String(contentsOf: fileURL , encoding: String.Encoding.ascii)
        } catch let error as NSError {
            print("Not found configure :\(error)\n")
        }
        
        if curDirpath != "" {
            
            curDir = curDirpath
            print("set defualt curDir \(curDirpath)\n")
    
        }
        */

        name.stringValue = ""
        age.stringValue = ""
        lookMri.image = nil
        imageURL = ""
        result.stringValue = ""
        opinion.stringValue = ""
        
        male.state = 0
        female.state = 0
        
        q1Y.state = 0
        q1N.state = 0
        q2Y.state = 0
        q2N.state = 0
        q3Y.state = 0
        q3N.state = 0
        q4Y.state = 0
        q4N.state = 0
        q5Y.state = 0
        q5N.state = 0
        q6Y.state = 0
        q6N.state = 0
    }
    
    func enableObj(){
        name.isEditable = true
        age.isEditable = true
        opinion.isEditable = true
        male.isEnabled = true
        female.isEnabled = true
        
        
        registerMRI.isEnabled = true
        workstation.isEnabled = true
        
        q1Y.isEnabled = true
        q1N.isEnabled = true
        q2Y.isEnabled = true
        q2N.isEnabled = true
        q3Y.isEnabled = true
        q3N.isEnabled = true
        q4Y.isEnabled = true
        q4N.isEnabled = true
        q5Y.isEnabled = true
        q5N.isEnabled = true
        q6Y.isEnabled = true
        q6N.isEnabled = true

    }
    
    func unableObj(){
        
        name.isEditable = false
        age.isEditable = false
        opinion.isEditable = false
        
        male.isEnabled = false
        female.isEnabled = false
        
        registerMRI.isEnabled = false
        workstation.isEnabled = false
        
        q1Y.isEnabled = false
        q1N.isEnabled = false
        q2Y.isEnabled = false
        q2N.isEnabled = false
        q3Y.isEnabled = false
        q3N.isEnabled = false
        q4Y.isEnabled = false
        q4N.isEnabled = false
        q5Y.isEnabled = false
        q5N.isEnabled = false
        q6Y.isEnabled = false
        q6N.isEnabled = false

    
    }

    @IBAction func resetButton(_ sender: NSButton) {
        self.viewDidLoad()
        self.viewWillAppear()
    }
    
    
    @IBAction func fileOut(_ sender: Any) {
        
        let filename = name.stringValue + "_" + age.stringValue + "_result.txt"
        
        let path = curDir + "output/" + filename
        
        let text = name.stringValue + "   나이 : " + age.stringValue + "\n" + self.result.stringValue + "\n" + opinion.stringValue
        
        let alertController = NSAlert()
   
        alertController.messageText = "파일생성 성공"
        alertController.alertStyle = NSAlertStyle.informational
        
        do {
            try text.write(toFile: path, atomically: true, encoding: String.Encoding.utf16)
        } catch let error as NSError {
            print("write error:\(error)\n")
            alertController.messageText = "파일생성 실패"
            alertController.alertStyle = NSAlertStyle.critical
        }
        
        alertController.runModal()
    }
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func LearningPath(_ sender: Any) {
        let dirFilePicker:NSOpenPanel = NSOpenPanel()
        
        dirFilePicker.allowsMultipleSelection = false
        dirFilePicker.canChooseFiles = false
        dirFilePicker.canChooseDirectories = true
        
        let i = dirFilePicker.runModal()
        
        let chosenDir = dirFilePicker.url
        
        if i == NSModalResponseOK {
          
            let trimCurDir = (chosenDir?.absoluteString)!
            
            let start = trimCurDir.index(trimCurDir.startIndex, offsetBy: 7)
            let end = trimCurDir.index(trimCurDir.endIndex, offsetBy: 0)
            
            let range = start..<end
            curDir = trimCurDir.substring(with:range)
            
            
            print("change curDir : \(curDir)\n")
        }
    }
    
    @IBAction func ImportImage(_ sender: Any) {
        
        let rpFilePicker:NSOpenPanel = NSOpenPanel()
        
        rpFilePicker.allowsMultipleSelection = false
        rpFilePicker.canChooseFiles = true
        rpFilePicker.canChooseDirectories = false
        
        let i = rpFilePicker.runModal()
        
        var chosenFile = rpFilePicker.urls
        
        //there is file
        if  i == NSModalResponseOK {
            let picImport = NSImage(contentsOf: chosenFile[0])

            lookMri.image = picImport
        
            imageURL = chosenFile[0].absoluteString
            print("imageURL : \(imageURL)\n")
        }
    }

    @IBAction func ChooseGender(_ sender: NSButton) {
        print("Selected Gender \(sender.title)")
    }
    
    
    @IBAction func query1(_ sender: NSButton) {
       if sender.title == "예"{
        query[0] = true;
       }else{
        query[0] = false;
       }
    }
  
    
    @IBAction func query2(_ sender: NSButton) {
        if sender.title == "예"{
            query[1] = true;
        }else{
            query[1] = false;
        }
    }
   
    @IBAction func query3(_ sender: NSButton) {
        if sender.title == "예"{
            query[2] = true;
        }else{
            query[2] = false;
        }
    }
    
    @IBAction func query4(_ sender: NSButton) {
        if sender.title == "예"{
            query[3] = true;
        }else{
            query[3] = false;
        }
    }
    
    
    @IBAction func query5(_ sender: NSButton) {
        if sender.title == "예"{
            query[4] = true;
        }else{
            query[4] = false;
        }
    }
    
    @IBAction func query6(_ sender: NSButton) {
        if sender.title == "예"{
            query[5] = true;
        }else{
            query[5] = false;
        }
    }

    @IBAction func RunResult(_ sender: NSButton) {
        
        
        if(self.imageURL == ""){

            let alertController = NSAlert()
            alertController.messageText = "사진을 등록하세요"
            alertController.alertStyle = NSAlertStyle.critical
            alertController.runModal()
            return
 
        }
        
        
        sender.isEnabled = false
        let CurWindow = NSApp.mainWindow
        CurWindow?.title = "Inspect Alzeimer's disease"
        
        self.unableObj()
        
        self.progress.isHidden = false
        self.view.alphaValue = 0.4
        self.progress.startAnimation(NSButton.self)
        
        let path = "/Usr/bin/python"
        var argument = ["fileout.py"]
        argument.append(imageURL)
        
        let proc = Process()
        let pipe = Pipe()
        let outHandler = pipe.fileHandleForReading
        
        
        //proc.currentDirectoryPath = "/Users/nam/tensorflow/brain/tf_files/"
        proc.currentDirectoryPath = curDir
        proc.launchPath = path
        proc.arguments = argument
        
        proc.standardOutput = pipe
        
        print("--------processing-------------\n")
        print("curDir:\(proc.currentDirectoryPath)\n")
        outHandler.readabilityHandler = {
            pipe in if let line = String( data: outHandler.availableData, encoding: String.Encoding.ascii){
                var queryF:Float = 1
                var queryNum:Float = 0
                var Fresult:Float = 0
                
                print("line ; \(line)\n")
                //query result
                for check in self.query {
                    if(check == true){
                        queryF += 17.0
                        queryNum += 1
                    }
                }
                
                
                //calculate abnormal percentage
                let idx = line.characters.index(of: "b")
                var distance = line.distance(from: line.startIndex, to: idx!)
                distance += 17
                
                if line[line.index(line.startIndex , offsetBy: distance)] == "s" {
                    distance += 8
                }
                
                let start = line.index(line.startIndex, offsetBy: distance)
                let end = line.index(line.startIndex, offsetBy: distance+7)
                
                let range = start..<end
                let result = line.substring(with:range)
                
                let resultF = (result as NSString).floatValue * 100
                
                let resultQF = log10(queryNum+1)/log10(7)*100
                
                //calculate Fresult
                if 100.0 >= resultF && resultF >= 90.0
                {
                    if resultQF == 0
                    {
                        Fresult = 0
                    }
                    else
                    {
                        Fresult = resultF*0.93+resultQF*0.07
                    }
                }
                    
                else if 80.0 <= resultF && resultF < 90.0
                {
                    if resultQF == 0
                    {
                        Fresult = 0
                    }
                    else
                    {
                        Fresult = resultF*0.88+resultQF*0.12
                    }
                }
                    
                else if 70.0 <= resultF && resultF < 80.0
                {
                    if resultQF == 0
                    {
                        Fresult = 0
                    }
                    else
                    {
                        Fresult = resultF*0.83+resultQF*0.17
                    }
                }
                    
                else if 60.0 <= resultF && resultF < 70.0
                {
                    if resultQF == 0
                    {
                        Fresult = 0
                    }
                    else
                    {
                        Fresult = resultF*0.78+resultQF*0.22
                    }
                }
                    
                else
                {
                    Fresult = resultF*0.73+resultQF*0.27
                }
                
                
                //print result
                print("queryF : \(queryF) resultF:\(resultQF) float:\(resultF)\n")
                print("result : \(Fresult)")
                
                
                
 
                var resultAl = ""
                
                if Fresult > 75.0 {
                    resultAl = "치매가능성 높음"
                }else if Fresult > 50.0 {
                    resultAl =  "재검사필요"
                }else if Fresult > 30.0 {
                    resultAl = "주의 요망"
                }else{
                    resultAl = "정상"
                }

                DispatchQueue.main.async(execute: {
                    self.result.stringValue = resultAl + " / 검사결과("+String(Fresult)+"%)"
                    self.progress.stopAnimation(NSButton.self)
                    self.view.alphaValue = 1.0
                    self.progress.isHidden = true
                    
                    sender.isEnabled = true
                    self.enableObj()
                    print("------------end--------------\n")
                })
                
            }else{
                print("error")
            }
            
         
            
        }
        
        
        proc.launch()
    }
    
    
}

