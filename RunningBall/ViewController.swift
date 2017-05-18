//
//  ViewController.swift
//  RunningBall
//
//  Created by Vu Thanh Tung on 5/18/17.
//  Copyright © 2017 silverpear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var ball = UIImageView()
    var ballRadius = CGFloat()
    var radians = CGFloat()
    var (forwardX, forwardY) = (true, true)
    var deltaX = CGFloat(), deltaY = CGFloat()
//    var forward = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addBall()
        restartDirection()
        let time = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(rollBall), userInfo: nil, repeats: true)
    }

    func addBall() {
        ball = UIImageView(image: UIImage(named: "ball.png"))
        ballRadius = 32.0
        ball.center = CGPoint(x: ballRadius, y: self.view.bounds.size.height*0.5)
        self.view.addSubview(ball)
    }
    
    func getRandomCoor() -> (CGFloat, CGFloat) {
        let angle = CGFloat(arc4random_uniform(90) + 1)*CGFloat.pi/180.0
        return (cos(angle), sin(angle))
    }
    
    func restartDirection() {
        (deltaX, deltaY) = getRandomCoor()
    }
    
    func rollBall() {
        let deltaAngle: CGFloat = 0.1
        radians += deltaAngle
        ball.transform = CGAffineTransform(rotationAngle: radians)
        
        //Changing direction of ball by an angle when crash with walls
        switch (forwardX, forwardY) {
        case (true, true):
            ball.center = CGPoint(x: ball.center.x + ballRadius*deltaAngle*deltaX, y: ball.center.y + ballRadius*deltaAngle*deltaY)
        case (true, false):
            ball.center = CGPoint(x: ball.center.x + ballRadius*deltaAngle*deltaX, y: ball.center.y - ballRadius*deltaAngle*deltaY)
        case (false, true):
            ball.center = CGPoint(x: ball.center.x - ballRadius*deltaAngle*deltaX, y: ball.center.y + ballRadius*deltaAngle*deltaY)
        case (false, false):
            ball.center = CGPoint(x: ball.center.x - ballRadius*deltaAngle*deltaX, y: ball.center.y - ballRadius*deltaAngle*deltaY)
        }
        
        if (ball.center.x <= ballRadius) {
            forwardX = true
            restartDirection()
        } else if (ball.center.x >= self.view.bounds.size.width - ballRadius) {
            forwardX = false
            restartDirection()
        }
        
        if (ball.center.y <= ballRadius) {
            forwardY = true
            restartDirection()
        } else if (ball.center.y >= self.view.bounds.size.height - ballRadius) {
            forwardY = false
            restartDirection()
        }
        
        
        //Rolling Ball forward and backward
//        if (forward) {
//            ball.transform = CGAffineTransform(rotationAngle: radians)
//            ball.center = CGPoint(x: ball.center.x + ballRadius*deltaAngle, y: self.view.bounds.size.height*0.5)
//        } else {
//            ball.transform = CGAffineTransform(rotationAngle: -radians)
//            ball.center = CGPoint(x: ball.center.x - ballRadius*deltaAngle, y: self.view.bounds.size.height*0.5)
//        }
//        
//        if (ball.center.x >= self.view.bounds.size.width - ballRadius) {
//            forward = false
//            radians = 0
//        }
//        if (ball.center.x <= ballRadius) {
//            forward = true
//            radians = 0
//        }

    }

}

