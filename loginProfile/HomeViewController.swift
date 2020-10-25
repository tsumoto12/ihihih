//
//  HomeViewControllerFile.swift
//  loginProfile
//
//  Created by yuya on 05/10/2020.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import PKHUD

class HomeViewController: UIViewController{
    
    var user: User?{
        didSet {
            print("user?.name: ", user?.name)
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBAction func tappedLogoutButton(_ sender: Any) {
        handleLogout()
    }
    
    private func handleLogout(){
        do{
            try Auth.auth().signOut()
            //dismiss(animated: true, completion: nil)
            presentToMainViewController()
        }catch(let err){
            print("ログアウトに失敗しました:\(err)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutButton.layer.cornerRadius = 13
        //user情報がniiかどうかを確認してnilではなかったら以下の処理が走る
        if let user = user{
            nameLabel.text = user.name + "さん"
            emailLabel.text = user.email
        }
    }
    //最初に表示されたときにログインされてるかどうか確認する
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        confirmLoggedInuser()
    }
    //authの情報がnilかどうか確認する
    private func confirmLoggedInuser(){
        if Auth.auth().currentUser?.uid == nil || user == nil {
            presentToMainViewController()
        }
        
    }
    //ログイン情報なかったらメインに行く
    private func presentToMainViewController(){
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                     let ViewController = storyBoard.instantiateViewController(identifier:"ViewController") as! ViewController
        //任意のViewControllerをrootViewControllerに指定
        let navController = UINavigationController(rootViewController: ViewController)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
}

