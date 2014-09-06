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
    }
    let height = UIScreen.mainScreen().bounds.size.height
    let width = UIScreen.mainScreen().bounds.size.width
    
    func createBubble(){
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

