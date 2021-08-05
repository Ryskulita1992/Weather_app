//
//  WeatherCell.swift
//  Weather_app
//
//  Created by admin on 04.08.2021.
//

import Foundation
import UIKit

class WeatherCell: UICollectionViewCell {
   
    override var reuseIdentifier: String? {
        return "CustomMainCell"
    }
    var data: Daily? {
        didSet {
            guard let data = data else {return }
            self.day.text = getDayForDate(Date(timeIntervalSince1970: TimeInterval(data.dt)))
            self.tempMin.text = "\("d " + data.temp.day.description + "°")"
            self.tempMax.text = "\("n/t" + data.temp.night.description + "°")"

            if let urlString = (data.weather[0].icon ) {
                let urlImage = URL(string: "\(Constants.url_for_image)" + urlString)
               weatherImage.kf.setImage(with: urlImage)
                
            }
        }
        
    }
    lazy var weatherImage :  UIImageView = {
        let image = UIImageView ()
        return image
    }()
    
    
    lazy var tempMin: UILabel = {
        let lbl = UILabel ()
        lbl.font = .systemFont(ofSize: 10)
        return lbl
    }()
    lazy var tempMax: UILabel = {
        let lbl = UILabel ()
        lbl.font = .systemFont(ofSize: 10)
        return lbl
    }()
    lazy var day: UILabel = {
        let lbl = UILabel (frame: CGRect(x: 100, y: 8, width: self.frame.width , height: 20))
        lbl.textAlignment = .left
        lbl.font = UIFont.preferredFont(forTextStyle: .callout ).withSize(14)
        return lbl
    }()
    
  
    override init (frame: CGRect){
        super.init(frame: frame)

        contentView.addSubview(weatherImage)
        contentView.addSubview(tempMin)
        contentView.addSubview(tempMax)
        contentView.addSubview(day)

    }

    required init?(coder: NSCoder) {
        fatalError("")
    }
 
    override func layoutSubviews() {
        weatherImage.layer.cornerRadius = 20
        weatherImage.clipsToBounds = true
        
        
        day.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(10)
            make.left.right.equalToSuperview().inset(5)
        }
        weatherImage.snp.makeConstraints{ make in
            make.top.equalTo(day.snp.bottom).offset(10)
            make.right.left.equalToSuperview().inset(10)
            make.height.equalTo(self.frame.height/3)
            make.width.equalTo(self.frame.width/1.5)
            
        }
        tempMin.snp.makeConstraints{make in
            make.top.equalTo(weatherImage.snp.bottom).offset(3)
            make.left.right.equalToSuperview().inset(10)
        }
        tempMax.snp.makeConstraints{make in
            make.top.equalTo(tempMin.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(10)
        }
       
    }
    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Monday
        return formatter.string(from: inputDate)
    }
    
}
