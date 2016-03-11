//
//  AppDelegate.swift
//  Beer30Status
//
//  Created by Patrick Alessi on 8/18/14.
//  Copyright (c) 2014 Patrick Alessi. All rights reserved.
//

import Cocoa


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    

    @IBOutlet var menu:NSMenu?
    var statusItem : NSStatusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    var beer30StatusProcessor: Beer30StatusProcessor;
    
    override init()
    {

        
        beer30StatusProcessor = Beer30StatusProcessor(statusItem: statusItem);

        
        super.init();
    }
    
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        statusItem.menu = menu

    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }



}

