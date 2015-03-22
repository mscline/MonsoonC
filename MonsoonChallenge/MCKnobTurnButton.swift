//
//  MCKnobTurnButton.swift
//  MonsoonChallenge
//
//  Created by xcode on 3/21/15.
//  Copyright (c) 2015 MSCline. All rights reserved.
//

import UIKit

@objc protocol MCKnobTurnButton_optionalProtocol{

    optional func willMoveToIndex_returnFalseToCancel(indexNumber:Int)->(Bool)
    optional func didFinishMovingToIndex(indexNumber:Int)

}

class MCKnobTurnButton: UIControl {


        // subviews
        var titleLabel = UILabel()
        var backgroundView = UIView()

        // button titles
        var buttonTitles:[String] = Array()
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

        // music
        var musicPlayer = MCMusicPlayer()

        // delegate (optional)
        var delegate:MCKnobTurnButton_optionalProtocol?


    // xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    // MARK: PUBLIC FUNCTIONS FOR USERS TO USE
    // xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    func loadDataForButton(#arrayOfButtonTitles:Array<String>){

        buttonTitles = arrayOfButtonTitles

        //self.backgroundColor = UIColor.clearColor()
        drawBackground()
        updateTitleAtIndex(titleIndexBeingViewed)
        
    }

    func rotateToIndexNumber(indexNumber:Int)
    {
        moveToIndex(indexNumber)
    }

    // xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    // MARK: PRIVATE FUNCTIONS / INTERNAL WORKINGS
    // xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupSubviews()
        musicPlayer.songNameAndExtention = "Highstrung.mp3"

    }

    private func setupSubviews(){


        // a UIControl is a UIView with additional functionality
        // we will use subviews to simplify interaction
        // turning off subview.UserInteractionEnabled, so that touches will be forwarded up the responder chain to the superview (this control)
        // 1) there is a view to put background image in, so can rotate without complications
        // 2) there is a UILabel, to display the title


        self.clipsToBounds = true
        self.frame = CGRectMake(0, 0, 200, 200)  // ERROR HERE

        titleLabel.frame = self.frame
        titleLabel.userInteractionEnabled = false

        backgroundView.frame = self.frame
        backgroundView.userInteractionEnabled = false

        self.addSubview(titleLabel)
        self.addSubview(backgroundView)

    }


    // MARK: ON TOUCH

    override func endTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) {

        let nextIndex = titleIndexBeingViewed + 1
        moveToIndex(nextIndex)

    }


    // MARK: MOVE TO NEXT

    private func moveToIndex(nextIndex:Int){

        // error check
        if nextIndex == titleIndexBeingViewed { return;
        } else if nextIndex < titleIndexBeingViewed {
            abort()  // reminder for programmer: the next title position should always be greater than the last
        }

        // notify delegate
        //let shouldContinue:Bool = notifyDelegateWillChangeToIndex(nextIndex)
        //if shouldContinue == false {return;}

        // calculate duration of time it will take to move
        let distanceToTravelBetweenSectionsInDegrees = Float(360 / buttonTitles.count) - degreesBetweenArcs
        let positionsToMove = Float(nextIndex - titleIndexBeingViewed)
        let distanceToTravelInDegrees = positionsToMove * distanceToTravelBetweenSectionsInDegrees
        let durationOfMoveInSeconds = distanceToTravelInDegrees / angularVelocityInDegreesPerSecond

        // get final angle
        // (we will always move from our current angle to a bigger angle, 
        //  so you might be at 360 and if you move 180, the angle is 540)

        let finalAngle = Float(nextIndex) * distanceToTravelBetweenSectionsInDegrees //+ startingOffset
        let finalAngleInRadians = finalAngle*(3.14159/180)


        // update
        titleIndexBeingViewed = nextIndex

        updateTitleAtIndex(titleIndexBeingViewed)
        rotateKnobToIndexAndPlayMusic(finalAngle: finalAngleInRadians, duration: durationOfMoveInSeconds)  // will notify delegate on completion

    }

    private func updateTitleAtIndex(index:Int){

        let indexNumber = index % buttonTitles.count
        let title = buttonTitles[indexNumber]
        titleLabel.attributedText = TextFormatter.createAttributedString(title, withFont:fontName, fontSize:fontSize, fontColor: fontColor, nsTextAlignmentStyle: NSTextAlignment.Center)

    }

    private func rotateKnobToIndexAndPlayMusic(#finalAngle:Float, duration:Float){

        musicPlayer.playMusic()

        UIView.animateWithDuration(Double(duration), animations: { () -> Void in

            self.backgroundView.transform = CGAffineTransformMakeRotation(CGFloat(finalAngle));  // note: the transform uses cartesian coordinates

        }) { (reallyFinishedAnimation) -> Void in

            self.musicPlayer.fadeMusicThenStop()
        }

    }

    private func playMusic(index:Int){

        musicPlayer.playMusic()


    }


    // MARK: DELEGATE

//    func notifyDelegateWillChangeToIndex(index:Int){
//
//        if delegate != nil {return;}
//
//        // FOR UPGRADE: optionals being difficult
//
//        let ourDelegate: AnyObject! = delegate
//        let willRun = ourDelegate!.respondsToSelector("willMoveToIndex:")
//
//        if willRun == true {
//
//            let nextIndex = index % buttonTitles.count
//            delegate?.willMoveToIndex_returnFalseToCancel(nextIndex)
//
//        }
//    }
//
//    func notifyDelegateDidFinishChangingToIndex(){
//
//        if delegate != nil {return;}
//
//        if delegate!.respondsToSelector("didFinishMovingToIndex:") {
//
//            let currentIndex = titleIndexBeingViewed % buttonTitles.count
//            delegate!.didFinishMovingToIndex(currentIndex)
//            
//        }
//    }


    // MARK: DRAW BACKGROUND VIEW

    private func drawBackground(){

        removeOldLayers()
        createCenterCircle()
        createBorderWithXNumberOfArcs(Float(buttonTitles.count))

    }

    private func removeOldLayers(){

        // remove all old layers
        for layer in backgroundView.subviews{

            layer.removeFromSuperlayer()

        }

    }

    private func createCenterCircle()
    {

        let width = Float(self.frame.size.width)
        let radius = width/2 - (lineWidth + line_insidePadding)

        let arc = createArc(radius: radius, startAngleInRadians: 0, angleOfArcInRadians: 360*(3.14159/180), lineColor: UIColor.clearColor(), fillColor: UIColor.yellowColor())

        // add alpha
        arc.opacity = 0.4

        // add to view
        backgroundView.layer.addSublayer(arc)

    }

    private func createBorderWithXNumberOfArcs(numberOfPieces:Float){


        // OUTPUT: A CIRCLE BROKEN UP INTO INDIVIDUAL ARCS
        // draw each arc (Beizer Path) separately and combine layers

        // start drawing our first arc at 0 degrees + an offset
        let startAtAngle:Float = (degreesBetweenArcs/2) + startingOffset
        var startAtAngle_inRadians:Float = startAtAngle*(3.14159/180)

        // calculate the angle each arc will take up
        let arcAngle = (360 / numberOfPieces) - degreesBetweenArcs
        let arcAngle_inRadians = arcAngle*(3.14159/180)

        // radius
        let radius = (Float(self.frame.size.width) - lineWidth)/2

        // draw the arcs
        for var counter = 0; counter < Int(numberOfPieces); counter++ {

            // the first arc will be selected (that is, it will have a different color)
            var color = lineColor_default

            if counter == 0 {

                color = lineColor_selected
            }

            // create arc and add sublayer
            let arc = createArc(radius: radius, startAngleInRadians: startAtAngle_inRadians, angleOfArcInRadians: arcAngle_inRadians, lineColor: color, fillColor:UIColor.clearColor())

            backgroundView.layer.addSublayer(arc)

            // increment startAtAngle
            startAtAngle_inRadians = startAtAngle_inRadians + arcAngle_inRadians + degreesBetweenArcs*(3.14159/180)

        }

    }


    private func createArc(#radius:Float, startAngleInRadians:Float, angleOfArcInRadians:Float, lineColor:UIColor, fillColor:UIColor)->(CAShapeLayer){


        // APPLE DRAWS THE UNIT CIRCLE BACKWARDS, SO FLIP SIGNS
        var startAngle_inRadians = -startAngleInRadians

        // MAKE BASIC CALCULATIONS FOR OUR CIRCLE
        let finalAngle = startAngle_inRadians - angleOfArcInRadians  // FLIP SIGN

        let xCoordPointOnArc = Float(self.frame.size.width) + radius * cosf(startAngle_inRadians)
        let yCoordPointOnArc = Float(self.frame.size.width) + radius * sinf(startAngle_inRadians)

        // convert floats to CGFloats
        let xCoordPointOnArc_cgfloat = CGFloat(xCoordPointOnArc)
        let yCoordPointOnArc_cgfloat = CGFloat(yCoordPointOnArc)
        let startAngle_cgfloat = CGFloat(startAngle_inRadians)
        let finalAngle_cgfloat = CGFloat(finalAngle)
        let angle_cgfloat = CGFloat(angleOfArcInRadians)

        // create additional variables to work with
        let radius_cgfloat = CGFloat(radius)
        let center_cgFloat = CGPointMake(CGFloat(self.frame.size.width/2), CGFloat(self.frame.size.width/2))
        let xyCoordPointOnArc = CGPointMake(xCoordPointOnArc_cgfloat, yCoordPointOnArc_cgfloat)


        // CREATE LAYER
        let shapeLayer = CAShapeLayer()

        // set color and line settings
        shapeLayer.fillColor = fillColor.CGColor
        shapeLayer.strokeColor = lineColor.CGColor
        shapeLayer.lineWidth = CGFloat(lineWidth)


        // BUILD SHAPE FROM LINE SEGEMENTS (ie a Bezier Path)
        let connectedLineSegments = UIBezierPath()

        // draw arc
        connectedLineSegments.addArcWithCenter(center_cgFloat, radius:radius_cgfloat, startAngle:startAngle_cgfloat, endAngle: finalAngle_cgfloat, clockwise: false)
        
        
        // use our Bezier Path as a mask
        shapeLayer.path = connectedLineSegments.CGPath
        
        return shapeLayer
    }


}