//
//  MainViewController.swift
//  Tetris
//
//  Created by jim on 16/5/4.
//  Copyright © 2016年 jim. All rights reserved.
//

import UIKit
import AVFoundation


class MainViewController: UIViewController, GameViewDelegate, SnappingSliderDelegate {
    
    
    let MARGINE: CGFloat = 10
    let BUTTON_SIZE: CGFloat = 44
    let BUTTON_ALPHA: CGFloat = 0.4
    let TOOLBAR_HEIGHT: CGFloat = 44
    var numberLabel: CGFloat = 0
    var screenWidth: CGFloat!
    var screenHight: CGFloat!
    var gameView: GameView!
    //定义背景音乐的播放器
    var bgMusicPlayer: AVAudioPlayer!
    //定义显示当前速度UILabel
    var speedShow: UILabel!
    //定义显示当前积分的UILabel
    var scoreShow: UILabel!
    //frame尺寸
    let rect = UIScreen.mainScreen().bounds
//    //定义音乐是否播放
//    var isPlaying = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        screenWidth = rect.size.width
        screenHight = rect.size.height
        //添加工具条
        addToolBar()
        //创建GameView控件
        gameView = GameView(frame: CGRectMake(rect.origin.x + MARGINE, rect.origin.y + TOOLBAR_HEIGHT + MARGINE * 2, rect.size.width - MARGINE * 2, rect.size.height - 80))
        //添加绘制游戏状态的自定义View
        self.view.addSubview(gameView)
        gameView.delegate = self
        //开始游戏
        gameView.startGame()
        //添加游戏控制按钮
        addButtons()
        //获取背景音乐的音频文件URL
        let bgMusicURL = NSBundle.mainBundle().URLForResource("background", withExtension: "mp3")
        //创建AVAudioPlayer对象
        bgMusicPlayer = try! AVAudioPlayer(contentsOfURL: bgMusicURL!)
        bgMusicPlayer.numberOfLoops = -1
        //准备播放音乐
        bgMusicPlayer.prepareToPlay()
        //播放音效
        bgMusicPlayer.play()
        bgMusicPlayer.volume = 0.0
        gameView.alertCon = alertController
    }


    
    //定义在程序顶部添加工具条的方法
    func addToolBar(){
        let toolBar = UIToolbar(frame: CGRectMake(0, MARGINE*2, screenWidth, TOOLBAR_HEIGHT))
        self.view.addSubview(toolBar)
        //创建第一个显示“速度：”标签
        let speedLabel = UILabel(frame: CGRectMake(0, 0, 80, TOOLBAR_HEIGHT))
        speedLabel.text = "Speed："
        let speedLabelItem = UIBarButtonItem(customView: speedLabel)
        //创建第二个显示速度值的标签
        speedShow = UILabel(frame: CGRectMake(0, 0, 20, TOOLBAR_HEIGHT))
        speedShow.textColor = UIColor.redColor()
        let speedShowItem = UIBarButtonItem(customView: speedShow)
        //创建第三个显示“当前积分：”的标签
        let scoreLabel = UILabel(frame: CGRectMake(0, 0, 120, TOOLBAR_HEIGHT))
        scoreLabel.text = "CurrentScore："
        let scoreLabelItem = UIBarButtonItem(customView: scoreLabel)
        //创建第四个显示积分值得标签
        scoreShow = UILabel(frame: CGRectMake(0, 0, 40, TOOLBAR_HEIGHT))
        scoreShow.textColor = UIColor.redColor()
        let scoreShowItem = UIBarButtonItem(customView: scoreShow)
        let flexItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        //为工具条设置工具项
        toolBar.items = [speedLabelItem, speedShowItem, flexItem, scoreLabelItem,scoreShowItem]
        
    }
    
    //定义添加控制按钮的方法
    func addButtons(){
        //添加向左的按钮
        var leftBn = UIButton(type: UIButtonType.Custom) as UIButton
        leftBn = UIButton(frame: CGRectMake(screenWidth - BUTTON_SIZE * 3 - MARGINE, screenHight - BUTTON_SIZE - MARGINE, BUTTON_SIZE, BUTTON_SIZE))
        leftBn.alpha = BUTTON_ALPHA
        leftBn.setImage(UIImage(named: "Left"), forState: .Normal)
        leftBn.setTitle("L", forState: .Highlighted)
        leftBn.addTarget(self, action: Selector("left:"), forControlEvents: .TouchUpInside)
        self.view.addSubview(leftBn)
        //添加向下的按钮
        var downBn = UIButton(type: .Custom) as UIButton
        downBn = UIButton(frame: CGRectMake(screenWidth - BUTTON_SIZE * 2 - MARGINE, screenHight - BUTTON_SIZE - MARGINE, BUTTON_SIZE, BUTTON_SIZE))
        downBn.alpha = BUTTON_ALPHA
        downBn.setImage(UIImage(named: "Down"), forState: .Normal)
        downBn.setTitle("D", forState: .Highlighted)
        downBn.addTarget(self, action: Selector("down:"), forControlEvents: .TouchUpInside)
        self.view.addSubview(downBn)
        //添加向右的按钮
        var rightBn = UIButton(type: .Custom) as UIButton
        rightBn = UIButton(frame: CGRectMake(screenWidth - BUTTON_SIZE * 1 - MARGINE, screenHight - BUTTON_SIZE - MARGINE, BUTTON_SIZE, BUTTON_SIZE))
        rightBn.alpha = BUTTON_ALPHA
        rightBn.setImage(UIImage(named: "Right"), forState: .Normal)
        rightBn.setTitle("R", forState: .Highlighted)
        rightBn.addTarget(self, action: Selector("right:"), forControlEvents: .TouchUpInside)
        self.view.addSubview(rightBn)
        //添加向上的按钮
        var upBn = UIButton(type: .Custom) as UIButton
        upBn  = UIButton(frame: CGRectMake(screenWidth - BUTTON_SIZE * 2 - MARGINE, screenHight - BUTTON_SIZE * 2 - MARGINE, BUTTON_SIZE, BUTTON_SIZE))
        upBn.alpha = BUTTON_ALPHA
        upBn.setImage(UIImage(named: "Up"), forState: .Normal)
        upBn.setTitle("U", forState: .Highlighted)
        upBn.addTarget(self, action: Selector("up:"), forControlEvents: .TouchUpInside)
        self.view.addSubview(upBn)
        
//        //背景音乐控制器
//        var musicBn = UIButton()
//        musicBn = UIButton(frame: CGRectMake(screenWidth - BUTTON_SIZE * 7 - MARGINE, screenHight - BUTTON_SIZE  - MARGINE - 17.0, BUTTON_SIZE, BUTTON_SIZE))
//        musicBn.alpha = BUTTON_ALPHA
//        musicBn.setImage(UIImage(named: "bgmusic"), forState: .Normal)
//        musicBn.setTitle("music", forState: .Highlighted)
//        musicBn.addTarget(self, action: Selector("music:"), forControlEvents: .TouchUpInside)
//        self.view.addSubview(musicBn)
        
        //返回按钮
        var disBn = UIButton()
        disBn = UIButton(frame: CGRectMake(screenWidth - BUTTON_SIZE * 8 - MARGINE, screenHight - BUTTON_SIZE  - MARGINE , BUTTON_SIZE, BUTTON_SIZE))
        disBn.alpha = BUTTON_ALPHA
        disBn.setImage(UIImage(named: "bgmusic"), forState: .Normal)
        disBn.setTitle("dis", forState: .Highlighted)
        disBn.addTarget(self, action: Selector("disBu:"), forControlEvents: .TouchUpInside)
        self.view.addSubview(disBn)
        
        //定义slider
        let snappingSlider = SnappingSlider(frame: CGRectMake(screenWidth - BUTTON_SIZE * 6.5 - MARGINE, screenHight - BUTTON_SIZE  - MARGINE, 120, BUTTON_SIZE), title: "music")
        snappingSlider.delegate = self
        self.view.addSubview(snappingSlider)
    }
    
    //alertController
    func alertController() -> Void{
        let alertController = UIAlertController(title: "游戏结束", message: "游戏已经结束，请问是否重新开始", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "否", style: .Cancel, handler: {
            (UIAlertAction) -> Void in
            print("你点击了否")
            self.bgMusicPlayer.pause()
            self.dismissViewControllerAnimated(false, completion: nil)
        })
        let okAction = UIAlertAction(title: "是", style: .Default, handler: {
            (UIAlertAction) -> Void in
            print("你点击了是")
            //保存分数
            score.addObject(self.gameView.curScore)
            //日期和字符串的转换
            let dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yy//MM//dd HH:mm:ss"
            //获取当前时间
            let d: NSDate = NSDate()
            let date: NSString = dateFormatter.stringFromDate(d)
            //保存时间
            time.addObject(date)
            self.gameView.startGame()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: false, completion: nil)

    }
    
    //MARK: 点击事件
    
    func disBu(sender: UIButton!){
        self.bgMusicPlayer.pause()
        self.dismissViewControllerAnimated(false, completion: nil)
     }
    
    func left(button: UIButton!){
        //print("Left")
        gameView.moveLeft()
    }
    
    func right(button: UIButton!){
        //print("Right")
        gameView.moveRight()
    }
    
    func up(button: UIButton!){
        //print("Up")
        gameView.rotate()
    }
    
    func down(button: UIButton!){
        //print("Down")
        gameView.moveDown()
    }
    
//    func music(button: UIButton!){
//        if isPlaying {
//            //准备播放音乐
//            bgMusicPlayer.prepareToPlay()
//            //播放音效
//            bgMusicPlayer.play()
//            isPlaying = false
//        }else{
//            bgMusicPlayer.pause()
//            isPlaying = true
//        }
//
//    }
    
    //协议方法
    func updateSpeed(speed: Int) {
        //更新显示当前速度的UILabel控件上的文字
        self.speedShow.text = "\(speed)"
    }
    func updateScore(score: Int) {
        //更新显示当前积分的UILabel控件上的文字
        self.scoreShow.text = "\(score)"
    }


    //滑块方法
    func snappingSliderDidDecrementValue(slider: SnappingSlider) {
        numberLabel = max(0.0, numberLabel-0.05)
        bgMusicPlayer.volume = Float(numberLabel)
        //print("-")
    }
    
    func snappingSliderDidIncrementValue(slider: SnappingSlider) {
        numberLabel = max(numberLabel+0.05, 1.0)
        bgMusicPlayer.volume = Float(numberLabel)
        //print("+")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
