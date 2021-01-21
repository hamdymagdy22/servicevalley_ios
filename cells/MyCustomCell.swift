//
//  MyCustomCell.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 6/10/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit
import AsyncTimer
protocol orderCellDelegate {
    
    
    func didPressButton(at index:IndexPath)
    
}

class MyCustomCell: UITableViewCell {
   
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var deleteOrder: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
   
    @IBOutlet weak var stateImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeOfBooking: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    
    var timer: Timer?
  var timeCounter: Double = 0
    public var viewController: ordersList?
    var index: Int = -1
    var indexPath:IndexPath!
    var delegate: orderCellDelegate?
    
  
//    lazy var timer: AsyncTimer = {
//       
//
//
//
//        return AsyncTimer(
//            interval: .milliseconds(100),
//            times: milliseconds,
//            block: { [weak self] value in
//                self?.myLabel.text = value.description
//            }, completion: { [weak self] in
//                self!.stateImage.image = UIImage(named: "Denied")
//                let dd = Int(self!.timeOfBooking.text!)
//                API.cancelOrder (b_id_generator : dd! ){ ( error : Error?, success : Bool) in
//                    if success {
//                        self!.myLabel.isHidden = true
//                        self!.stateImage.image = UIImage(named: "Denied")
//
//                        print("ok")
//
//                    }
//                    else
//                    {
//                        print("NO Thing")
//                    }
//
//
//                }
//
//
//            }
//        )
//    }()
    
  
   
    
    var expiryTimeInterval: TimeInterval? {
        didSet {

            if timer == nil
            {
                startTimer()
                RunLoop.current.add(timer!, forMode: .common)
            }

        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        timer?.invalidate()

        timer = nil
//        myLabel.text = ""
//        stateImage.image = nil

    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        deleteOrder.isUserInteractionEnabled = true
        containerView.backgroundColor = UIColor(red:0.93, green:0.94, blue:0.94, alpha:1.0)
        upView.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        deleteOrder.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.62, alpha: 1.00)
        upView.layer.cornerRadius = 0.5 * upView.bounds.size.height
        containerView.layer.cornerRadius = 20
        containerView.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
        deleteOrder.isUserInteractionEnabled = true
        deleteOrder.clipsToBounds = true
        deleteOrder.layer.cornerRadius = 0.5 * deleteOrder.bounds.size.width
        deleteOrder.layer.borderWidth = 3
        deleteOrder.layer.borderColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0).cgColor
        // deleteOrder.backgroundColor = UIColor(red:0.06, green:0.72, blue:0.62, alpha:1.0)
        deleteOrder.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
//        firstView.roundCorners(corners: .topLeft, radius: 15)
//        firstView.roundCorners(corners: .topRight, radius: 15)
//        secondView.roundCorners(corners: .bottomRight, radius: 15)
//        secondView.roundCorners(corners: .bottomLeft, radius: 15)
//        thirdView.roundCorners(corners: .bottomRight, radius: 15)
//        thirdView.roundCorners(corners: .bottomLeft, radius: 15)
        
//        self.firstView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//        self.secondView.layer.maskedCorners  = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
//         self.thirdView.layer.maskedCorners  = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        self.firstView.roundCorners(corners: [.topLeft, .topRight], radius: 15)
        self.secondView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15)
        self.thirdView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15)
        
        myLabel.isHidden = false
        // timer = CountdownTimer(timerLabel: TimerLbl, startingMin: 20, startingSec: 0)
        //  timer.delegate = self
        //self.timer.start()
    
       
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
        guard timeCounter > 0 else {
         //   btnGoForTest.isUserInteractionEnabled = false
          //  myLabel.text = "Time ended."
            stateImage.image = UIImage(named: "close")
            self.timer?.invalidate()
            self.timer = nil
            let dd = Int(timeOfBooking.text!)
            API.cancelOrder (b_id_generator : dd! ){ ( error : Error?, success : Bool) in
                if success {
                    self.stateImage.layer.borderWidth = 3
                    self.stateImage.layer.borderColor = UIColor(red:0.87, green:0.04, blue:0.04, alpha:1.0).cgColor
                    self.firstView.backgroundColor = UIColor(red:0.87, green:0.04, blue:0.04, alpha:1.0)
                    self.myLabel.isHidden = true
                    self.thirdView.isHidden = true
                    self.stateImage.image = UIImage(named: "close")
                    self.statusLabel.text = "تم رفض الطلب"
                    self.timer?.invalidate()
                    self.timer = nil
                    print("ok")

                }
                    
                else
                    
                {
                 print("NO Thing")
                }


            }
            return
        }

       // btnGoForTest.isUserInteractionEnabled = true
        let hours = Int(timeCounter) / 3600
        let minutes = Int(timeCounter) / 60 % 60
        let seconds = Int(timeCounter) % 60

        myLabel.text = String(format:"%02i:%02i:%02i", hours, minutes, seconds)

        timeCounter -= 1
        print("\(timeCounter)")
        
        
        
  
    }
    
    @IBAction func deleteTapped(_ sender: UIButton) {
        if (sender.tag == 0) {
            self.delegate?.didPressButton(at: indexPath)
          //  self.deleteOrder.isUserInteractionEnabled = false
                    }
    }
}
extension UIView {
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }
}


