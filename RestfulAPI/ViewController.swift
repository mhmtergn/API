//
//  ViewController.swift
//  RestfulAPI
//
//  Created by Mehmet Ergün on 2022-08-03.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://hackingwithswift.com/samples/petitions-1.json"
        }else {
            urlString = "https://hackingwithswift.com/samples/petitions-2.json"

        }
        
        
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                //We are OK to parse
                parse(json: data)
                return
            }
        }
        
        errorAlert(titleInput: "Loading Error", messageInput: "There was a problem looading the feed. Please check your connection or try again.", actionTitle: "OK")
        
        
    }
    
    func errorAlert(titleInput: String, messageInput: String, actionTitle: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = petitions[indexPath.row].title.uppercased()
        cell.detailTextLabel?.text = petitions[indexPath.row].body
        cell.detailTextLabel?.textAlignment = .center
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc  = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    enum Url: String {
        case head = "https://"
        case body = "api.whitehouse.gov"
        case tail = "/v1/petitions.json?limit=100"
    }


}

