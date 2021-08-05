//
//  MainUI_VIEW.swift
//  Weather_app
//
//  Created by admin on 04.08.2021.
//

import Foundation
import UIKit
import SnapKit

class Weather_UI_VIEW: UIView {
    lazy  var  collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView (frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    lazy var image: UIImageView = {
        let icon = UIImageView()
        icon.clipsToBounds = false
        icon.contentMode = .scaleAspectFit
        return icon}()
    
    lazy var container: UIView = {
        let container = UIView()
        return container}()
    
    lazy var day_txt: UILabel = {
        let day = UILabel()
        day.textColor = .white
        day.font = .systemFont(ofSize: 30)
        return day}()
    
    lazy var condition: UILabel = {
        let condition = UILabel()
        condition.textColor = .white
        condition.font = .systemFont(ofSize: 30)
        return condition  }()
    
    lazy var temp: UILabel = {
        let temp = UILabel()
        temp.textColor = .white
        temp.font = .systemFont(ofSize: 30)
        return temp}()
    
    lazy var city: UILabel = {
        let city = UILabel()
        city.textColor = .white
        city.numberOfLines = 0
        city.font = .systemFont(ofSize: 30)
        return city}()
    
    lazy var label: UILabel = {
        let lbl = UILabel (frame: CGRect(x: 100, y: 8, width: self.frame.width , height: 20))
        lbl.text = "Погода на неделю"
        lbl.textAlignment = .left
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 30)
        return lbl
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(image)
        addSubview(day_txt)
        addSubview(condition)
        addSubview(temp)
        addSubview(city)
        addSubview(container)
        container.addSubview(collectionView)
        container.addSubview(label)
        self.collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: "CustomMainCell")
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    override func layoutSubviews() {
        
        image.snp.makeConstraints{ make in
            make.top.equalTo(self).offset(100)
            make.left.equalTo(self)
            make.height.equalTo(80)
            make.width.equalTo(80)
            
        }
        city.snp.makeConstraints{make in
            make.top.equalTo(image.snp.top).offset(50)
            make.centerX.equalToSuperview().offset(30)
        }
        
        day_txt.snp.makeConstraints{ make in
            make.top.equalTo(city.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            
        }
        
        condition.snp.makeConstraints{ make in
            make.top.equalTo(day_txt.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        temp.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(condition.snp.bottom).offset(30)
        }
        
        
        collectionView.snp.makeConstraints{make in
            make.bottom.equalTo(container).inset(50)
            make.left.right.equalTo(container).inset(8)
            make.height.equalTo(150)
        }
        container.snp.makeConstraints{make in
            make.bottom.right.left.equalToSuperview()
            make.height.equalTo(self.frame.height/3)
        }
        container.backgroundColor = .darkGray
        container.layer.cornerRadius = 40
        container.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        label.snp.makeConstraints{make in
            make.top.equalTo(container.snp.top).offset(20)
            make.left.equalTo(container).offset(15)
        }
    }
    
}
