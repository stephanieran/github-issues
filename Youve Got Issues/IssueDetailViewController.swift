//
//  IssueDetailViewController.swift
//  Youve Got Issues
//
//  Created by Stephanie Ran on 1/23/23.
//

import UIKit

class IssueDetailViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var descriptionTextView: UITextView!
    var issue: GithubIssue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let issueToLoad = issue {
            titleLabel.text = issueToLoad.title
            usernameLabel.text = "USER: @" + issueToLoad.user.login
            descriptionTextView.text = issueToLoad.body

            if issueToLoad.state == "closed" {
                iconImageView.image = UIImage(systemName: "checkmark.rectangle.fill")
            } else {
                iconImageView.image = UIImage(systemName: "envelope.open.fill")
            }
            
            // date formatting
            // attribution: https://stackoverflow.com/questions/42524651/convert-nsdate-to-string-in-ios-swift
            let string = issueToLoad.createdAt
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = formatter.date(from: string)!
            formatter.dateFormat = "MMMM d, yyyy"
            dateLabel.text = "DATE: " + formatter.string(from: date)
            
        }
        
    }
    
}
