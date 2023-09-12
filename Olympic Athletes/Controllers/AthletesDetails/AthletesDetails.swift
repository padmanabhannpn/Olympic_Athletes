//
//  AthletesDetails.swift
//  Olympic Athletes
//
//  Created by PADMANABHAN on 11/09/23.
//

import UIKit

class AthletesDetails: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var getAthletesDetails : AthletesDetailsModel? = nil
    var getAthletesResult : [AthletesResult]? = nil
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mBackView: UIView!
    
    @IBOutlet weak var mAthletesDetailsTabel: UITableView!
    //  @IBOutlet weak var BioLbl: UILabel!
    var Athleteid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if ConnectionCheck.isConnectedToNetwork()
        {
            GlobalSettings.startLoader(view: self.view)
            self.callAthletesDetailsAPI()
        }
        else
        {
            let alert = UIAlertController(title: "", message: "Please Check Your Internet Connection", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.mBackView.addGestureRecognizer(tap)
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        navigationController?.popViewController(animated: true)
    }
    
    func callAthletesDetailsAPI(){
        AthletesDetailsViewModel().getAthletesDetails(url: mAthletesDetails+"\(self.Athleteid)") { result in
            switch result{
            case .success(let data):
                
                self.getAthletesDetails = data ?? nil
                
                DispatchQueue.main.async {
                    
                    self.callAthletesResultAPI()
                    self.mTitle.text = self.getAthletesDetails?.name ?? ""
                    
                }
                
            case .failure(let error):
                GlobalSettings.hideLoader(view: self.view)
                print(error.localizedDescription)
            }
        }
    }
    
    func callAthletesResultAPI(){
        
        AthletesDetailsViewModel().getAthletesResult(url: mAthletesDetails+"\(self.Athleteid)"+"/results") { result in
            switch result{
            case .success(let data):
              
                self.getAthletesResult = data ?? nil
                DispatchQueue.main.async {
                    
                    GlobalSettings.hideLoader(view: self.view)
                    self.mAthletesDetailsTabel.delegate = self
                    self.mAthletesDetailsTabel.dataSource = self
                    self.mAthletesDetailsTabel.tableFooterView = UIView()
                    
                    self.mAthletesDetailsTabel.reloadData()
                }
                
            case .failure(let error):
                GlobalSettings.hideLoader(view: self.view)
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if(section == 0)
        {
            return 1
        }
        if(section == 1)
        {
            return 1
        }
        else if(section == 2)
        {
            return self.getAthletesResult!.count
        }
        else if(section == 3)
        {
            return 1
        }
        else if(section == 4)
        {
            return 1
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(indexPath.section == 0)
        {
            return 140
        }
        else if(indexPath.section == 1)
        {
            return 40
        }
        else if(indexPath.section == 2)
        {
            return 40
        }
        else if(indexPath.section == 3)
        {
            return 40
        }
        else if(indexPath.section == 4)
        {
            return UITableView.automaticDimension
        }
        
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AthletesDetailsCellID", for: indexPath) as! AthletesDetailsCell
            
            cell.contentView.backgroundColor = UIColor(red: 209/255, green: 211/255, blue: 212/255, alpha: 1)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            cell.NameLbl.text =   "Name  : " + (self.getAthletesDetails?.name ?? "")
            cell.DOBLbl.text =    "DOB    : " + (self.getAthletesDetails?.dateOfBirth ?? "")
            cell.WeigthLbl.text = "Weight : " + "\(self.getAthletesDetails?.weight ?? 0)" + "kg"
            cell.HeigthLbl.text = "Height  : " + "\(self.getAthletesDetails?.height ?? 0)" + "cm"
            
            
            
            let url = URL(string: mAthletesDetails + "\(self.Athleteid)/photo")
            cell.UserImage.kf.setImage(with: url)
            
            
            return cell
        }
        else  if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MedalsTitleCellID", for: indexPath) as! MedalsTitleCell
            
            cell.contentView.backgroundColor = UIColor(red: 209/255, green: 211/255, blue: 212/255, alpha: 1)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            cell.MedalsTitle.text =   "Medals"
            return cell
        }
        
        else  if indexPath.section == 2
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AthletesMedalsCellID", for: indexPath) as! AthletesMedalsCell
            
            cell.contentView.backgroundColor = UIColor(red: 209/255, green: 211/255, blue: 212/255, alpha: 1)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            cell.PlaceName.text =   "" + (self.getAthletesResult![indexPath.row].city ?? "")
            
            cell.GoldCound.text = "" + "\(self.getAthletesResult![indexPath.row].gold ?? 0)"
            cell.SliverCount.text = "" + "\(self.getAthletesResult![indexPath.row].silver ?? 0)"
            cell.BronzeCount.text = "" + "\(self.getAthletesResult![indexPath.row].bronze ?? 0)"
            
            
            
            return cell
        }
        
        else  if indexPath.section == 3
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BioTitleCellID", for: indexPath) as! BioTitleCell
            
            cell.contentView.backgroundColor = UIColor(red: 209/255, green: 211/255, blue: 212/255, alpha: 1)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            cell.BioTitle.text =   "Bio"
            return cell
        }
        
        else  if indexPath.section == 4
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BioDetailsCellID", for: indexPath) as! BioDetailsCell
            
            cell.contentView.backgroundColor = UIColor(red: 209/255, green: 211/255, blue: 212/255, alpha: 1)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            cell.BioDetails.text =   (self.getAthletesDetails?.bio ?? "")
            self.mAthletesDetailsTabel.rowHeight = UITableView.automaticDimension
            return cell
        }
        
        return UITableViewCell()
    }
    
}
