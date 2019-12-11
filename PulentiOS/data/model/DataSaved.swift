//
//  DataSaved.swift
//  PulentiOS
//
//  Created by t on 10/12/19.
//  Copyright © 2019 mcordobaf. All rights reserved.
//

import UIKit

class DataSaved: NSObject {

    let keySearchedList:String = "KEY_SEARCHED_LIST"
    
    override init() {
    }
    
    public static func getInstance() -> DataSaved
    {
        return DataSaved()
    }
    
    func getSearchedList() -> [String]!
    {
        var currentSearchedList = UserDefaults.standard.array(forKey: keySearchedList) as? [String]
        if (currentSearchedList == nil){
            currentSearchedList = []
        }
        return currentSearchedList
    }
    
    func addNewTermSearchedToList(term:String){
        var currentList = getSearchedList()
        currentList?.append(term)
        UserDefaults.standard.setValue(currentList, forKey: keySearchedList)
    }
    
    func getSearchByTermAlreadyExists(term:String) -> Data? {
        
        return UserDefaults.standard.data(forKey: term)
    }
    
    func saveDataSearched(term:String, data:Data){
        addNewTermSearchedToList(term: term)
        UserDefaults.standard.setValue(data, forKey: term)
    }
    
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
}
