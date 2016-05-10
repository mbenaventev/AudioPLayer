//
//  ViewController.swift
//  AudioPLayer
//
//  Created by Miguel Benavente Valdés on 06/05/16.
//  Copyright © 2016 Miguel Benavente Valdés. All rights reserved.
//

import UIKit
import AVFoundation

struct listaReproduccion {
    var titulo : String
    var url: String
    var cover : UIImage
    
    init(titulo : String, url: String, cover : UIImage){
        self.titulo  = titulo
        self.url = url
        self.cover = cover
        
    }
}

class ViewController: UIViewController, UIPickerViewDelegate{
    
    private var reproductor: AVAudioPlayer!
    var lista : [listaReproduccion] = []
    
    
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var slidVolumen: UISlider!
    @IBOutlet weak var btnAleatorio: UIButton!
    @IBOutlet weak var pickLista: UIPickerView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.pickLista.delegate = self
        
        self.lista.append(listaReproduccion(titulo: "Titanic", url: "titanic", cover: UIImage(named: "cover-titanic")!))
        
        self.lista.append(listaReproduccion(titulo: "Mad", url: "mad", cover: UIImage(named: "cover-mad")!))
        
        self.lista.append(listaReproduccion(titulo: "Ghostbusters", url: "ghostbusters", cover: UIImage(named: "cover-ghostbusters")!))
        
        self.lista.append(listaReproduccion(titulo: "Kill Bill", url: "killbill", cover: UIImage(named: "cover-killbill")!))
        
        self.lista.append(listaReproduccion(titulo: "Sweet Home Alabama", url: "sweethomealabama", cover: UIImage(named: "cover-alabama")!))
        
        let discoSeleccionado = lista[0].titulo
        lblTitulo.text = String(discoSeleccionado)
        imgCover.image = lista[0].cover

        let sonidoURL = NSBundle.mainBundle().URLForResource("titanic", withExtension: "mp3")
        do{
            try reproductor = AVAudioPlayer(contentsOfURL: sonidoURL!)
        }
        catch{
            print("Error al cargar el medio")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reproduce() {
        if !reproductor.playing{
            reproductor.play()
            reproductor.volume = slidVolumen.value
        }
    }

    @IBAction func pausa() {
        if reproductor.playing{
            reproductor.pause()
        }
    }
    
    @IBAction func detiene() {
        if reproductor.playing{
            reproductor.stop()
            reproductor.currentTime = 0.0
        }
        else{
            reproductor.stop()
            reproductor.currentTime = 0.0
        }
     }
    @IBAction func slidVolumen(sender: UISlider) {
        reproductor.volume = sender.value
    }
    
    func convierteUrlAImage(url : String)-> UIImage{
        let imgURLs = url
        let imgURL = NSURL(string: imgURLs)
        let imgDatos = NSData(contentsOfURL: imgURL!)
        if let imagen = UIImage(data: imgDatos!){
            
            return imagen
        }
        return UIImage()
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return lista.count
        
    }
    
    /*func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return lista[row].titulo
    }*/
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let discoSeleccionado = lista[row].titulo
        lblTitulo.text = String(discoSeleccionado)
        imgCover.image = lista[row].cover
        
        let sonidoURL = NSBundle.mainBundle().URLForResource(lista[row].url, withExtension: "mp3")
        do{
            try reproductor = AVAudioPlayer(contentsOfURL: sonidoURL!)
            //Reproduce automaticamente
            if !reproductor.playing{
                reproductor.play()
                reproductor.volume = slidVolumen.value
            }
        }
        catch{
            print("Error al cargar el medio")
            if reproductor.playing{
                reproductor.stop()
                reproductor.currentTime = 0.0
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: lista[row].titulo, attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        return attributedString
    }
    
    @IBAction func Aleatorio(sender: AnyObject) {
        let cancion = Int(arc4random()) % lista.count
        //var picker = UIPickerView()
        //picker = pickLista
        
        let discoSeleccionado = lista[cancion].titulo
        lblTitulo.text = String(discoSeleccionado)
        imgCover.image = lista[cancion].cover
        
        let sonidoURL = NSBundle.mainBundle().URLForResource(lista[cancion].url, withExtension: "mp3")
        do{
            try reproductor = AVAudioPlayer(contentsOfURL: sonidoURL!)
            //Reproduce automaticamente
            if !reproductor.playing{
                reproductor.play()
                reproductor.volume = slidVolumen.value
            }
        }
        catch{
            print("Error al cargar el medio")
            if reproductor.playing{
                reproductor.stop()
                reproductor.currentTime = 0.0
            }
        }
        /*/
         /print(String(cancion), " ,1")
        //if btnAleatorio.titleLabel == "Aleatorio"{
            picker.selectRow(cancion, inComponent: cancion, animated: true)
           //pickLista.selectRow(cancion, inComponent: cancion, animated: true)
           print(String(cancion), " ,2")
        //}
        */
    }
}

