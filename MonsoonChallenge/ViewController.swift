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

        var arrayOfKnobs:[MCKnobTurnButton_Facade] = Array()


    required init(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()

    }

    func loadData(){

        let dataA = ["one of a kind","small batch","large batch","mass market"]
        let dataB = ["savory","sweet","umami"]
        let dataC = ["spicy","mild"]
        let dataD = ["crunchy","mushy","smooth"]
        let dataE = ["a little","a lot"]
        let dataF = ["breakfast","brunch","lunch","snack","dinner"]

        knobA.loadDataForButton(arrayOfButtonTitles: dataA)
        knobB.loadDataForButton(arrayOfButtonTitles: dataB)
        knobC.loadDataForButton(arrayOfButtonTitles: dataC)
        knobD.loadDataForButton(arrayOfButtonTitles: dataD)
        knobE.loadDataForButton(arrayOfButtonTitles: dataE)
        knobF.loadDataForButton(arrayOfButtonTitles: dataF)

        self.arrayOfKnobs = [knobA,knobB,knobC,knobD,knobE,knobF]

    }


    // MARK: BUTTONS

    @IBAction func onKnobPressed(sender: AnyObject) {

        
        
    }

    @IBAction func onGo(sender: AnyObject) {


    }

    @IBAction func onShuffle(sender: AnyObject) {

        for knob in arrayOfKnobs {

            knob.rotateToRandomPosition()
        }

    }


    // MARK: NAV BUTTONS

    @IBAction func onMenu(sender: AnyObject) {

    }



    

}

