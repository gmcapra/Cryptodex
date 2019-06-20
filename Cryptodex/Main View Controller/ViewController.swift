//
//  ViewController.swift
//  Cryptodex
//
//  Created by Max Sergent on 6/10/19.
//  Copyright © 2019 toggle. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var header: HeaderView!
    var contacts: ContactsView!
    
    let screen = ScreenDimensions()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        header = HeaderView(dimensions: screen)
        let contactsOrigin = CGPoint(x: 0, y: screen.statusBarHeight + screen.headerHeight)
        let contactsSize = CGSize(width: screen.width, height: screen.tableViewHeight)
        contacts = ContactsView(frame: CGRect(origin: contactsOrigin, size: contactsSize), style: .plain)
        contacts.buildTable(dimensions: screen)
        view.addSubview(header)
        view.addSubview(contacts)
        self.contacts.delegate = self
        self.contacts.dataSource = self
        self.contacts.register(ContactsCell.self, forCellReuseIdentifier: "ContactsCell")

        header.test += 1
        contacts.test += 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = ContactsSection()
        sectionHeader.buildView(dimensions: screen)
        sectionHeader.label.text = contacts.headers[section]
        return sectionHeader
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contacts.wallets.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return screen.headerHeight*(2/3)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ContactsCell = tableView.dequeueReusableCell(withIdentifier: "ContactsCell") as! ContactsCell
        cell.buildView(dimensions: screen)
        cell.cellLabel.text = contacts.wallets[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.wallets[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screen.headerHeight*(3/4)
    }
 
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        print(scrollView.contentOffset.y)
        header.test += 1
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        header.test = 0
        contacts.test = 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        header.test = 1
        contacts.test = 1
    }
    
    
    
}

