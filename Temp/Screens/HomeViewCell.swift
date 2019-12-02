//
//  HomeViewCell.swift
//  Temp
//
//  Created by Egor Syrtcov on 21/11/2019.
//  Copyright © 2019 Egor Syrtcov. All rights reserved.
//

import UIKit
import Nuke

class HomeViewCell: UICollectionViewCell {
    
    var hero: Hero? {
        didSet {
            nameLabel.text = hero?.name
        
            guard let image = self.hero?.images.image else {return}
            guard let profileImageURL = URL(string: image) else {return}
                
            Nuke.loadImage(with: profileImageURL, into: self.profileImageView)
        }
    }
        
   let profileImageView: UIImageView = {
        let profileImageView = UIImageView()
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.image = #imageLiteral(resourceName: "noImage")
        return profileImageView
    }()
    
    let nameContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainPink()
        return view
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        return nameLabel
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViewComponents()
        assembler()
        seputLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViewComponents() {
        self.layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    private func assembler() {
        addSubview(profileImageView)
        addSubview(nameContainerView)
        nameContainerView.addSubview(nameLabel)
    }
    
    private func seputLayout() {
        profileImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().offset(-32)
        }
        nameContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
}
