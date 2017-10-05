//
//  SurveyViewController.swift
//  Survey
//
//  Created by Michael Budd on 10/5/17.
//  Copyright © 2017 Michael Budd. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emojiTextField: UITextField!
    
    //MARK: - Actions
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        guard let name = nameTextField.text,
            let emoji = emojiTextField.text,
            name != "",
            !emoji.isEmpty else { return }
    
        SurveyController.shared.putSurvey(with: name, emoji: emoji, completion: ({ (success) in
            guard success else { return }
            
            DispatchQueue.main.async {
                self.nameTextField.text = ""
                self.emojiTextField.text = ""
            }
        }))
    }
}
