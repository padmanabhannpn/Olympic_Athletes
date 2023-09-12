//
//  AthletesTabelCell.swift
//  Olympic Athletes
//
//  Created by PADMANABHAN on 11/09/23.
//

import Foundation
import UIKit
import Kingfisher

protocol delegateForAthletesList {
    
    func passAthletesListData(athleteid:String)
}

class AthletesTabelCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var NodataLabel: UILabel!
    
    @IBOutlet weak var AthletesCollectioView: UICollectionView!
    
    
    
    var delegate : delegateForAthletesList?
    
    var CityName = [String]()
    var getAthletesvalued = NSArray()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.AthletesCollectioView.delegate = self
        self.AthletesCollectioView.dataSource = self
        self.AthletesCollectioView.showsHorizontalScrollIndicator = false
        
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: self.AthletesCollectioView.frame.size.width / 3, height: 120)
        self.AthletesCollectioView.collectionViewLayout = flowLayout
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    
    //MARK:- ColloectionView Delegate & DataSource Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 50 // This is the minimum inter item spacing, can be more
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if (self.getAthletesvalued.count == 0) {
            self.AthletesCollectioView.setEmptyMessage("Athletes details not found")
        } else {
            self.AthletesCollectioView.restore()
        }
        
        return self.getAthletesvalued.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AthletesCollectioViewCellID", for: indexPath) as! AthletesCollectioViewCell
        
        let ImageID = ((getAthletesvalued.object(at: indexPath.item) as! NSDictionary).value(forKey: "adId") as! String)
        let url = URL(string: mAthletesDetails + "\(ImageID)/photo")
        cell.mUserImage.kf.setImage(with: url)
        
        cell.mUserName.text = ((getAthletesvalued.object(at: indexPath.item) as! NSDictionary).value(forKey: "name") as! String)
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        self.delegate?.passAthletesListData(athleteid: ((getAthletesvalued.object(at: indexPath.item) as! NSDictionary).value(forKey: "adId") as! String))
    }
    
}

