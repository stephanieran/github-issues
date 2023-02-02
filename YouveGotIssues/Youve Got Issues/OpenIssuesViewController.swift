//
//  OpenIssuesViewController.swift
//  Youve Got Issues
//
//  Created by Stephanie Ran on 1/23/23.
//

import UIKit

class OpenIssuesViewController: UITableViewController {
    
    @IBOutlet weak var table: UITableView!
    var issuesArr = [GithubIssue]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // customizing navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .red
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        title = "Open Issues"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // fetching github issues
        GitHubClient.fetchIssues(state: "open", completion: { (issues, error) in
            
            guard let issues = issues, error == nil else {
              print(error!)
              return
            }
          
            for issue in issues {
                self.issuesArr.append(issue)
            }
          
            self.table.reloadData()
            
        })
        
        // pull to refresh
        if #available(iOS 10.0, *) {
            let refreshControl = UIRefreshControl()
            let title = NSAttributedString("Pull To Refresh")
            refreshControl.attributedTitle = title
            refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
            self.table.refreshControl = refreshControl
        }
        
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        print("done refreshing")
        sender.endRefreshing()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.issuesArr.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! IssueTableViewCell

        cell.titleLabel.text = issuesArr[indexPath.row].title
        cell.iconImageView.image = UIImage(systemName: "envelope.open.fill")
        cell.usernameLabel.text = "@" + issuesArr[indexPath.row].user.login
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;//Choose your custom row height
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? IssueDetailViewController {
            vc.issue = issuesArr[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    

}
