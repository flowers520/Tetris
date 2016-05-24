//
//  ScoreViewController.swift
//  Tetris
//
//  Created by jim on 16/5/12.
//  Copyright © 2016年 jim. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //设置背景图
    var bg: UIImageView!
    //定义屏幕矩形
    let screen = UIScreen.mainScreen().bounds
    
    var label: UILabel!
    var tableView: UITableView!
    var viewExit: UIView!
    var buttonExit: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }

    func setup(){
        bg = UIImageView(frame: CGRectMake(0, 0, screen.width, screen.height))
        bg.image = UIImage(named: "Icon2.jpg")
        self.view.addSubview(bg)
        
        //setup label
        label = UILabel(frame: CGRectMake(0, 0, screen.width, 60))
        label.font = UIFont.systemFontOfSize(29.0)
        label.textAlignment = NSTextAlignment.Center
        label.text = "分数栏"
        label.textColor = UIColor.whiteColor()
        self.view.addSubview(label)
        
        //setup TableView
        tableView = UITableView(frame: CGRectMake(0, 70, screen.width, screen.height-140))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(tableView)
        
        //setup View exit
        viewExit = UIImageView(frame: CGRectMake(0, screen.height-60, screen.width, 60))
        viewExit.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        self.view.addSubview(viewExit)
        
        buttonExit = UIButton(frame: CGRectMake((screen.width-60)/2, screen.height-55, 60, 50))
        buttonExit.setTitle("返回", forState: UIControlState.Normal)
        buttonExit.titleLabel?.font = UIFont.systemFontOfSize(30.0)
        buttonExit.setTitleColor(UIColor.blueColor(), forState: .Normal)
        //buttonExit.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        buttonExit.addTarget(self, action: Selector("exitButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(buttonExit)

    }

    
    //setup buttonExit
    func exitButton(sender: UIButton!){
        print("listViewController")
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    //返回节数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //返回行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(score.count)
        return score.count
        
    }
    //返回表视图的表单元格
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier: NSString = "Cell"
//        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(CellIdentifier as String)! as UITableViewCell
        var cell: UITableViewCell = UITableViewCell(style: .Subtitle, reuseIdentifier: CellIdentifier as String)
        //判断表格 是否为空
        if(cell == ""){
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: CellIdentifier as String)
            cell.backgroundColor = UIColor.clearColor()
            cell.detailTextLabel?.textColor = UIColor.blackColor()
        }
        print("table-row:\(indexPath.row)")
        print(score.objectAtIndex(indexPath.row))
        
        cell.textLabel?.text = "分数: \(score.objectAtIndex(indexPath.row))"
        cell.detailTextLabel?.text = "时间: \(time.objectAtIndex(indexPath.row))"
        
        print(score, time)
        return cell
    }
    //滑动删除必须实现方法
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        print("删除\(indexPath.row)")
        score.removeObjectAtIndex(indexPath.row)
        time.removeObjectAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
    }
    
    //滑动删除
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    //修改删除按钮文字
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删"
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
