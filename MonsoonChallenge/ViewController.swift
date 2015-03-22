//
//  ViewController.swift
//  MonsoonChallenge
//
//  Created by xcode on 3/21/15.
//  Copyright (c) 2015 MSCline. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


        // KNOBS
        @IBOutlet weak var knobA: MCKnobTurnButton_Facade!
        @IBOutlet weak var knobB: MCKnobTurnButton_Facade!
        @IBOutlet weak var knobC: MCKnobTurnButton_Facade!
        @IBOutlet weak var knobD: MCKnobTurnButton_Facade!
        @IBOutlet weak var knobE: MCKnobTurnButton_Facade!
        @IBOutlet weak var knobF: MCKnobTurnButton_Facade!

        // Guides for spacing
        // (the values in the xml didn't make sense, so I just tried to make it look like the screenshot you provided; I used constraints in order to demonstrate the competency)
        @IBOutlet weak var topSpacer: UIView!
        @IBOutlet weak var centerSpacer: UIView!
        @IBOutlet weak var bottomSpacer: UIView!
        @IBOutlet weak var botLayoutSpacer: UIView!
        @IBOutlet weak var topLeftSpacer: UIView!
        @IBOutlet weak var topRightSpacer: UIView!

        // Arrays
        var arrayOfKnobs:[MCKnobTurnButton_Facade] = Array()


    // MARK: SETUP

    required init(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addNavBarItems()
        makeNavBarTransparentAndSetTintColor()
        setBackgroundImage()
        hideLayoutConvenienceGuidesAndSpacers()

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        loadData()

    }

    func loadData(){

        // the directions and the example were not totally consistent, so went with the drawing
        let dataF = ["one of a kind","small batch","large batch","mass market"]
        let dataC = ["savory","sweet","umami"]
        let dataD = ["spicy","mild"]
        let dataB = ["crunchy","mushy","smooth"]
        let dataA = ["a little","a lot"]
        let dataE = ["breakfast","brunch","lunch","snack","dinner"]

        knobA.loadDataForButton(arrayOfButtonTitles: dataA)
        knobB.loadDataForButton(arrayOfButtonTitles: dataB)
        knobC.loadDataForButton(arrayOfButtonTitles: dataC)
        knobD.loadDataForButton(arrayOfButtonTitles: dataD)
        knobE.loadDataForButton(arrayOfButtonTitles: dataE)
        knobF.loadDataForButton(arrayOfButtonTitles: dataF)

        self.arrayOfKnobs = [knobA,knobB,knobC,knobD,knobE,knobF]
        
    }

    func addNavBarItems(){

        // add left nav bar buttons
        let leftButtonA = UIBarButtonItem(image: UIImage(named: "MON_searchIcon"), style: UIBarButtonItemStyle.Plain, target: self, action: "onSearchButtonPressed")
        let leftButtonB = UIBarButtonItem(image: UIImage(named: "MON_calendarIcon"), style: UIBarButtonItemStyle.Plain, target: self, action: "onCalendarButtonPressed")
        let leftButtonC = UIBarButtonItem(image: UIImage(named: "MON_compassIcon"), style: UIBarButtonItemStyle.Plain, target: self, action: "onCompassButtonPressed")

        let leftNavBarButtons = [leftButtonA, leftButtonB, leftButtonC ]
        self.navigationItem.leftBarButtonItems = leftNavBarButtons;

    }

    func makeNavBarTransparentAndSetTintColor(){

        self.navigationController!.view.backgroundColor = UIColor.clearColor()
        self.navigationController!.navigationBar.backgroundColor = UIColor.clearColor()
        self.navigationController!.navigationBar.translucent = true;

        self.navigationController!.navigationBar.barTintColor = UIColor.clearColor()

        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.shadowImage = UIImage()

        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)

        // set tint color for whole app, not just nav controller
        //self.navigationController!.navigationBar.tintColor = UIColor.darkGrayColor()
        let window = UIApplication.sharedApplication().delegate?.window!
        window?.tintColor = UIColor(red: 48/255.0, green: 48/255.0, blue: 48/255.0, alpha: 1)

    }

    func setBackgroundImage(){

        let imageV = UIImageView(frame: self.view.frame)
        imageV.image = UIImage(named: "MON_Rectangle-5")
        self.view.addSubview(imageV)
        self.view.sendSubviewToBack(imageV)

    }

    func hideLayoutConvenienceGuidesAndSpacers(){

        // may wish to remove before ship (but doesn't really make a big difference)
        topSpacer.backgroundColor = UIColor.clearColor()
        bottomSpacer.backgroundColor = UIColor.clearColor()
        centerSpacer.backgroundColor = UIColor.clearColor()
        botLayoutSpacer.backgroundColor = UIColor.clearColor()
        topLeftSpacer.backgroundColor = UIColor.clearColor()
        topRightSpacer.backgroundColor = UIColor.clearColor()

        knobA.backgroundColor = UIColor.clearColor()
        knobB.backgroundColor = UIColor.clearColor()
        knobC.backgroundColor = UIColor.clearColor()
        knobD.backgroundColor = UIColor.clearColor()
        knobE.backgroundColor = UIColor.clearColor()
        knobF.backgroundColor = UIColor.clearColor()

    }


    // MARK: BUTTONS

    @IBAction func onKnobPressed(sender: AnyObject) {

    }


    @IBAction func onShuffle(sender: AnyObject) {

        for knob in arrayOfKnobs {

            knob.rotateToRandomPosition()
        }

    }



    // MARK: NAV BUTTONS

    @IBAction func onMenu(sender: AnyObject) {

        println("menu button pressed")
        knobF.rotateToIndexNumber(11)
    }

    func onSearchButtonPressed(){

        println("search button pressed")
    }

    func onCalendarButtonPressed(){

        println("calendar button pressed")

    }

    func onCompassButtonPressed(){

        println("compass button pressed")
    }

    

}

