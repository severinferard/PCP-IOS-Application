import UIKit
import os.log

struct Headline {

    var id : Int
    var title : String
    var text : String
    var image : String

}




class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var ImageLabel: UIImageView!
    
}

class EventsTableViewController: UITableViewController {
    
    
    var events = [Event]()
    let defaults = UserDefaults.standard
    
    
    
    
    
    @objc func refresh(sender:AnyObject) {
        var UserID = defaults.string(forKey: defaultsKeys.UserID)
        var UserPassword = defaults.string(forKey: defaultsKeys.UserPassword)
        let dp = DataPipe(userID: UserID!, userPWD: UserPassword!)
        events = dp.GetEvents()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    override func viewDidLoad() {
        var UserID = defaults.string(forKey: defaultsKeys.UserID)
        var UserPassword = defaults.string(forKey: defaultsKeys.UserPassword)
        print("view did load eventVC")
        print(UserID, UserPassword)
        let dp = DataPipe(userID: UserID!, userPWD: UserPassword!)
        super.viewDidLoad()
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        events = dp.GetEvents()
        
    }
    
    


    

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! EventTableViewCell

        let event = events[indexPath.row]
        cell.TitleLabel?.text = event.name
        cell.DateLabel?.text = event.date
        cell.TimeLabel?.text = event.time
        cell.ImageLabel.image = event.image

        return cell
    }
    
    
    
    
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//
//            guard let DetailViewController = segue.destination as? DetailViewController else {
//                fatalError("Unexpected destination: \(segue.destination)")
//            }
//
//            guard let selectedEventCell = sender as? EventTableViewCell else {
//                fatalError("Unexpected sender: \(sender)")
//            }
//
//            guard let indexPath = tableView.indexPath(for: selectedEventCell) else {
//                fatalError("The selected cell is not being displayed by the table")
//            }
//
//            let selectedEvent = events[indexPath.row]
//
//            print("SELECTED MEAL", selectedEvent)
//            print(selectedEvent.name)
//
//        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "ShowDetail"){
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let controller = segue.destination as! DetailsViewController
                controller.selectedEvent = events[indexPath.row]
                print("SELECTED MEAL", events[indexPath.row])
                print(events[indexPath.row].name)
                

        }
    }
    }
    
    
    @IBAction func SettingButton(_ sender: Any) {
        isUserConnected = !isUserConnected
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if isUserConnected{
            let LoggedInViewController = storyBoard.instantiateViewController(withIdentifier: "LoggedInViewController") as! LoggedInViewController
            self.show(LoggedInViewController, sender: sender)
        }
        else {
            let NotLoggedInViewController = storyBoard.instantiateViewController(withIdentifier: "NotLoggedInViewController") as! NotLoggedInViewController
            self.show(NotLoggedInViewController, sender: sender)
        }
    }

}
