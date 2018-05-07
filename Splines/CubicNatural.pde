class CubicNatural{
  
  float X[][];
  float Y[][];
  float Z[][];
  float[] delta, gamma, omega;
  ArrayList<Vector> CtrlPoints;
  int nSize;
  
  public CubicNatural(ArrayList<Vector> controlPts){   
    this.CtrlPoints = controlPts;
    this.nSize = CtrlPoints.size();    
    this.delta = new float[CtrlPoints.size()];
    this.gamma = new float[CtrlPoints.size()];
    this.omega = new float[CtrlPoints.size()];     
    splineDef();
  }
  
  public void Gamma(){
    this.gamma[0]=0.5;

    for(int i = 1; i<this.nSize-1;++i){
       this.gamma[i]=1.0/(4.0-this.gamma[i-1]);
    }
    this.gamma[this.nSize-1]= 1.0/(2.0-this.gamma[this.nSize-2]);
  }
  
  public void Omega(ArrayList<Float> xyz){
    this.omega[0] = 3.0 * (xyz.get(1)-xyz.get(0))*this.gamma[0];

    for(int  i = 1; i< this.nSize-1; ++i){
       this.omega[i] = (3.0*(xyz.get(i+1)-xyz.get(i-1))-this.omega[i-1])*this.gamma[i];
    }
    this.omega[this.nSize-1] = (3.0*(xyz.get(this.nSize-1)-xyz.get(this.nSize-2))-this.omega[this.nSize-2])*this.gamma[this.nSize-1]; 
  }
  
  public void Delta(){   
    this.delta[this.nSize-1]=this.omega[this.nSize-1];

    for(int i=this.nSize-2;i>=0;--i){
       this.delta[i]=this.omega[i]-this.gamma[i]*this.delta[i+1]; 
    }
  }
  
  public float[][] theCoefficient(ArrayList<Float> xyz){

    float[][] ans = new float[this.nSize][4];

    for(int i = 0; i<this.nSize-1;++i){
       ans[i][0] = xyz.get(i);
       ans[i][1] = this.delta[i];
       ans[i][2] = 3.0 * (xyz.get(i+1)-xyz.get(i))-this.delta[i+1]-2.0*this.delta[i];
       ans[i][3] = 2.0 * (xyz.get(i)-xyz.get(i+1))+this.delta[i]+this.delta[i+1];
    }

    return ans;
  }
  
  public void splineDef(){
    Gamma();

    ArrayList<Float> xTemp = new ArrayList<Float>();
    ArrayList<Float> yTemp = new ArrayList<Float>();
    ArrayList<Float> zTemp = new ArrayList<Float>();

    for(Vector v: this.CtrlPoints){
       xTemp.add(new Float(v.x()));
       yTemp.add(new Float(v.y()));
       zTemp.add(new Float(v.z()));
    }

    Omega(xTemp);
    Delta();
    this.X = theCoefficient(xTemp);
    
    Omega(yTemp);
    Delta();
    this.Y = theCoefficient(yTemp);

    Omega(zTemp);
    Delta();
    this.Z = theCoefficient(zTemp);
  }
  
   public void splineDraw(){
      strokeWeight(3);
      stroke(86,246,62);
      
      float dx=1.0/20.0;

      float currentX = this.CtrlPoints.get(0).x();
      float currentY = this.CtrlPoints.get(0).y();
      float currentZ = this.CtrlPoints.get(0).z();

      float deltaX,deltaY,deltaZ;

      for(int i =0;i<this.nSize-1;++i){

        for(int j = 1; j<25;j++){

          float t = dx * (float) j;
          
          deltaX = (float) (this.X[i][0] + this.X[i][1]*t + this.X[i][2]*Math.pow(t,2) + this.X[i][3]*Math.pow(t,3));
          deltaY = (float) (this.Y[i][0] + this.Y[i][1]*t + this.Y[i][2]*Math.pow(t,2) + this.Y[i][3]*Math.pow(t,3));
          deltaZ = (float) (this.Z[i][0] + this.Z[i][1]*t + this.Z[i][2]*Math.pow(t,2) + this.Z[i][3]*Math.pow(t,3));

          line(currentX,currentY,currentZ,deltaX,deltaY,deltaZ);

          currentX = deltaX;
          currentY = deltaY;
          currentZ = deltaZ;
        }           
     }  
  }
  
}
