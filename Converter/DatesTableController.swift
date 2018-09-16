//
//  TableViewController.swift
//  Converter
//
//  Created by Alex on 14.09.2018.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class DatesTableController: UIViewController {

    var presenter: DatesTablePresenter!
    var tableView: UITableView!
    var fetchingMore = false
    
    init(with presenter: DatesTablePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = presenter.backgroundColor
        setupTableView()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = presenter
        presenter.registerCells(for: tableView)
        self.view.addSubview(tableView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height * 3 {
            if !fetchingMore {
                beginLoadMore()
            }
        }
    }
    
    func beginLoadMore() {
        fetchingMore = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            self.presenter.lastDay = self.presenter.lastDay.subtract(days: 16)
            let newItems = self.presenter.lastDay.getDates(forLastNDays: 15)
            self.presenter.model.dates.append(contentsOf: newItems)
            self.fetchingMore = false
            self.tableView.reloadData()
        })
    }
    
}

extension DatesTableController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let date = presenter.date(for: indexPath.row) else { return }
        let detailPresenter = CurrencyDetailPresenter(with: date)
        let detailsViewController = DetailViewController(with: detailPresenter)
        self.present(detailsViewController, animated: false, completion: nil)
    }
}
