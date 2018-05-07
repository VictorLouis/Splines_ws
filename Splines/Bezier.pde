class Bezier{
   
  int grade;
  ArrayList<Vector> CtrlPoints;
  ArrayList<Vector> gPoints;
  
  public Bezier(int grade, ArrayList<Vector> controlPts){
    this.grade = grade;
    this.gPoints = new ArrayList<Vector>();
    this.CtrlPoints = controlPts;
    grade();
  }
  
  private void grade(){
    
    ArrayList<ArrayList<Vector>> points = new ArrayList<ArrayList<Vector>>();
    
    if(grade == 3){
        ArrayList<Vector> a = new ArrayList<Vector>();
        for(int i = 0; i < 3; i++){
          a.add(CtrlPoints.get(i));
        }
        
        ArrayList<Vector> b = new ArrayList<Vector>();
        for(int i = 3; i < 8; i++){
          b.add(CtrlPoints.get(i));
        }

        points.add(a);
        points.add(b);
    }else if(grade == 7){
      ArrayList<Vector> pts = new ArrayList<Vector>();
      for(int i = 0; i < 8; i++){
        pts.add(CtrlPoints.get(i));
      }
      points.add(pts);
    }
     pGraphics(points);
  }
  
  private void pGraphics(ArrayList<ArrayList<Vector>> points){
    
    float a = 0.001;
      for(ArrayList p: points){
        for(float t = 0; t <= 1.0; t += a){
          spline(p,t);
      }
    }    
  }
  
  public ArrayList<Vector> spline(ArrayList<Vector> points, float t){
      
    ArrayList<Vector> splinePoints = new ArrayList<Vector>();

    for(int i=0; i<points.size()-1; i++){
        splinePoints.add(getPoint(points.get(i),points.get(i+1), t));
      }
      if(splinePoints.size() > 1){
        spline(splinePoints, t);
      }
      else if(splinePoints.size() == 1){
        gPoints.add(splinePoints.get(0));
      }
      
      return splinePoints;      
  }
  
  private Vector getPoint(Vector a, Vector b, float t){
    float x = (1-t)*a.x() + t*b.x();  
    float y = (1-t)*a.y() + t*b.y();  
    float z = (1-t)*a.z() + t*b.z();  
    return new Vector(x,y,z);  
  }
  
  public void splineDraw(){
  strokeWeight(3);
  stroke(52,139,196);
    for(int i = 0; i < this.gPoints.size()-1; i ++){
        Vector Pi = gPoints.get(i);
        Vector Pj = gPoints.get(i+1);
        line(Pi.x(),Pi.y(),Pi.z(),Pj.x(), Pj.y(),Pj.z());
    }
  }

}
