//
//  CandyStoreViewController.swift
//  RetoCP
//
//  Created by Kevin Guanilo on 6/10/21.
//

import UIKit

class CandyStoreViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var candyStoreTableView: UITableView! {
        didSet {
            candyStoreTableView.register(CandysTableViewCell.buildCell(), forCellReuseIdentifier: CandysTableViewCell.identifier)
        }
    }
    var arrayOfCandys: [Items] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        self.candyStoreTableView.isHidden = true
        self.candyStoreTableView.delegate = self
        getCandyStore()
    }
    
    func getCandyStore() {
        Services.getCandyStore(endpoint: .candys) { (candyStore) in
            self.arrayOfCandys = candyStore!.items
            self.updateTable()
        }
    }
    
    func updateTable() {
        DispatchQueue.main.async {
            self.candyStoreTableView.reloadData()
            self.candyStoreTableView.layoutIfNeeded()
        }
    }
}
extension CandyStoreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfCandys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.candyStoreTableView.isHidden = false
        let rawCell = tableView.dequeueReusableCell(withIdentifier: CandysTableViewCell.identifier, for: indexPath)
        guard let candyStoreCell = rawCell as? CandysTableViewCell else {
            assertionFailure("Can't find the expected cell")
            return rawCell
        }
        candyStoreCell.setupCell(items: self.arrayOfCandys[indexPath.row])
        return candyStoreCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

extension UITableViewCell {

    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }

}
