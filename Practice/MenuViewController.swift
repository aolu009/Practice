//
//  MenuViewController.swift
//  TwitterReMake
//
//  Created by Lu Ao on 8/16/17.
//  Copyright © 2017 Lu Ao. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var optionTableView: UITableView!
    var menuList: [String] = ["Timeline","Mentions","Accounts"]
    var viewControllers: [UIViewController] = []
    var hamburgerViewController: HamburgerViewController?
    var profileNavViewController: UIViewController?
    var timelineViewController: UIViewController?
    var mentionsViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupControllerViews()
    }


    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileOptionTableViewCell") as! ProfileOptionTableViewCell
            cell.profileImage.setImageWith((CurrentUser.currentUser?.profileUrl)!)
            cell.name.text = CurrentUser.currentUser?.name
            cell.screenNameLabel.text = CurrentUser.currentUser?.screenname
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherMenuOptionTableViewCell") as! OtherMenuOptionTableViewCell
            cell.optionLabel.text = menuList[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            tableView.deselectRow(at: indexPath, animated: false)
            hamburgerViewController?.contentViewController = profileNavViewController
            hamburgerViewController?.menuViewController = hamburgerViewController?.tempViewController ?? self
        }else{
            tableView.deselectRow(at: indexPath, animated: false)
            hamburgerViewController?.contentViewController = self.viewControllers[indexPath.row]
            hamburgerViewController?.menuViewController = hamburgerViewController?.tempViewController ?? self
        }
    }
    
    func setupTable(){
        optionTableView.dataSource = self
        optionTableView.delegate = self
        optionTableView.estimatedRowHeight = 300
        optionTableView.rowHeight = UITableViewAutomaticDimension
        optionTableView.layoutIfNeeded()
        optionTableView.reloadData()
    }
    
    func setupControllerViews(){
        let TimelineStoryboard = UIStoryboard(name: "Timeline", bundle: nil)
        profileNavViewController = TimelineStoryboard.instantiateViewController(withIdentifier: "ProfileNavViewController") as! ProfileNavViewController
        let timelineNav = TimelineStoryboard.instantiateViewController(withIdentifier: "ProfileNavViewController") as? ProfileNavViewController
        let mentionNav = TimelineStoryboard.instantiateViewController(withIdentifier: "ProfileNavViewController") as? ProfileNavViewController
        let timelineVc = timelineNav?.topViewController as! ProfileViewController
        let mentionVc = mentionNav?.topViewController as! ProfileViewController
        timelineVc.page = pageType.timeline
        mentionVc.page = pageType.mentions
        timelineViewController = timelineNav
        mentionsViewController = mentionNav
        viewControllers.append(timelineViewController!)
        viewControllers.append(mentionsViewController!)
        viewControllers.append(profileNavViewController!)
        
        hamburgerViewController?.contentViewController = profileNavViewController
        hamburgerViewController?.tempViewController = self
    }
    
    struct pageType{
        static let accountTimeline = "accountTimeline"
        static let userTimeline = "userTimeline"
        static let timeline = "timeline"
        static let mentions = "mentions"
    }
}
