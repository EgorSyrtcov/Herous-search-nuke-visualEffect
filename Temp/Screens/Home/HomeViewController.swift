//
//  ViewController.swift
//  Temp
//
//  Created by Egor Syrtcov on 09/11/2019.
//  Copyright © 2019 Egor Syrtcov. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import AlamofireObjectMapper


private struct Properties {
    static let cell = "cellId"
}

class HomeViewController: UIViewController {
    
    var heroes: [Hero]?
    var filterHerous: [Hero]?
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    lazy var detailView: DetailView = {
        let detailView = DetailView()
        detailView.layer.cornerRadius = 5
        detailView.delegate = self
        return detailView
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.alpha = 0
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 32, left: 8, bottom: 8, right: 8)
        let width = (view.frame.width - 36) / 3
        layout.itemSize = CGSize(width: width, height: width)
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.alwaysBounceVertical = true
        collection.backgroundColor = .white
        collection.dataSource = self
        collection.delegate = self
        collection.register(HomeViewCell.self, forCellWithReuseIdentifier: Properties.cell)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        fetchSuperHero()
        setupNavigationBar()
        assembler()
        setupSearch()
        seputLayout()
        
        
    }
    
    private func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    
    func fetchSuperHero() {
        Service.shared.fetchData { [weak self](herous) in
            
                self?.heroes = herous
            DispatchQueue.main.async {
                 self?.collectionView.reloadData()
            }
        }
    }
    
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.barStyle = .black
       // navigationController?.navigationBar.prefersLargeTitles = true
        title = "Herous"
    }
    
    private func assembler() {
        view.addSubview(collectionView)
        view.addSubview(visualEffectView)
    }
    
    private func seputLayout() {
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        visualEffectView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isFiltering {
            return filterHerous?.count ?? 0
        }
        
        return heroes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Properties.cell, for: indexPath) as! HomeViewCell
        
        var hero: Hero
        
        if isFiltering {
            hero = filterHerous![indexPath.row]
        } else {
            hero = heroes![indexPath.row]
        }
        cell.hero = hero
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        searchController.searchBar.resignFirstResponder()
        view.addSubview(detailView)
        
        var hero: Hero
        
        if isFiltering {
            hero = filterHerous![indexPath.row]
        } else {
            hero = heroes![indexPath.row]
        }

        detailView.hero = hero
        
        detailView.snp.makeConstraints { (make) in
            make.height.equalToSuperview().offset(-50)
            make.width.equalToSuperview().offset(-50)
            make.center.equalToSuperview()
        }
        
        detailView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        detailView.alpha = 0
        
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.visualEffectView.alpha = 1
            self?.detailView.alpha = 1
            self?.detailView.transform = CGAffineTransform.identity
        }
    }
}

extension HomeViewController: DetailViewDelegate {
    func handleDismissal() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.visualEffectView.alpha = 0
            self?.detailView.alpha = 0
            self?.detailView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.detailView.removeFromSuperview()
        }
    }
}

extension HomeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if !searchController.isActive {
            handleDismissal()
        }
        
        filterContectForText(searchController.searchBar.text!)
    }
    
    private func filterContectForText(_ searchText: String) {
        filterHerous = heroes?.filter({ (hero: Hero) -> Bool in
            return hero.name?.lowercased().contains(searchText.lowercased()) ?? true
        })
        collectionView.reloadData()
    }
}
