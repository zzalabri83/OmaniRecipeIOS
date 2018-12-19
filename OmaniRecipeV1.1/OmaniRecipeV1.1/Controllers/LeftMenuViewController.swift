//
//  LeftMenuViewController.swift
//  AKSideMenuSimple
//
//  Created by Diogo Autilio on 6/7/16.
//  Copyright © 2016 AnyKey Entertainment. All rights reserved.
//

import UIKit

public class LeftMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //var tableView: UITableView?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        //let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let image = UIImage(named: "Balloon")
        imgProfile.image = image
        //circular
        imgProfile.layer.cornerRadius = imgProfile.frame.size.width / 2;
        imgProfile.clipsToBounds = true;
        //brder
        let red = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        imgProfile.layer.borderWidth = 3.0
        imgProfile.layer.borderColor = red.cgColor
        
        //self.view.addSubview(imageView)
        
        
        
        //let tableView = UITableView(frame: CGRect(x: 0, y: (self.view.frame.size.height - 54 * 5) / 2.0, width: self.view.frame.size.width, height: 54 * 5), style: .plain)
        
        
        tableView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleWidth]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isOpaque = false
        tableView.backgroundColor = .clear
        tableView.backgroundView = nil
        tableView.separatorStyle = .none
        tableView.bounces = false

        //self.tableView = tableView
        //self.view.addSubview(self.tableView!)
        
    }

    // MARK: - <UITableViewDelegate>

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "HomeViewController")), animated: true)
            self.sideMenuViewController!.hideMenuViewController()

        case 1:
            //self.performSegue(withIdentifier: "recipeDetails", sender: nil)
            //self.navigationController?.pushViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "secondViewController")), animated: true)
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "secondViewController")), animated: true)
            self.sideMenuViewController!.hideMenuViewController()

        default:
            break
        }
    }

    // MARK: - <UITableViewDataSource>

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection sectionIndex: Int) -> Int {
        return 5
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "Cell"

        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)

        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
            cell!.backgroundColor = .clear
            cell!.textLabel?.font = UIFont(name: "HelveticaNeue", size: 21)
            cell!.textLabel?.textColor = .white
            cell!.textLabel?.highlightedTextColor = .lightGray
            cell!.selectedBackgroundView = UIView()
        }

        var titles = ["Home", "Calendar", "Profile", "Settings", "Log Out"]
        var images = ["IconHome", "IconCalendar", "IconProfile", "IconSettings", "IconEmpty"]
        cell!.textLabel?.text = titles[indexPath.row]
        cell!.imageView?.image = UIImage(named: images[indexPath.row])

        return cell!
    }
}
