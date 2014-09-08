//
//  ViewController.swift
//  Sound
//
//  Created by Katlyn Schwaebe on 9/5/14.
//  Copyright (c) 2014 Katlyn Schwaebe. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureAudioDataOutputSampleBufferDelegate {
    
    var audioSession = AVAudioSession()
    var audioDataOutput = AVCaptureAudioDataOutput()
    var audioCaptureSession = AVCaptureSession()
    var pHL: Float = 0
    var aPL: Float = 0
    
    
    
    
    //peak hold level and average power level
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        audioSession.setCategory(AVAudioSessionCategoryRecord, error: nil)
        audioSession.setMode(AVAudioSessionModeMeasurement, error: nil);
        audioSession.setActive(true, error: nil)
        audioSession.setPreferredSampleRate(48000, error: nil)
        
        var device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
        var audioCaptureInput = AVCaptureDeviceInput (device: device, error: nil)
        
        audioCaptureSession.addInput(audioCaptureInput)
        audioDataOutput.setSampleBufferDelegate(self, queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, CUnsignedLong()))
        
        audioCaptureSession.addOutput(audioDataOutput)
        audioCaptureSession.startRunning()
    }
    // only blow bubbles if peak or pwer passes a number
    // after animation finishes remove bubble from screen
    // find a cool image online that can be a bubble, lighting bolt, fire
    
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        
        println ("output")
        
        for channel: AnyObject in connection.audioChannels {
            println("peak hold \(channel.peakHoldLevel) and average power \(channel.averagePowerLevel)")
            pHL = channel.peakHoldLevel
            println(pHL)
            aPL = channel.averagePowerLevel
            println(aPL)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.createBubble()
            })
        }
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"space.png"))
    }
    let height = UIScreen.mainScreen().bounds.size.height
    let width = UIScreen.mainScreen().bounds.size.width
    
    func createBubble(){
        
        if (pHL) > -10.0 || (aPL) > -10.0 {
            
            
            var bubble = UIView(frame:CGRectMake(0, 0, 28, 28))
            bubble.center = CGPointMake(width / 2, height)
            bubble.backgroundColor = UIColor.cyanColor()
            bubble.layer.cornerRadius = 14
            self.view.addSubview(bubble)
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                let x = CGFloat(arc4random_uniform(UInt32(self.width)))
                let y = CGFloat(arc4random_uniform(UInt32(self.height)))
                
                bubble.center = CGPointMake(x, y)
            }, completion: { (Bool) -> Void in
                bubble.removeFromSuperview()
            })
           
        
        }
            
        if (pHL) > -5.0 || (aPL) > -5.0 {
            
            var square = UIView(frame:CGRectMake(0, 0, 20, 20))
            square.center = CGPointMake(width / 2, height)
            square.backgroundColor = UIColor.greenColor()
            self.view.addSubview(square)
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                let x = CGFloat(arc4random_uniform(UInt32(self.width)))
                let y = CGFloat(arc4random_uniform(UInt32(self.height)))
                
                
                square.center = CGPointMake(x, y)
            }, completion: { (Bool) -> Void in
                square.removeFromSuperview()
            })
            
            
        }
         if (pHL) > -10.0 || (aPL) > -10.0 {
            
    
            var roll = UIView(frame:CGRectMake(0, 0, 25, 36))
            roll.center = CGPointMake(width / 2, height)
            roll.backgroundColor = UIColor(patternImage: UIImage(named:"cinn.png"))
            self.view.addSubview(roll)
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                let x = CGFloat(arc4random_uniform(UInt32(self.width)))
                let y = CGFloat(arc4random_uniform(UInt32(self.height)))
                roll.center = CGPointMake(x, y)
            }, completion: { (Bool) -> Void in
                roll.removeFromSuperview()
            })
            
           
        
        }
            if (pHL) > -30.0 || (aPL) > -30.0 {
                
                var pizza = UIView(frame:CGRectMake(0, 0, 33, 25))
                pizza.center = CGPointMake(width / 2, height)
                pizza.backgroundColor = UIColor(patternImage: UIImage(named:"pizza.png"))
                self.view.addSubview(pizza)
                
              UIView.animateWithDuration(0.5, animations: { () -> Void in
                let x = CGFloat(arc4random_uniform(UInt32(self.width)))
                let y = CGFloat(arc4random_uniform(UInt32(self.height)))
                pizza.center = CGPointMake(x, y)
              }, completion: { (Bool) -> Void in
                pizza.removeFromSuperview()
              })
                
                
//                UIView.animateWithDuration(5.0, animations: { () -> Void in
//                    let x = CGFloat(arc4random_uniform(UInt32(self.width)))
//                    let y = CGFloat(arc4random_uniform(UInt32(self.height)))
//                    
//                    
//                    pizza.center = CGPointMake(x, y)
//                })
        
     
    }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

