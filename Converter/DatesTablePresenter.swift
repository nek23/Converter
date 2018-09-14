//
//  DatesTablePresenter.swift
//  Converter
//
//  Created by Alex on 14.09.2018.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation
import UIKit

class DatesTablePresenter: NSObject {
    
    var model = DateModel()
    var lastDay = Date()
    
    
    
    let backgroundColor: UIColor = .yellow
    private var dates: [String] {
        return model.dates
    }
    
    let identificatorCell = "dateCell"
    
    
    func registerCells(for tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identificatorCell)
    }
    
    func date(for index: Int) -> String? {
        guard index < model.dates.count else { return nil }
        return self.dates[index]
    }
    
}

extension DatesTablePresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identificatorCell, for: indexPath)
        cell.textLabel?.text = dates[indexPath.row]
        return cell
    }
    
    
}
