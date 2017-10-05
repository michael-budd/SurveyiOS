//
//  EmojiController.swift
//  Survey
//
//  Created by Michael Budd on 10/5/17.
//  Copyright © 2017 Michael Budd. All rights reserved.
//

import Foundation

class SurveyController {
    
    static let shared = SurveyController()
    
    //MARK: - Source of truth
    var surveys: [Survey] = []
    
    /*
     The empty completion is a great way to notify the caller that you are done running your code. You can complete with an object or an array of objects when the caller needs to access them. Both options give you the benefit of knowing exactly when that function is done runing.This is always nice when you are running async code. Because you dont know how long it will take!
     */
    
    private let baseURL = URL(string: "https://favoriteemoji-363d8.firebaseio.com/")
    
    func putSurvey(with name: String, emoji: String, completion: @escaping(_ success: Bool) -> Void) {
        
        //MARK: - Create an instance of survey
        let survey = Survey(name: name, emoji: emoji)
        
        guard let url = baseURL else { fatalError("Bad URL")}
        
        //MARK: - Build url
        let requestUrl = url.appendingPathComponent(survey.identifier.uuidString).appendingPathExtension("json")
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "PUT"
        request.httpBody = survey.jsonData
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            var success = false
            defer { completion(success) }
            
            if let error = error {
                NSLog("Error \(error): \(error.localizedDescription) in \(#file), \(#function)")
            }
            guard let data = data,
                let responseDataString = String(data: data, encoding: .utf8) else { return }
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Successfully saved data to endpoint")
            }
            self.surveys.append(survey)
            success = true
        }.resume()
    }
    
    func fetchEmoji(completion: @escaping () -> Void) {
        
        guard let url = baseURL?.appendingPathExtension("json") else {
            print("Bad base url")
            completion()
            return 
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error \(error): \(error.localizedDescription)")
                completion()
                return
                }
            guard let data = data else {
                print("No data returned from dataTask")
                completion()
                return
                }
            guard let surveyDictionaries = (try? JSONSerialization.jsonObject(with: data, options: []) as? [String: [String: Any]]) else {
                print("Fetching from JSON oject")
                completion()
                return
            }
            guard let surveys = surveyDictionaries?.flatMap( { Survey(dictionary: $0.value, identifier: $0.key) }) else { return }
            self.surveys = surveys
            completion()
            }.resume()
        }
    
}





