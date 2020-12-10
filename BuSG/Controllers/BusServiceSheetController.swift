//
//  BusNumberSheetController.swift
//  Navigem
//
//  Created by Ryan The on 29/11/20.
//

import UIKit
import MapKit

class BusServiceSheetController: SheetController {
    
    var busService: BusService!
    
    lazy var tableView = UITableView(frame: CGRect(), style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        let trailingButton = UIButton(type: .close, primaryAction: UIAction(handler: { (action) in
            self.dismissSheet()
        }))
        headerView.trailingButton = trailingButton
        
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        
        contentView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: tableView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
        ])
        
        tableView.register(BusServiceTableViewCell.self, forCellReuseIdentifier: K.identifiers.busService)
    }
    
    init(for serviceNo: String?) {
        
        super.init()
        
        self.busService = ApiProvider.shared.getBusService(for: serviceNo ?? "1")
        self.headerView.titleText = busService.serviceNo
        self.headerView.detailText = busService.destinationCode
        
        LocationProvider.shared.delegate?.locationProvider(didRequestRouteFor: busService, in: 1)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension BusServiceSheetController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busService?.busStops.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.identifiers.busService, for: indexPath) as! BusServiceTableViewCell
        cell.backgroundColor = .clear
        cell.selectedBackgroundView = FillView(solidWith: (UIScreen.main.traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black).withAlphaComponent(0.1))
        cell.set(busNumber: busService?.busStops[indexPath.row].busStopCode ?? "00000")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        present(BusStopSheetController(for: busService?.busStops[indexPath.row].busStopCode ?? K.nilStr), animated: true)
    }
}

extension BusServiceSheetController: SheetControllerDelegate {
    
    func sheetController(_ sheetController: SheetController, didUpdate state: SheetState) {
        UIView.animate(withDuration: 0.3) {
            switch state {
            case .min:
                self.tableView.layer.opacity = 0
            default:
                self.tableView.layer.opacity = 1
            }
        }
    }
    
    func sheetController(_ sheetController: SheetController, didReturnFromDismissalBy presentingSheetController: SheetController) {
        LocationProvider.shared.delegate?.locationProvider(didRequestRouteFor: busService, in: 1)
    }

}
