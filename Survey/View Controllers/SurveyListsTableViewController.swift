//
//  SurveyListsTableViewController.swift
//  Survey
//
//  Created by Michael Budd on 10/5/17.
//  Copyright © 2017 Michael Budd. All rights reserved.
//

import UIKit

class SurveyListsTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        SurveyController.shared.fetchEmoji {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SurveyController.shared.surveys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        
        let survey = SurveyController.shared.surveys[indexPath.row]
        
        cell.textLabel?.text = survey.name
        cell.detailTextLabel?.text = survey.emoji
        
        return cell
    }
    

}
