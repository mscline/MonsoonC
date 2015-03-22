//
//  MCKnobTurnButton_InterfaceFile.swift
//  MonsoonChallenge
//
//  Created by xcode on 3/21/15.
//  Copyright (c) 2015 MSCline. All rights reserved.
//

import UIKit

class MCKnobTurnButton_Facade: MCKnobTurnButton {

    /* THIS IS AN INTERFACE / HEADER FILE, SO THE USER DOESN'T HAVE TO LOOK AT ALL OF THE CODE
    

    // button titles
    var titleIndexBeingViewed:Int = 0  // the next title position should always be greater than the last; titleIndex % count = gives the true index number; set indexNumber to a large number if you want it to spin around multiple times

    var fontName = "Papyrus"
    var fontSize:CGFloat = 14
    var fontColor = UIColor.whiteColor()


    // background/borders
    var lineWidth:Float = 20
    var line_insidePadding:Float = 15

    var lineColor_default:UIColor = UIColor.purpleColor()
    var lineColor_selected:UIColor = UIColor.redColor()

    var degreesBetweenArcs:Float = 20
    var startingOffset:Float = -90  // want to start drawing at -90 degrees


    // rotation
    var angularVelocityInDegreesPerSecond:Float = 70

    // delegate (optional)
    var delegate:MCKnobTurnButton_optionalProtocol?

    */

    override func loadDataForButton(#arrayOfButtonTitles:Array<String>){

        super.loadDataForButton(arrayOfButtonTitles: arrayOfButtonTitles)

    }

    override func rotateToIndexNumber(desiredIndex:Int)
    {
        // if the indexNumber is greater than the number of items, it will spin around multiple times

        super.rotateToIndexNumber(desiredIndex)
        
    }

    func rotateToRandomPosition(){

        let currentPosition = self.titleIndexBeingViewed
        let moveXPositions = arc4random_uniform(6) + 1
        let nextPosition = currentPosition + moveXPositions

        // check to make sure not sti
        super.rotateToIndexNumber(Int(nextPosition))

    }

}
