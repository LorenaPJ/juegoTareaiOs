//
//  gamescreen.swift
//  juegoTareaiOs
//
//  Created by Lorena Pérez Jota  on 19/10/24.
//
import UIKit

class gamescreen: UIViewController {
    /*
     var countDownTimer = 3
     var timerRunning = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("\(countDownTimer)")
                .onReceive(timer) { _ in
                    if self.countDownTimer > 0 && self.timerRunning{
                        self.countDownTimer -= 1
                    } else {
                        self.timerRunning = false
                    }
                }
                .font(.system(size: 80 , weight: .bold))
                .opacity(0.80)
        }
    } */
    
    @IBOutlet weak var changingImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.changingImage.image = UIImage(named: "flamingo")
    }
   
    
    /*
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true){(timer) in
            print("Hola")}
     */
}
