//
//  EventTableViewController.swift
//  PCPApp-V0.3
//
//  Created by Séverin FERARD on 25/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import UIKit
import os.log

class DetailsViewController: UIViewController {
    
    var selectedEvent: Event?
    var tableController: PersonnelsTableViewController?
    
    @IBOutlet weak var EventTitle: UILabel!
    @IBOutlet weak var EventType: UILabel!
    @IBOutlet weak var EventID: UILabel!
    @IBOutlet weak var EventDateTime: UILabel!
    @IBOutlet weak var EventTotalDuration: UILabel!
    @IBOutlet weak var EventPlace: UILabel!
    @IBOutlet weak var PersonnelContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")
        
        if let selectedEvent = selectedEvent {
            EventTitle.text = "\(selectedEvent.name)"
            EventType.text = selectedEvent.type
            EventID.text = "n°\(selectedEvent.eventNumber)"
            
            if (selectedEvent.dates_et_heures != nil) {
                EventDateTime.text = "Le \(selectedEvent.dates_et_heures ?? "")"
            }
            else {EventDateTime.text = "Durée totale non renseignée"}

            EventTotalDuration.text = "Durée: \(selectedEvent.duree_totale ?? "Non renseigné")"

            EventPlace.text = "Lieu: \(selectedEvent.lieu ?? "Non renseigné")"
            for p in selectedEvent.personnels{
                print(p?.name)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.selectedEvent?.getInfo()
        
        if let personnels = self.selectedEvent?.personnels {
            print("prepare", personnels)
            let tableController = segue.destination as! PersonnelsTableViewController
            tableController.personnels = personnels
            tableController.view.translatesAutoresizingMaskIntoConstraints = false
            self.tableController = tableController
        }
//        print("BIG TEST", self.tableController!.tableView.contentSize.height)
    }
}

class PersonnelsTableViewController: UITableViewController {
    
    var personnels: [Personnel?]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personnels?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonnelCell", for: indexPath) as! DetailsTableViewCell
        
        if let personnels = personnels {
            let personnel = personnels[indexPath.row]
            cell.NameLabel.text = personnel?.name
            cell.RoleLabel.text = personnel?.role
        }
        return cell
    }
    
}

class DetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var RoleLabel: UILabel!
    
}

