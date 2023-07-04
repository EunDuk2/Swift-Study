import UIKit

class SchoolCell: UITableViewCell {
    
    @IBOutlet var lblSchool: UILabel!
    @IBOutlet var studentTable: UITableView!
    
    var section: Int?
    let Sstudent:[String] = ["짱구", "철수", "훈이"]
    let Kstudent:[String] = ["짱아", "유리", "슬기"]
    let Ystudent:[String] = ["형만", "봉선", "흰둥"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        studentTable.delegate = self
        studentTable.dataSource = self
    }
}

extension SchoolCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell") as! StudentCell
        
        if(section == 0) { // 서울대
            cell.lblStudent.text = Sstudent[indexPath.row]
        } else if(section == 1) { // 고려대
            cell.lblStudent.text = Kstudent[indexPath.row]
        } else { // 연세대
            cell.lblStudent.text = Ystudent[indexPath.row]
        }
        
        return cell
    }
}
