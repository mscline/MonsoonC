//
//  ViewController.swift
//  MonsoonChallenge
//
//  Created by xcode on 3/21/15.
//  Copyright (c) 2015 MSCline. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MCKnobTurnButton_optionalProtocol {


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

        // MUSIC FOR SHUFFLE (each knob can play its own music, but the VC may want to as well)
        var musicPlayer = MCMusicPlayer()
        var numberOfKnobsReportedBackThatCompletedAnimation = -100000  // quick hack
    

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
        musicPlayer.songNameAndExtention = "Highstrung.mp3"

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

        knobA.delegate = self
        knobB.delegate = self
        knobC.delegate = self
        knobD.delegate = self
        knobE.delegate = self
        knobF.delegate = self

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

        println("Knob control was touched")

    }


    @IBAction func onShuffle(sender: AnyObject) {

        for knob in arrayOfKnobs {

            musicPlayer.playMusic()
            numberOfKnobsReportedBackThatCompletedAnimation = 0
            knob.rotateToRandomPosition()

        }

    }



    // MARK: NAV BUTTONS

    @IBAction func onMenu(sender: AnyObject) {

        println("menu button pressed")

        // TEST
        //knobF.rotateToIndexNumber(11)

//        println("Top Right Knob")
//        println("testing: indexPosition = \(knobF.returnIndexPosition())")
//        println("testing: indexNumber = \(knobF.returnIndexNumberOfTitleBeingDisplayed())")

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

    
    // MARK: KNOB OPTIONAL PROTOCOL
    // note: MCKnobButton is a control, use the protocol if you want to know when a rotation is finished

    func willMoveToIndex_returnFalseToCancel(sender:AnyObject?, indexNumber: Int) -> (Bool) {

        println("will move to next index")
        return true

    }

    func didFinishMovingToIndex(sender: AnyObject?, indexNumber: Int) {

        println("did finish moving to index")
        numberOfKnobsReportedBackThatCompletedAnimation++

        if numberOfKnobsReportedBackThatCompletedAnimation >= 6 {

            musicPlayer.fadeMusicThenStop()
            numberOfKnobsReportedBackThatCompletedAnimation = -100000
        }

    }

}

