//
//  HomeViewController.swift
//  PulentiOS
//
//  Created by t on 10/12/19.
//  Copyright © 2019 mcordobaf. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, RequestListener {
    
    private let itunesDAO:ItunesDAO = ItunesDAO.getInstance()
    private var searchedText:String = ""
    
    @IBOutlet var buttonSearch: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.accessibilityIdentifier = "tableViewSearchedTerms"
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()
    }
    
    @IBAction func SearchClick(_ sender: Any) {
        searchedText = searchTextField.text!
        if (searchedText != ""){
            if (dataSaved.isKeyPresentInUserDefaults(key: searchedText)){
               self.performSegue(withIdentifier: "goToSongList", sender: nil)
            }
            else{
                itunesDAO.searchByTerm(term: searchedText, pagination: 20, listener: self)
            }
        }
        else{
            showMessage(message: "You must enter a song to Search")
        }
    }
    
    private func showMessage(message:String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func respond(data: Data?) {
        if (data != nil){
            dataSaved.saveDataSearched(term: searchedText, data: data!)
            
            DispatchQueue.main.async() {
                self.performSegue(withIdentifier: "goToSongList", sender: nil)
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSongList" {
            let nextController:SongsTableViewController = segue.destination as! SongsTableViewController
            nextController.termSearched = searchedText
        }
    }
    
    func error(error: Error) {
        if (error.localizedDescription.contains("500")){
            showMessage(message: "Term not found")
        }else{
            showMessage(message: "Error searching the song")
        }
        
        //Must to show an error
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SearchedTermTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellSearched", for: indexPath) as! SearchedTermTableViewCell
        
        if (dataSaved.getSearchedList() != nil && dataSaved.getSearchedList()!.count > 0){
            cell.termSearchedLabel!.text = dataSaved.getSearchedList()[indexPath.item]
            cell.accessibilityIdentifier = "cellSearchedTerm_\(indexPath.row)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (dataSaved.getSearchedList() != nil && dataSaved.getSearchedList()!.count > 0){
            return dataSaved.getSearchedList()!.count
        }else{
            return 0
        }
        // #warning Incomplete implementation, return the number of rows
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (dataSaved.getSearchedList() != nil && dataSaved.getSearchedList()!.count > 0){
            searchedText = dataSaved.getSearchedList()[indexPath.item]
            self.performSegue(withIdentifier: "goToSongList", sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Last searched terms"
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
