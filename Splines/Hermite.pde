class Hermite{
  
  ArrayList<Vector> CtrlPoints;
  int nSize;
  
  public Hermite(ArrayList<Vector> controlPts){  
    this.CtrlPoints = controlPts;
    this.nSize = CtrlPoints.size();
  }
  
  public void splineDraw(){
    strokeWeight(3);
    stroke(255,149,67);
    Vector temp = null;
    Vector currentPoint = CtrlPoints.get(0);

    for(int i=1; i<nSize-2;i++){
        Vector P0 = CtrlPoints.get(i);
        Vector P1 = CtrlPoints.get(i+1);

        currentPoint = P0;
        Vector m0= Vector.multiply( Vector.subtract( CtrlPoints.get(i+1), CtrlPoints.get(i-1) ), 0.5 );
        Vector m1= Vector.multiply( Vector.subtract( CtrlPoints.get(i+1), CtrlPoints.get(i-1) ), 0.5 ); 

        for(float t=0; t<=1; t+=0.01){  
            //https://en.wikipedia.org/wiki/Cubic_Hermite_spline#Representations
            float h00 = 2*pow(t,3)-3*pow(t,2)+1;
            float h10 = pow(t,3)-2*pow(t,2)+t;
            float h01 = -2*pow(t,3)+3*pow(t,2);
            float h11 = pow(t,3)-pow(t,2);

            Vector temp1 = Vector.add(Vector.multiply(P0, h00),Vector.multiply(m0, h10));
            Vector temp2 = Vector.add(Vector.multiply(P1, h01),Vector.multiply(m1, h11));
            temp = Vector.add(temp1, temp2);

            line(currentPoint.x(),currentPoint.y(),currentPoint.z(),temp.x(),temp.y(),temp.z());
            currentPoint = temp;
        }  

    line(currentPoint.x(),currentPoint.y(),currentPoint.z(),P1.x(),P1.y(),P1.z());
    }
    
  }

}
