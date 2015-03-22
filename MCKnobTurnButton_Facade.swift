//
//  MCKnobTurnButton_InterfaceFile.swift
//  MonsoonChallenge
//
//  Created by xcode on 3/21/15.
//  Copyright (c) 2015 MSCline. All rights reserved.
//

import UIKit

class MCKnobTurnButton_Facade: MCKnobTurnButton {

    /* I MISS MY .h FILE
    
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

        var moveToIndex:Int?

        // the user will provide an index number between 0 and the count -1
        // the knob uses the index number as a counter which will tell us how many times we went around (much easier to keep track of the math)
        // so need to find convert the index number to a counter

        let currentIndex = self.titleIndexBeingViewed % self.buttonTitles.count

        if desiredIndex == currentIndex{

            return

        }else if desiredIndex > currentIndex{

            let jumpNumberOfIndexes = desiredIndex - currentIndex
            moveToIndex = currentIndex + jumpNumberOfIndexes

        } else {

            return
        }

        super.rotateToIndexNumber(moveToIndex!)
        
    }

    func rotateToRandomPosition(){

        let currentPosition = self.titleIndexBeingViewed
        let moveXPositions = arc4random_uniform(6) + 1
        let nextPosition = currentPosition + moveXPositions

        super.rotateToIndexNumber(Int(nextPosition))

    }

}
