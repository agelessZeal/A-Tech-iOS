//
//  AlarmViewController.swift
//  A-Tech
//
//  Created by WuSongBai on 2019/12/28.
//  Copyright © 2019 atecheng. All rights reserved.
//

import UIKit
import StompClientLib

class AlarmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StompClientLibDelegate {
    
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var pointTableView: UITableView!
    var socketClient = StompClientLib()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = URL(string: "ws://3.24.138.90:8081/message/websocket")!
        if !socketClient.isConnected() {
            socketClient.openSocketWithURLRequest(request: NSURLRequest(url: url as URL), delegate: self as StompClientLibDelegate)
        }
    }
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print("Destination : \(destination)")
        print("JSON Body : \(String(describing: jsonBody))")
        print("String Body : \(stringBody ?? "nil")")
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Socket is disconnected")
//        let channelId = UserDefaults.standard.string(forKey: "ChannelID")
//        let topic = "/topic/v2/alarms/\(String(describing: channelId!))"
//        socketClient.unsubscribe(destination: topic)
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        print("Socket is connected")
        let channelId = UserDefaults.standard.string(forKey: "ChannelID") //5e0a449b46e0fb00016e83ad
        let url = URL(string: "ws://3.24.138.90:8081/message/websocket")!
        let topic = "/topic/v2/alarms/\(String(describing: channelId!))"
        let ack = "ack_\(topic)"
        let subsId = "subscription_\(topic)"
        let header = ["destination": topic, "ack": ack, "id": subsId]
        
        socketClient.subscribeWithHeader(destination: topic, withHeader: header)
        socketClient.autoDisconnect(time: 3)
        socketClient.reconnect(request: NSURLRequest(url: url as URL), delegate: self as StompClientLibDelegate)
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print("Receipt : \(receiptId)")
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print("Error Send : \(String(describing: message)), \(String(describing: description))")
    }
    
    func serverDidSendPing() {
        print("Server ping")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.pointTableView.dequeueReusableCell(withIdentifier: "pointCell", for: indexPath)
        
        return cell
    }
    
    @IBAction func onClickPreviousBtn(_ sender: UIButton) {
    }
    
    @IBAction func onClickHomeBtn(_ sender: UIButton) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickNextBtn(_ sender: UIButton) {
    }
    
    @IBAction func onClickSortBtn(_ sender: UIButton) {
        socketClient.sendMessage(message: "StompClientLib Foo", toDestination: "/app/hello", withHeaders: nil, withReceipt: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
