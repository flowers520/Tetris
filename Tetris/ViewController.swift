//
//  ViewController.swift
//  Tetris
//
//  Created by jim on 16/4/24.
//  Copyright © 2016年 jim. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    //定义Rect
    let screen = UIScreen.mainScreen().bounds
    //定义设置
    var bgImage: UIImageView!
    var startButton: UIButton!
    var voiceButton: UIButton!
    var scoreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUp()
    }
    
    func setUp(){
        //背景
        bgImage = UIImageView(frame: CGRectMake(0, 0, screen.width, screen.height))
        bgImage.image = UIImage(named: "Icon1.jpg")
        self.view.addSubview(bgImage)
        
        //开始游戏
        startButton = UIButton(frame: CGRectMake(screen.width/2, screen.height/5*1, 160, 20))
        startButton.setTitle("Start Game", forState: .Normal)
        startButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        startButton.setTitle("gay is girl", forState: .Highlighted)
        startButton.titleLabel?.font = UIFont.systemFontOfSize(30.0)
        startButton.setTitleColor(UIColor.blackColor(), forState: .Highlighted)
        startButton.addTarget(self, action: Selector("buttonStart:"), forControlEvents: .TouchUpInside)
        self.view.addSubview(startButton)
        
        //分数
        scoreButton = UIButton(frame: CGRectMake(screen.width/2, screen.height/5*2, 160, 20))
        scoreButton.setTitle("Score", forState: .Normal)
        scoreButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        scoreButton.titleLabel?.font = UIFont.systemFontOfSize(30.0)
        scoreButton.addTarget(self, action: Selector("buttonScore:"), forControlEvents: .TouchUpInside)
        self.view.addSubview(scoreButton)
    }

    //MARK: 点击事件
    //开始游戏
    func buttonStart(sender: UIButton!){
        let startController = MainViewController()
        self.presentViewController(startController, animated: false, completion: nil)
        
    }
    //分数
    func buttonScore(sender: UIButton!){
        let scoreController = ScoreViewController()
        self.presentViewController(scoreController, animated: false, completion: nil)
    }
}

