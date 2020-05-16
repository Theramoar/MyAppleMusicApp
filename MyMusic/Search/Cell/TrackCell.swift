//
//  TrackCell.swift
//  MyMusic
//
//  Created by Mihails Kuznecovs on 03/02/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import UIKit
import SDWebImage

protocol TrackCellViewModel {
    var iconUrlString: String? { get }
    var trackName: String { get }
    var artistName: String { get }
    var collectionName: String { get }
    
}

class TrackCell: UITableViewCell {
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    static let reuseId = "TrackCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackImageView.image = nil
    }
    
    var cell: SearchViewModel.Cell?
    func set(viewModel: /*TrackCellViewModel - данный тип использовать если хочу сегрегировать интерфейсы*/SearchViewModel.Cell) {
        self.cell = viewModel
        let savedTracks = UserDefaults.standard.savedTracks()
        let hasFavourite = savedTracks.firstIndex(where: { $0.trackName == self.cell?.trackName && $0.artistName == self.cell?.artistName }) != nil
        if hasFavourite {
            addButton.isHidden = true
        }
        else {
            addButton.isHidden = false
        }
        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        trackImageView.sd_setImage(with: url, completed: nil)
    }
    
    @IBAction func addTrack(_ sender: Any) {
        guard let cell = cell else { return }
        addButton.isHidden = true
        var listOfTracks = UserDefaults.standard.savedTracks()
        listOfTracks.append(cell)
        
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: listOfTracks, requiringSecureCoding: false) {
            UserDefaults.standard.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
}
