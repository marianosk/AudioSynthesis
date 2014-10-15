//
//  ToneWidget.swift
//  AudioSynthesis
//
//  Created by Simon Gladman on 14/10/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import UIKit

class ToneWidget: UIControl
{
    let toneDial = NumericDial(frame: CGRectZero)
    let velocityDial = NumericDial(frame: CGRectZero)
    let sineWaveRenderer = SineWaveRenderer(frame: CGRectZero)
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        addSubview(sineWaveRenderer)
        addSubview(toneDial)
        addSubview(velocityDial)
        
        toneDial.addTarget(self, action: "dialChangeHander", forControlEvents: UIControlEvents.ValueChanged)
        velocityDial.addTarget(self, action: "dialChangeHander", forControlEvents: UIControlEvents.ValueChanged)
        
        toneDial.currentValue = 0.5
        velocityDial.currentValue = 0.5
        
        dialChangeHander()
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getFrequencyVelocityPair() -> FrequencyVelocityPair
    {
        return FrequencyVelocityPair(frequency: Int(toneDial.currentValue * 128), velocity: Int(velocityDial.currentValue * 128))
    }
    
    func dialChangeHander()
    {
        sineWaveRenderer.setFrequencyVelocityPairs([getFrequencyVelocityPair()])
        
        sendActionsForControlEvents(UIControlEvents.ValueChanged)
    }
    
    override func didMoveToWindow()
    {
        sineWaveRenderer.frame = CGRect(x: 0, y: 0, width: Constants.width, height: 125)
        toneDial.frame = CGRect(x: 0, y: 145, width: Constants.width, height: Constants.width)
        velocityDial.frame = CGRect(x: 0, y: 355, width: Constants.width, height: Constants.width)
        
        toneDial.labelFunction = labelFunction("Tone")
        velocityDial.labelFunction = labelFunction("Velocity")
        
        sineWaveRenderer.setFrequencyVelocityPairs([getFrequencyVelocityPair()])
    }
    
    func labelFunction(label: String) -> ((Double) -> String)
    {
        func lblFn(value: Double) -> String
        {
            return "\(label)\n\(Int(value * 128))"
        }
        
        return lblFn
    }
}