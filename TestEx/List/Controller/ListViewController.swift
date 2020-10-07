//
//  ListViewController.swift
//  TestEx
//
//  Created by Александр Шубский on 07.10.2020.
//  Copyright © 2020 Александр Шубский. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    var videoList: [CellModel]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        videoList = [CellModel(videoImageLink: "www.vk.com", videoName: "Music"),
                     CellModel(videoImageLink: "youtube.com", videoName: "Clip")]
       
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard videoList != nil else {
            
            return 1
        }
        
        return videoList!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "video", for: indexPath) as? ListViewCell
        
        guard let tableViewCell = cell else {
            return UITableViewCell()
        }
        
        let result = videoList?[indexPath.row]
        
        guard videoList != nil else {
            
            tableViewCell.videoNameText?.text = "Вы еще ничего не искали"
            tableViewCell.accessoryType = .none
            tableViewCell.imageView?.isHidden = true
            
            return tableViewCell
        }
        
        tableViewCell.videoNameText?.text = "\(result!.videoName)"
        

        return tableViewCell
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
