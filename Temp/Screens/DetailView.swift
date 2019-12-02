//
//  DetailView.swift
//  Temp
//
//  Created by Egor Syrtcov on 11/25/19.
//  Copyright © 2019 Egor Syrtcov. All rights reserved.
//

import UIKit
import Nuke

protocol DetailViewDelegate {
    func handleDismissal()
}

class DetailView: UIView {
    
    var hero: Hero! {
        didSet {
            nameHeroLabel.text = hero.name
            
            guard let image = self.hero?.images.image else {return}
            guard let profileImageURL = URL(string: image) else {return}
            
            Nuke.loadImage(with: profileImageURL, into: self.profileImageView)
            
            intelligenceHeroLabel.text = "Intelligence: \(hero.powerstats.intelligence)"
            strengthHeroLabel.text = "Strenght: \(hero.powerstats.strength)"
            speedHeroLabel.text = "Speed: \(hero.powerstats.speed)"
            powerHeroLabel.text = "Power: \(hero.powerstats.power)"
        }
    }
    
    private let width: CGFloat = 300
    private let height: CGFloat = 40
    
    var delegate: DetailViewDelegate?
    
    let nameHeroLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = UIColor.mainPink()
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 25)
        return nameLabel
    }()
    
    let profileImageView: UIImageView = {
        let profileImageView = UIImageView()
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.image = #imageLiteral(resourceName: "noImage")
        return profileImageView
    }()
    
    let separatopView1 = SeparatopView()
    let separatopView2 = SeparatopView()
    let separatopView3 = SeparatopView()
    let separatopView4 = SeparatopView()
    
    let intelligenceHeroLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.mainPink()
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        return nameLabel
    }()
    
    let strengthHeroLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.mainPink()
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        return nameLabel
    }()
    
    let speedHeroLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.mainPink()
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        return nameLabel
    }()
    
    let powerHeroLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.mainPink()
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        return nameLabel
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.mainPink()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return button
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
    
        assembler()
        seputLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleBackTapped(sender: UIButton!) {
        delegate?.handleDismissal()
    }
    
    private func assembler() {
        addSubview(nameHeroLabel)
        addSubview(profileImageView)
        addSubview(backButton)
        addSubview(separatopView1)
        addSubview(separatopView2)
        addSubview(separatopView3)
        addSubview(separatopView4)
        addSubview(intelligenceHeroLabel)
        addSubview(strengthHeroLabel)
        addSubview(speedHeroLabel)
        addSubview(powerHeroLabel)
    }
    
    private func seputLayout() {
        nameHeroLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.height.equalTo(50)
            make.left.right.equalToSuperview()
        }
        profileImageView.snp.makeConstraints { (make) in
            make.top.equalTo(nameHeroLabel.snp.bottom).offset(30)
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.centerX.equalToSuperview()
        }
        
        separatopView1.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.width.equalToSuperview().offset(-80)
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).offset(70)
        }
        
        intelligenceHeroLabel.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(separatopView1)
            make.height.equalTo(30)
        }
        
        separatopView2.snp.makeConstraints { (make) in
            make.height.width.left.equalTo(separatopView1)
            make.top.equalTo(separatopView1.snp.bottom).offset(50)
        }
        
        strengthHeroLabel.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(separatopView2)
            make.height.equalTo(30)
        }
        
        separatopView3.snp.makeConstraints { (make) in
            make.height.width.left.equalTo(separatopView2)
            make.top.equalTo(separatopView2.snp.bottom).offset(50)
        }
        
        speedHeroLabel.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(separatopView3)
            make.height.equalTo(30)
        }
        
        separatopView4.snp.makeConstraints { (make) in
            make.height.width.left.equalTo(separatopView3)
            make.top.equalTo(separatopView3.snp.bottom).offset(50)
        }
        
        powerHeroLabel.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(separatopView4)
            make.height.equalTo(30)
        }
        
        backButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: width , height: height))
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }
    }
}

