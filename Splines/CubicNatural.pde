class CubicNatural{
  
  float x[][];
  float y[][];
  float z[][];
  float[] delta, gamma, omega;
  ArrayList<Vector> CtrlPoints;
  int nSize;
  
  public CubicNatural(ArrayList<Vector> controlPts){   
    this.CtrlPoints = controlPts;
    this.nSize = CtrlPoints.size();    
    this.delta = new float[CtrlPoints.size()];
    this.gamma = new float[CtrlPoints.size()];
    this.omega = new float[CtrlPoints.size()];         
  }
  
  public void Gamma(){
    this.gamma[0]=0.5;

    for(int i = 1; i<this.nSize-1;++i){
       this.gamma[i]=1.0/(4.0-this.gamma[i-1]);
    }
    this.gamma[this.nSize-1]= 1.0/(2.0-this.gamma[this.nSize-2]);
  }
  
  
}
