//
//  HomePage.swift
//  Olympic Athletes
//
//  Created by PADMANABHAN on 11/09/23.
//

import UIKit

class HomePage: UIViewController,UITableViewDelegate,UITableViewDataSource, delegateForAthletesList {
    
    func passAthletesListData(athleteid: String) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Loginvc = storyboard.instantiateViewController(withIdentifier: "AthletesDetailsID") as! AthletesDetails
        Loginvc.Athleteid = athleteid
        self.navigationController?.pushViewController(Loginvc, animated: false)
        
    }
    
    var AthletesIDForAPI : [Int] = [Int]()
    @IBOutlet weak var AthletesTabelView: UITableView!
    var getAthletes : [GameModel]? = nil
    var getAthletesUser : [AthletesUserModel]? = nil
    var baseArray : [[String:Any]] = [[String:Any]]()
    var InvoiceList:NSArray  = []
    var LoadingInterval = 0
    var mainArrayOfDictionary : [[String:Any]] = [[String:Any]]()
    var CityName = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ConnectionCheck.isConnectedToNetwork()
        {
            GlobalSettings.startLoader(view: self.view)
            self.callAthletesAPI()
        }
        else
        {
            let alert = UIAlertController(title: "", message: "Please Check Your Internet Connection", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func callAthletesAPI(){
        HomePageViewModel().getAthletes(url: mAthletes) { result in
            switch result{
            case .success(let data):
                // GlobalSettings.hideLoader(view: self.view)
                self.getAthletes = data ?? nil
                
                DispatchQueue.main.async {
                    
                    for index in 0..<(self.getAthletes!.count)
                    {
                        
                        let dictionary: [String: Any] = ["\(self.getAthletes![index].city ?? "")": [[String:Any]].self]
                        self.CityName.append("\(self.getAthletes![index].city ?? "")")
                        usingCityName = self.CityName
                        self.mainArrayOfDictionary.append(dictionary)
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.getTheListForOneGame()
                    }
                    
                }
                
            case .failure(let error):
                GlobalSettings.hideLoader(view: self.view)
                print(error.localizedDescription)
            }
        }
    }
    
    //Call one by one api
    func getTheListForOneGame(){
        for i in 0...((self.getAthletes?.count ?? 0) - 1){
            self.AthletesIDForAPI.append(self.getAthletes?[i].game_id ?? 0)
        }
        
        self.callAthletesUserAPI(Athleteuserid: self.AthletesIDForAPI[self.LoadingInterval])
    }
    
    func callAthletesUserAPI(Athleteuserid : Int)
    {
        HomePageViewModel().getAthletesUser(url: mAthletes+"\(Athleteuserid)"+"/athletes") { result in
            switch result{
            case .success(let data):
                
                self.getAthletesUser = data ?? nil
                
                
                DispatchQueue.main.async {
                  //  GlobalSettings.hideLoader(view: self.view)
                    
                    
                    getData = self.getAthletesUser!
                    if getData!.count > 0{
                        self.baseArray = [[String:Any]]()
                        for i in 0...getData!.count - 1{
                            let dictionary: [String: Any] = [
                                "adId": getData![i].athlete_id ?? "",
                                "name": getData![i].name ?? ""
                            ]
                            self.baseArray.append(dictionary)
                        }
                        
                        
                        self.mainArrayOfDictionary[Athleteuserid - 1]["\(self.CityName[Athleteuserid - 1])"] = self.baseArray
                    }else{
                        self.baseArray = [[String:Any]]()
                        self.mainArrayOfDictionary[Athleteuserid - 1]["\(self.CityName[Athleteuserid - 1])"] = self.baseArray
                    }
                    
                    usingmainArrayOfDictionary = self.mainArrayOfDictionary
                    
                    DispatchQueue.main.async {
                        self.LoadingInterval = self.LoadingInterval+1
                        if self.LoadingInterval < self.AthletesIDForAPI.count{
                            self.callAthletesUserAPI(Athleteuserid: self.AthletesIDForAPI[self.LoadingInterval])
                        }else{
                            self.AthletesTabelView.delegate = self
                            self.AthletesTabelView.dataSource = self
                            self.AthletesTabelView.tableFooterView = UIView()
                            
                            self.AthletesTabelView.reloadData()
                        }
                    }
                    
                }
                
            case .failure(let error):
                GlobalSettings.hideLoader(view: self.view)
                print(error.localizedDescription)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.getAthletes!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        if indexPath.row % 2 == 0{
            return UITableView.automaticDimension
        }else{
            return 150
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if indexPath.row % 2 == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AthletesListTitleTableViewCellID", for: indexPath) as! AthletesListTitleTableViewCell
            cell.selectionStyle = .none
            
            cell.AthletesTitleLabel.text = "\(self.getAthletes?[indexPath.section].city ?? "") \(self.getAthletes?[indexPath.section].year ?? 0)"
            
            return cell
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AthletesTabelCellID", for: indexPath) as! AthletesTabelCell
            
            cell.contentView.backgroundColor = UIColor(red: 209/255, green: 211/255, blue: 212/255, alpha: 1)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            cell.delegate = self
            
            var getAthletesvalued = NSArray()
            let nsDictionary = NSDictionary(objects: usingmainArrayOfDictionary.flatMap { $0.values }, forKeys: usingmainArrayOfDictionary.flatMap { $0.keys } as [NSCopying])
            
            getAthletesvalued = nsDictionary.value(forKey: "\(CityName[indexPath.section])") as! NSArray
            
            
            cell.getAthletesvalued = getAthletesvalued
            cell.AthletesCollectioView.reloadData()
            
            GlobalSettings.hideLoader(view: self.view)
            
            
            return cell
        }
        
        
        
    }
    
}
extension UICollectionView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .red
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
