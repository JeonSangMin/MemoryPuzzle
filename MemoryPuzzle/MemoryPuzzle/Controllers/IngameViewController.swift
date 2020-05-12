//
//  IngameViewController.swift
//  MemoryPuzzle
//
//  Created by MyMac on 2020/05/08.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit



class IngameViewController: UIViewController {
    private let ingameView = IngameView()
    private let ingameViewImageName: String
    private let leftDoor = UIImageView()
    private let rightDoor = UIImageView()
    
    private lazy var collectionView = UICollectionView(frame: ingameView.frame, collectionViewLayout: layout)
    private let layout = UICollectionViewFlowLayout()
    
    private let manager = GameManager()
    private let dataCards: [Card]
    
    private let itemsInLine: CGFloat
    private let linesOnScreen: CGFloat
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBar()
        setUI()
        setCollectionView()
        print(dataCards)
    }
    
    init(cards: [Card], itemsInline: CGFloat, linesOnScreen: CGFloat, ingameViewImageName: String) {
        self.dataCards = cards
        self.itemsInLine = itemsInline
        self.linesOnScreen = linesOnScreen
        self.ingameViewImageName = ingameViewImageName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setFlowLayout()
        ingameView.configure(background: ingameViewImageName)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        setFlowLayout()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setFlowLayout()
    }
    
    
    private func setNaviBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = .black
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        let countDownLabel = UILabel()
        countDownLabel.text = "1.57"
        countDownLabel.font = UIFont(name: "diablo", size: 25)
        countDownLabel.textColor = #colorLiteral(red: 0.4784313725, green: 0.02745098039, blue: 0.06274509804, alpha: 1)
        countDownLabel.frame.size = CGSize(width: 100, height: 40)
        countDownLabel.textAlignment = .center
        self.navigationItem.titleView = countDownLabel
        let pauseButton = UIBarButtonItem(title: "pause", style: .plain, target: self, action: #selector(pause(_:)))
        pauseButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "diablo", size: 20) as Any], for: .normal)
        self.navigationItem.rightBarButtonItem = pauseButton
        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.4784313725, green: 0.02745098039, blue: 0.06274509804, alpha: 1)
    }
    
    private func setUI() {
        view.addSubview(ingameView)
        ingameView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        [leftDoor, rightDoor].forEach {
            view.addSubview($0)
            $0.isHidden = true
            $0.snp.makeConstraints {
                $0.width.equalToSuperview().multipliedBy(0.5)
                $0.top.equalTo(view.safeAreaLayoutGuide)
                $0.bottom.equalToSuperview()
            }
        }
        
        leftDoor.image = UIImage(named: "leftDoor")
        rightDoor.image = UIImage(named: "rightDoor")
        
        leftDoor.snp.makeConstraints {
            $0.trailing.equalTo(view.snp.leading)
        }
        rightDoor.snp.makeConstraints {
            $0.leading.equalTo(view.snp.trailing)
        }
        
    }
    
    private func setCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.register(PuzzleCell.self, forCellWithReuseIdentifier: PuzzleCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.isMultipleTouchEnabled = true
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = true
        
        collectionView.backgroundColor = .clear
        collectionView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalTo(ingameView)
        }
        
    }
    
    @objc private func pause(_ sender: UIBarButtonItem) {
        print("Pause")
    }
    
    
}


extension IngameViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.dataCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PuzzleCell.identifier, for: indexPath) as! PuzzleCell
        return cell
    }
    
    // MARK: Delegate
    // 낙장불입!(다시 뒤집을 수 없음)
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PuzzleCell else { return }
        cell.configure(named: dataCards[indexPath.item].name)
        manager.getTouchedCard(cell: cell)
        print(cell.isSelected)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PuzzleCell else { return }
        cell.configure(named: "back")
        manager.getTouchedCard(cell: cell)
        print(cell.isSelected)
    }
}

// MARK: Set FlowLayout
extension IngameViewController {

    func setFlowLayout(){
        let edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        layout.minimumLineSpacing = 7
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = edgeInsets
        
        let itemSpacing = 10 * (self.itemsInLine - 1)
        let lineSpacing = 7 * (self.linesOnScreen - 1)
        
        let horizontalInset = edgeInsets.left + edgeInsets.right
        let verticalInset = edgeInsets.top + edgeInsets.bottom
        
        let horizontalSpacing = itemSpacing + horizontalInset
        let verticalSpacing = lineSpacing + verticalInset
        
        let contentWidth = view.frame.width - horizontalSpacing
        let contentHeight = (view.safeAreaLayoutGuide.layoutFrame.size.height) - verticalSpacing
        
        let width = contentWidth / self.itemsInLine
        let height = contentHeight / self.linesOnScreen
        
        layout.itemSize = CGSize(
            width: width.rounded(.down) - 1,
            height: height.rounded(.down) - 1)
    }
}
