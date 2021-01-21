//
//  ordersListCell.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 12/25/18.
//  Copyright © 2018 Parth Changela. All rights reserved.
//

import UIKit



class ordersListCell: UITableViewCell  {
//    func countdownEnded() {
//        TimerLbl.isHidden = true
//        self.delegate?.handleTimeEnded(at: indexPath)
//    }
    
    
    
    
    var indexPath:IndexPath!
   
    @IBOutlet weak var conatinerView: UIView!
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var TimerLbl: UILabel!
    @IBOutlet weak var bookingNumber: UILabel!
    @IBOutlet weak var dateOfBooking: UILabel!
    @IBOutlet weak var timeOfBooking: UILabel!
    @IBOutlet weak var bookingImage: UIImageView!
    @IBOutlet weak var descriptionOfBooking: UILabel!
    @IBOutlet weak var deleteOrder: UIButton!
   
   
//      var timer: CountdownTimer!
    private var timer: Timer?
    private var timeCounter: Double = 0
    
    var expiryTimeInterval: TimeInterval? {
        didSet {
            startTimer()
        }
    }
    
    private func startTimer() {
        if let interval = expiryTimeInterval {
            timeCounter = interval
            if #available(iOS 10.0, *) {
                timer = Timer(timeInterval: 1.0,
                              repeats: true,
                              block: { [weak self] _ in
                                guard let strongSelf = self else {
                                    return
                                }
                                strongSelf.onComplete()
                })
            } else {
                timer = Timer(timeInterval: 1.0,
                              target: self,
                              selector: #selector(onComplete),
                              userInfo: nil,
                              repeats: true)
            }
        }
    }
    
    @objc func onComplete() {
        guard timeCounter >= 0 else {
            timer?.invalidate()
            timer = nil
            return
        }
        TimerLbl.text = String(format: "%d", timeCounter)
        timeCounter -= 1
    }

    
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        deleteOrder.isUserInteractionEnabled = true
        conatinerView.backgroundColor = UIColor(red:0.93, green:0.94, blue:0.94, alpha:1.0)
        upView.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        deleteOrder.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        upView.layer.cornerRadius = 0.5 * upView.bounds.size.height
         conatinerView.layer.cornerRadius = 20
        conatinerView.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
        deleteOrder.isUserInteractionEnabled = true
        deleteOrder.clipsToBounds = true
         deleteOrder.layer.cornerRadius = 0.5 * deleteOrder.bounds.size.width
        deleteOrder.layer.borderWidth = 3
        deleteOrder.layer.borderColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0).cgColor
       // deleteOrder.backgroundColor = UIColor(red:0.06, green:0.72, blue:0.62, alpha:1.0)
      //   deleteOrder.addTarget(self, action: #selector(deletePress), for: .touchUpInside)
       // timer = CountdownTimer(timerLabel: TimerLbl, startingMin: 20, startingSec: 0)
      //  timer.delegate = self
        
    }
    

//    @IBAction func deletePress(_ sender: UIButton) {
//        if (sender.tag == 0) {
//            self.delegate?.didPressButton(at: indexPath)
//        }
//        
//    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
