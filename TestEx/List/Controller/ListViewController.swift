//
//  ListViewController.swift
//  TestEx
//
//  Created by Александр Шубский on 07.10.2020.
//  Copyright © 2020 Александр Шубский. All rights reserved.
//

import UIKit
import Foundation

class ListViewController: UITableViewController, UITextFieldDelegate{
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var seachButtonNavBar: UIBarButtonItem!
    
    @IBAction func searchTextFieldAction(_ sender: UITextField) {
    }
    
    @IBOutlet var ListTableView: UITableView!
    
    
    var searchBar: String?
    
    var apiKey = "AIzaSyCwgBCwzBlxDVj55OoUmvkIpplClT2taK8"
    
    func performGetRequest(targetURL: URL, completion: @escaping (Data?, _ HTTPStatusCode: Int, Error?) -> Void) {
        var request = URLRequest(url: targetURL)
        request.httpMethod = "GET"
     
        let sessionConfiguration = URLSessionConfiguration.default
     
        let session = URLSession(configuration: sessionConfiguration)
     
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async { () -> Void in
                completion(data, (response as! HTTPURLResponse).statusCode, error)
            }
        })
        
     
        task.resume()
    }

   
    
    
    
    
    
    var videoList: [SearchModel] = []

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async{
            self.ListTableView.reloadData()
        }
        
        
        searchTextField.isHidden = true
        searchTextField.isEnabled = false
        
        self.searchTextField.delegate = self
        
        
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard videoList.isEmpty == false else {
            return 1
        }
        
        return videoList.count
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let listCell = tableView.dequeueReusableCell(withIdentifier: "video", for: indexPath) as? ListViewCell
        
        guard let tableViewCell = listCell else {
            return UITableViewCell()
        }
        
        
        tableViewCell.videoNameText?.font = UIFont.systemFont(ofSize: 15)
        tableViewCell.videoNameText?.numberOfLines = 0
        

        
        
        
        guard self.videoList.isEmpty != true else {
            
            tableViewCell.videoNameText?.text = "Вы ничего не искали"
            tableViewCell.videoNameText?.textAlignment = .center
            tableViewCell.videoImage?.isHidden = true
            tableViewCell.selectionStyle = .none
            tableViewCell.accessoryType = .none
            
            return tableViewCell
        }
        
        let result = self.videoList[indexPath.row]
        
        print(result.id)
        
        tableViewCell.videoNameText?.text = "\(result.videoName)"
        
        

        return tableViewCell
    }

    @IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
        searchTextField.clearsOnBeginEditing = true
        searchTextField.isHidden = false
        searchTextField.isEnabled = true
        searchTextField.becomeFirstResponder()
        seachButtonNavBar.isEnabled = false
    }
    
    
    
    func searchVideo() -> String{
        let searchText = searchTextField.text
        
        return searchText ?? ""
    }
    
    
    func textFieldShouldReturn(_ searchBar: UITextField) -> Bool {
        var text = searchVideo()
        
        text = text.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        
        let url = ReturnLink.returnSearchLink(text: text)
        
        let targetURL = URL(string: url)!
        
        performGetRequest(targetURL: targetURL) { [self] (data, HTTPStatusCode, error) in
            do {
                if HTTPStatusCode == 200, error == nil {
                    let resultsDict = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: AnyObject]

                    let items: Array<[String: AnyObject]> = resultsDict["items"] as! Array<[String: AnyObject]>

                    for item in items {
                        let idInfoDict = item["id"] as! [String: AnyObject]

                        let videoID = idInfoDict["videoId"] as! String

                        let snippetDict = item["snippet"] as! [String: AnyObject]

                        let title = snippetDict["title"] as! String

                        
                        let thumbnailsDict = snippetDict["thumbnails"] as! [String: AnyObject]

                        let mediumImageDict = thumbnailsDict["medium"] as! [String: AnyObject]

                        let videoImageUrl = mediumImageDict["url"] as! String

                        
                        let cellContent = SearchModel(videoImageURL: videoImageUrl, videoName: title, id: videoID)
//                        print (cellContent)
                        self.videoList.append(cellContent)
                        
                    }
                    print(self.videoList)
                }
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
                
            }
            
        }
        
        
        

        
        searchTextField.isHidden = true
        searchTextField.isEnabled = false
        seachButtonNavBar.isEnabled = true
        searchTextField.resignFirstResponder()
        self.searchTextField.endEditing(true)
        
        return false
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

extension UIImage {
  convenience init?(url: URL?) {
    guard let url = url else { return nil }
            
    do {
      self.init(data: try Data(contentsOf: url))
    } catch {
      print("Cannot load image from url: \(url) with error: \(error)")
      return nil
    }
  }
}
