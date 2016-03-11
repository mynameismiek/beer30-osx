//
//  Beer30StatusProcessor.swift
//  Beer30Status
//
//  Created by Patrick Alessi on 8/26/14.
//  Copyright (c) 2014 Patrick Alessi. All rights reserved.
//

import Foundation
import AppKit

enum StatusColor {
    case Red
    case Yellow
    case Green
}


class Beer30StatusProcessor {
        
    var webCallTimer: NSTimer = NSTimer()
    var statusItem:NSStatusItem
    let scheduledInterval = 60.0
    
    init (statusItem:NSStatusItem) {
        self.statusItem = statusItem
        self.webCallTimer = NSTimer.scheduledTimerWithTimeInterval(scheduledInterval, target: self, selector: "checkStatusFromWebServiceTimerFired:", userInfo: nil, repeats: true)
        
        let status = getStatusFromWeb()
        setStatusBar(status)
        
    }
    
    // Need the @objc because we're calling this function as a selector from an ObjC object
    @objc func checkStatusFromWebServiceTimerFired (timer:NSTimer){

        let status = getStatusFromWeb()
        setStatusBar(status)
        
    }
    
    func getStatusFromWeb () -> StatusColor {
        print("getStatusFromWeb")
        var statusColor:StatusColor

        
        let url = NSURL(string:"https://beer30v2.sparcedge.com/beer30.json")
        let urlRequest = NSURLRequest(URL: url!)
        let returnedData: NSData? = try? NSURLConnection.sendSynchronousRequest(urlRequest, returningResponse: nil)
        
        if returnedData != nil
        {
            let jsonResult:NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(returnedData!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
            
            let status:String = jsonResult["state"] as! String
            
            
            switch status {
            case "red":
                statusColor=StatusColor.Red
                
            case "yellow":
                statusColor=StatusColor.Yellow
                
            case "green":
                statusColor=StatusColor.Green
                
            default:
                statusColor=StatusColor.Red
            }

        }
        else {
             statusColor = StatusColor.Red
        }
        


        
        return statusColor
    }
    
    func setStatusBar (status:StatusColor) {
        //statusItem.title = status
        
        var imageName:String
        
        switch status {
            case .Red:
                imageName = "Red_pog"
            case .Yellow:
                imageName = "Yellow_pog"
            case .Green:
                imageName = "Green_pog"
        }
        

        let aImage = NSImage(named: imageName)
        let imageSize = 19
        aImage!.size = NSSize(width: imageSize,height: imageSize)
        
        statusItem.image = aImage
        
    }
    
    
    
    
}