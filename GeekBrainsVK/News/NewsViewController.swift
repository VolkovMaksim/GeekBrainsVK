//
//  NewsViewController.swift
//  GeekBrainsVK
//
//  Created by Maksim Volkov on 19.02.2022.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var news = LocalNews.loadTestNews()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    

}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let localNews = news[indexPath.section]
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderViewCell
            cell.authorsName.text = localNews.nameAuthor
            cell.authorsPhoto.image = UIImage(systemName: localNews.photoAuthor)!
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsViewCell
            cell.newsText.text = localNews.textNews
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath) as! PhotosViewCell
            cell.newsImage.image = UIImage(systemName: localNews.photoNews)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RatingsCell", for: indexPath) as! RatingsViewCell
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}
