//
//  ViewController.swift
//  AutoLayout_Chating
//
//  Created by 양팀장(iMac) on 2019. 10. 28..
//  Copyright © 2019년 양팀장(iMac). All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var chatTableView: UITableView! {
        didSet {
            chatTableView.delegate = self
            chatTableView.dataSource = self
            //chatTableView.separatorColor = UIColor.white
            chatTableView.separatorStyle = .none        // 셀 구분선 없애기
            
        }
    }

    @IBOutlet weak var inputTextView: UITextView!
    
    @IBOutlet weak var inputViewBottomMargin: NSLayoutConstraint!
    
    var chatDatas = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 사용하려는 셀을 등록해야 사용할 수 있다.
        chatTableView.register(UINib(nibName: "MyCell", bundle: nil), forCellReuseIdentifier: "myCell")
        chatTableView.register(UINib(nibName: "YourCell", bundle: nil), forCellReuseIdentifier: "yourCell")
        
        // 키보드 관련 옵저버(상태를 알려주는 것) 설정을 해야 함
        // 키보드 올라올 때
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification , object: nil)
        
        // 키보드 내려올 때
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification , object: nil)
        
        
        
        
        
    }
    
    @objc func keyboardWillShow (noti: Notification) {
        let notiInfo = noti.userInfo!
        let keyboardFrame = notiInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        
        // safeAreaInsets.bottom : iPhone X에서는 safeArea가 다르기 때문에 꼭
        // safeAreaInsets.bottom값을 빼줘야 X에서도 꼭 붙어서 나온다.(안 그러면 간격이 벌어짐)
        let height = keyboardFrame.size.height - self.view.safeAreaInsets.bottom
        
        
        let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animationDuration) {
            self.inputViewBottomMargin.constant = height
            self.view.layoutIfNeeded()
        }
    }
    
    
    @objc func keyboardWillHide (noti: Notification) {
        let notiInfo = noti.userInfo!
        let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animationDuration) {
            self.inputViewBottomMargin.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0 {
            let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyCell
            myCell.myTextView.text = chatDatas[indexPath.row]
            
            return myCell
            
        } else {
            let yourCell = tableView.dequeueReusableCell(withIdentifier: "yourCell", for: indexPath) as! YourCell
            
            yourCell.yourTextView.text = chatDatas[indexPath.row]
            
            return yourCell
            
        }
        
    }
    
    // 메시지 입력 전송하기
    @IBAction func sendString(_ sender: Any) {
        //inputTextView.text
        chatDatas.append(inputTextView.text)
        inputTextView.text = ""
        
        let lastIndexPath = IndexPath(row: chatDatas.count - 1, section: 0)
        
        // chatTableView.reloadData()   //---> 튕기는 현상 발생
        
        // 해결) insertRows로 해결
        chatTableView.insertRows(at: [lastIndexPath], with: UITableView.RowAnimation.automatic)
        
        
        
        // 메시지 전송시
        // 메시지가 키보드에 가려지는 현상 해결
        chatTableView.scrollToRow(at: lastIndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        
    }
    
    
    
}

