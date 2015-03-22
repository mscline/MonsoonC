//
//  MCKnobTurnButton_InterfaceFile.swift
//  MonsoonChallenge
//
//  Created by xcode on 3/21/15.
//  Copyright (c) 2015 MSCline. All rights reserved.
//

import UIKit

class MCKnobTurnButton_Facade: MCKnobTurnButton {

    /* THIS IS AN INTERFACE / HEADER FILE / FACADE, SO THE USER DOESN'T HAVE TO LOOK AT ALL OF THE CODE


        // AVAILABLE PROPERTIES

        // button titles
        var fontName = "Papyrus"
        var fontSize:CGFloat = 14
        var fontColor = UIColor.whiteColor()


        // background/borders
        var lineWidth:Float = 20
        var line_insidePadding:Float = 15

        var lineColor_default:UIColor = UIColor.purpleColor()
        var lineColor_selected:UIColor = UIColor.redColor()

        var degreesBetweenArcs:Float = 12
        var startingOffset:Float = -90  // want to start drawing at -90 degrees


        // rotation
        var angularVelocityInDegreesPerSecond:Float = 70

        // delegate (optional)
        var delegate:MCKnobTurnButton_optionalProtocol?

        */


    // MARK: BUILD KNOB

    override func loadDataForButton(#arrayOfButtonTitles:Array<String>){

        super.loadDataForButton(arrayOfButtonTitles: arrayOfButtonTitles)

    }


    // MARK: FIND SELECTED INDEX

    func returnIndexNumberOfTitleBeingDisplayed()->(Int){

        return titleIndexBeingViewed % buttonTitles.count
    }

    func returnIndexPosition()->(Int){

        // ex. if there are three elements and you have rotated twice, the index position is 6
        return titleIndexBeingViewed
        
    }


    // MARK: ROTATIONS

    override func rotateToIndexNumber(desiredIndex:Int)
    {
        // UPGRADE: ???
        // it will currently spin either clockwise or counter clockwise to move into position
        // should probably refactor so that it will only move clockwise, then
        // if the indexNumber is greater than the number of items, it will spin around multiple times

        super.rotateToIndexNumber(desiredIndex)
        
    }

    func rotateToRandomPosition(){

        let currentPosition = self.titleIndexBeingViewed
        let moveXPositions = Int(arc4random_uniform(6) + 1)

        for var x = 0; x < moveXPositions; x++ {

            super.rotateToIndexNumber(Int(x))
            self.musicPlayer.stopMusic()
        }

    }


    // MARK: MISC

    func stopMusic(){

        self.musicPlayer.stopMusic()

    }


}
