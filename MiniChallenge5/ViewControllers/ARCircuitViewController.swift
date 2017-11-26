//
//  createCircuit.swift
//  MiniChallenge5
//
//  Created by Vinícius Cano Santos on 09/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARCircuitViewController: UIViewController, ARSKViewDelegate {
    
    //MARK: Outlets

    @IBOutlet var sceneView: ARSKView!
    @IBOutlet weak var time: UILabel!
    
    
    //MARK: Properties
    var bow: SCNNode!
    let nodeName = "bow"
    var bows = [ARBowAnchor]()
    var greenGeometry = SCNTorus(ringRadius: 0.3, pipeRadius: 0.07)
    var redGeometry = SCNTorus(ringRadius: 0.3, pipeRadius: 0.07)
    var passage:Int = 0
    var startTime = TimeInterval()
    var isTimeCounting = false
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView = sceneView as! ARSKView
        self.sceneView.delegate = self
        sceneView!.delegate = self
        let scene = SKScene()
        scene.scaleMode = .resizeFill
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.sceneView.presentScene(scene)

        self.setUpBow()
        
        //set up geometries
        greenGeometry.firstMaterial?.diffuse.contents = UIColor.green
        redGeometry.firstMaterial?.diffuse.contents = UIColor.red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        //Setting up constraints
        //        self.labelConstraints.constant = self.view.frame.size.height * 0.149
        //        self.labelLeadingConstraint.constant = self.view.frame.size.width * 0.106
        //        self.labelTrailingConstraint.constant = self.view.frame.size.width * 0.106
        
        //Initializing ARKit session (here, the access to the camera will be necessary)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration)
        
        let message: String = "Para adicionar um arco no circuito, apenas fique no local desejado e toque em qualquer lugar da tela."
        let alert = UIAlertController(title: "Novo Circuito", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Nenhum Circuito Disponível"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Pausing the view's session
        self.sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Touches handler
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //        let cubeNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        //        cubeNode.position = SCNVector3(0, 0, -0.2) // SceneKit/AR coordinates are in meters
        //        sceneView.scene.rootNode.addChildNode(cubeNode)
        
        //find planes in the 3D space
        let location = touches.first!.location(in: sceneView)
        let existingPlaneResult = self.sceneView.hitTest(location, types: .existingPlane)
        let estimatedHotizontalResult = self.sceneView.hitTest(location, types: .estimatedHorizontalPlane)
        
        var results: [ARHitTestResult]!
        if existingPlaneResult.count == 0 {
            results = estimatedHotizontalResult
        } else {
            results = existingPlaneResult
        }
        
        //takes the farthest real word point finded
        if let closestResult = results.last {
            
            let matrix = SCNMatrix4(closestResult.worldTransform)
            
            //creates a indentity matriz that translates the point 1.5 meter up
            let translate = simd_float4x4(SCNMatrix4Translate(matrix, 0, 1.5, 0))
            
            let anchor = ARBowAnchor(transform: translate)
            bows.append(anchor)
            
            self.sceneView.session.add(anchor: anchor)
        }
        
        //        hitTestOptions[SCNHitTestOption.boundingBoxOnly] = true
        //
        //        //In case of a model be hited, removes it
        //        if let hit = hitResults.first {
        //            if let node = getParent(hit.node) {
        //                node.removeFromParentNode()
        //                return
        //            }
        //        }
        //        //Else, add a new anchor to the scene
        //        self.sceneView.session.add(anchor: ARAnchor(transform: (self.sceneView.session.currentFrame?.camera.transform)!))
        
    }
    
    @IBAction func restart(_ sender: UIBarButtonItem) {
        for bow in bows{
            bow.didPass = false
        }
    }
    
    
    //MARK: Anchor callback functions
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if !anchor.isKind(of: ARPlaneAnchor.self) {
            
//            let bowGeometry = SCNGeometry()
//
//            let newBow = bow.clone()
//            newBow.eulerAngles.y = (self.sceneView.session.currentFrame?.camera.eulerAngles.y)!
//            node.addChildNode(newBow)
//
            
            // Create a SceneKit circle
            //            let plane = SCNPlane(width: 1, height: 1)
            //            plane.cornerRadius = plane.width/2
            //            let planeNode = SCNNode(geometry: plane)
            /*
             `SCNPlane` is vertically oriented in its local coordinate space, so
             rotate the plane to match the horizontal orientation of `ARPlaneAnchor`.
             */
            //            planeNode.eulerAngles.x = -.pi / 2
            // Make the plane visualization semitransparent to clearly show real-world placement.
            //planeNode.opacity = 0.25
            
        } else {
            
            // Place content only for anchors found by plane detection.
            guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
            
            // Create a SceneKit plane to visualize the plane anchor using its position and extent.
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
            let planeNode = SCNNode(geometry: plane)
            planeNode.simdPosition = float3(planeAnchor.center.x, 0, planeAnchor.center.z)
            
            /*
             `SCNPlane` is vertically oriented in its local coordinate space, so
             rotate the plane to match the horizontal orientation of `ARPlaneAnchor`.
             */
            planeNode.eulerAngles.x = -.pi / 2
            
            // Make the plane visualization semitransparent to clearly show real-world placement.
            planeNode.opacity = 0.25
            
            /*
             Add the plane visualization to the ARKit-managed node so that it tracks
             changes in the plane anchor as plane estimation continues.
             */
            node.addChildNode(planeNode)
        }
    }
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        return SKShapeNode(fileNamed: "Purple_Circle")
    }
    
    //MARK: Scene lifetime
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        if isTimeCounting
        {
            var elapsedTime: TimeInterval = time - startTime
            
            let seconds = UInt8(elapsedTime)
            elapsedTime -= TimeInterval(seconds)
            
            let fraction = UInt8(elapsedTime * 100)
            
            //add the leading zero for minutes, seconds and millseconds and store them as string constants
            let strSeconds = String(format: "%03d", seconds)
            let strFraction = String(format: "%02d", fraction)
            
            //concatenate minuets, seconds and milliseconds as assign it to the UILabel
            DispatchQueue.main.async {
                self.time.text = "\(strSeconds):\(strFraction)"
            }
        }
        
        if let currentFrame = self.sceneView.session.currentFrame{
            if bows.count > 0 && !didEndCircuit() {
                
                var closerBow: ARBowAnchor?
                for bowAnchor in bows{
                    if closerBow == nil && bowAnchor.didPass{
                        continue
                    }
                    if closerBow == nil && !bowAnchor.didPass{
                        closerBow = bowAnchor
                    } else if bowAnchor.distance(from: currentFrame.camera) < (closerBow?.distance(from: currentFrame.camera))!
                        && !bowAnchor.didPass{
                        closerBow = bowAnchor
                    }
                }
                
//                for bowAnchor in bows {
//                    if bowAnchor != closerBow{
//                        self.sceneView.node(for: bowAnchor)?.childNodes[0].geometry = greenGeometry
//                    }
//                }
//
//                self.sceneView.node(for: closerBow!)?.childNodes[0].geometry = redGeometry

                let distance = closerBow?.distance(from: currentFrame.camera)
                
                if distance! < 0.2 {
                    
                    if passage == 10 {
                        if !isTimeCounting {
                            isTimeCounting = true
                            startTime = time
                        }
                        print("-------------------PASSOU, oloco meu!!!----------------")
                        passage = 0
                        closerBow?.pass()
                        if didEndCircuit(){
                            isTimeCounting = false
                            startTime = TimeInterval()
                            let message: String = "Parabéns você acabou o circuito!"
                            let alert = UIAlertController(title: "UHULLLLL", message: message, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        passage += 1
                    }
                } else {
                    passage = 0
                    
                }
            }
        }
    }
    
    
    //MARK: Setup functions
    
    private func setUpBow(){
        self.bow = SCNNode()
        self.bow.eulerAngles.x = Float.pi/2
        self.bow.name = nodeName
    }
    
    //MARK: Aux functionsAux
    private func getParent(_ nodeFound: SCNNode?) -> SCNNode? {
        if let node = nodeFound {
            if node.name == self.nodeName {
                return node
            } else if let parent = node.parent {
                return getParent(parent)
            }
        }
        return nil
    }
    
    private func didEndCircuit() -> Bool{
        var didEnd: Bool = true
        for bow in bows {
            didEnd = didEnd && bow.didPass
        }
        return didEnd
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
