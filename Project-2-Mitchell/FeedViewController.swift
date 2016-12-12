//
//  FeedViewController.swift
//  Project-2-Mitchell
//
//  Created by Alex Mitchell on 2016-12-07.
//  Copyright © 2016 Alex Mitchell. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

   var articles = [Article]()
    
    @IBOutlet weak var feedTableView: UITableView!
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = feedTableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        
//        cell.layer.cornerRadius = 10
//        cell.contentView.layer.masksToBounds = true
//        
//        cell.contentView.layer.cornerRadius = 10
//        cell.contentView.layer.masksToBounds = true
        
        cell.articleImage.layer.cornerRadius = 8
        cell.articleImage.layer.masksToBounds = true
        
        cell.gradientOverlay.layer.cornerRadius = 8
        cell.gradientOverlay.layer.masksToBounds = true
        
            
        fetchImage(stringURL: articles[indexPath.row].urlToImage) { result in
            cell.articleImage.image = result
        }

        
        cell.titleLabel.text = articles[indexPath.row].title
        cell.publishedAtLabel.text = articles[indexPath.row].publishedAt
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.edgesForExtendedLayout = .top

        fetchData(closure: { data in
            
            self.feedTableView.reloadData()
        
        })

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchData(closure: @escaping ([Article?]) -> ()) {
        
        let endpoint = "https://newsapi.org/v1/articles?source=bbc-news&sortBy=top&apiKey=ad1d0f68b521404998548d5368f50b4e"
        
        let url = URLRequest(url: URL(string: endpoint)!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { (data, response, error) in
            
            // TODO: add error handling
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
                    
                    
                    let articlesJSON = json["articles"] as! [[String: Any]]
                    
                    for articleJSON in articlesJSON {
                        
                        let article = Article(jsonObject: articleJSON)
                        self.articles.append(article)
                        print(articleJSON)
                        
                        // TODO create article from articleJSON
                        // append to [Articles]
                        
                    }
                    DispatchQueue.main.async {
                        closure(self.articles)
                    }
                }
                
            } catch {
                print(error)
            }
            
           
        }
        task.resume()
    }
    
    func fetchImage(stringURL: String, completionHandler: @escaping (UIImage?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            let url = URL(string: stringURL)!
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                guard let responseData = data else {
                    completionHandler(nil)
                    return
                }
                
                let image = UIImage(data: responseData)
                DispatchQueue.main.async {
                    completionHandler(image)
                    
                }
            }.resume()
        }
    }
}
