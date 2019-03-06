//
//  ViewController3.swift
//  app1
//
//  Created by Promptnow on 8/1/2562 BE.
//  Copyright © 2562 Promptnow. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

class ViewController3: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var dept: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var name: UITextField!
    
    
   // var imageRef = Storage.storage().reference().child("images")


    
    override func viewDidLoad() {
        super.viewDidLoad()
        img.layer.cornerRadius = img.frame.size.width / 2
        img.layer.masksToBounds = true

//        let storageRef = Storage.storage().reference()
//        let imagesRef = storageRef.child("images")

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "3"
    }
    
    

    @IBAction func cameraBtn(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }else {
        let alert = UIAlertController(title: "ไม่สามารถใช้กล้องได้", message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert,animated: true,completion: nil)
        }

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        img.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func add(_ sender: Any) {

        let data = name.text
        let db = Firestore.firestore()
        db.collection("Promptnow").document(data!).setData(["dept": dept.text!,
                    "name": name.text!,
                    "age": age.text!]){ err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            let alert = UIAlertController(title: "เพิ่มข้อมูลสำเร็จ", message: nil, preferredStyle: .alert)
                            let okButton = UIAlertAction(title: "OK", style: .default, handler: { action in
                                self.dept.text = ""
                                self.name.text = ""
                                self.age.text = ""
                            } )
                            alert.addAction(okButton)
                            self.present(alert,animated: true,completion: nil)                         
                        }
                    }
        
    }
}
