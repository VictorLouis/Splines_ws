/**
 * Splines.
 *
 * Here we use the interpolator.keyFrames() nodes
 * as control points to render different splines.
 *
 * Press ' ' to change the spline mode.
 * Press 'g' to toggle grid drawing.
 * Press 'c' to toggle the interpolator path drawing.
 */

import frames.input.*;
import frames.primitives.*;
import frames.core.*;
import frames.processing.*;


// global variables
// modes: 0 natural cubic spline; 1 Hermite;
// 2 (degree 7) Bezier; 3 Cubic Bezier
int mode;

Scene scene;
Interpolator interpolator;
OrbitNode eye;
boolean drawGrid = true, drawCtrl = true;

//Choose P3D for a 3D scene, or P2D or JAVA2D for a 2D scene
String renderer = P3D;

void setup() {
  size(800, 800, renderer);
  scene = new Scene(this);
  eye = new OrbitNode(scene);
  eye.setDamping(0);
  scene.setEye(eye);
  scene.setFieldOfView(PI / 3);
  //interactivity defaults to the eye
  scene.setDefaultGrabber(eye);
  scene.setRadius(150);
  scene.fitBallInterpolation();
  interpolator = new Interpolator(scene, new Frame());
  // framesjs next version, simply go:
  //interpolator = new Interpolator(scene);

  // Using OrbitNodes makes path editable
  for (int i = 0; i < 8; i++) {
    Node ctrlPoint = new OrbitNode(scene);
    ctrlPoint.randomize();
    interpolator.addKeyFrame(ctrlPoint);
  }
}

void draw() {
  background(0);
  if (drawGrid) {
    stroke(255, 255, 0);
    scene.drawGrid(200, 50);
  }
  if (drawCtrl) {
    fill(255, 0, 0);
    stroke(255, 0, 255);
    for (Frame frame : interpolator.keyFrames())
      scene.drawPickingTarget((Node)frame);
  } else {
    fill(255, 0, 0);
    stroke(255, 0, 255);
    scene.drawPath(interpolator);
  }
  // implement me
  // draw curve according to control polygon an mode
  // To retrieve the positions of the control points do:
  // for(Frame frame : interpolator.keyFrames())
  //   frame.position();
  //scene.beginScreenCoordinates();
  pushStyle();
  fill(250);  
  textSize(30);
  switch(mode){
  case 0:
      text("Natural", -50 ,0);
  break;
  case 1:
      text("Bezier Grade 3", -80, 0);
  break;
  case 2:
      text("Bezier Grade 7", -80 ,0);
  break;
  case 3:
      text("Hermite", -50 ,0);
  break;
  }
  popStyle();
  //scene.endScreenCoordinates();
  
  ArrayList<Vector> n = new ArrayList<Vector>();
  for(Frame frame : interpolator.keyFrames()) {
    n.add(frame.position());
  }
  
  
  switch(mode){
  case 0:
    pushStyle();
    
    popStyle();
  break;
  case 1:
    pushStyle();
    Bezier bezier3 = new Bezier(3, n);
    bezier3.splineDraw();
    popStyle();
  break;
  case 2:
    pushStyle();
    Bezier bezier7 = new Bezier(7, n);
    bezier7.splineDraw();
    popStyle();
  break;
  case 3:
    pushStyle();
    Hermite herm = new Hermite(n);
    herm.splineDraw();
    popStyle();  
  break;
  }
}


void keyPressed() {
  if (key == ' ')
    mode = mode < 3 ? mode+1 : 0;
  if (key == 'g')
    drawGrid = !drawGrid;
  if (key == 'c')
    drawCtrl = !drawCtrl;
}
