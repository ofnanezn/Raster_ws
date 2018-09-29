import java.util.Random;
import java.lang.Math.*;

float edgeFunction(Vector a, Vector b, Vector c) { 
    return ((c.x() - a.x()) * (b.y() - a.y()) - (c.y() - a.y()) * (b.x() - a.x())); 
} 

float[] compute(Vector p, float delta){
  boolean inside = true;
  float[] lambda = new float[3];
  float[] edge = new float[3];
  float area = edgeFunction(v[0], v[1], v[2]);
  //if( p.x()  && p.y() )
  if( !orientation( v[0], v[1], v[2] ) ){
    for(int i = 0; i < 3; i++){
      float e0 = edgeFunction(v[i], v[(i+1)%3], new Vector(p.x()-delta,p.y()-delta));
      float e1 = edgeFunction(v[i], v[(i+1)%3], new Vector(p.x()+delta,p.y()-delta));
      float e2 = edgeFunction(v[i], v[(i+1)%3], new Vector(p.x()-delta,p.y()+delta));
      float e3 = edgeFunction(v[i], v[(i+1)%3], new Vector(p.x()+delta,p.y()+delta));
      float ef1 = edgeFunction(v[(i+1)%3], v[(i+2)%3], new Vector(p.x(),p.y()));
      float ef2 = edgeFunction(v[(i+2)%3], v[(i+3)%3], new Vector(p.x(),p.y()));
      if((e0 * e3 <= 0 || e1*e2 <= 0) && (ef1 <= 0 && ef2 <= 0 )){
        return new float[]{-1,-1,-1};
      }
    }
    for(int i = 2; i >= 0; i--){
      edge[i] = edgeFunction(v[(i+1)%3], v[i], p);
      inside &= edge[i] > 0;
    }
  }else{
    for(int i = 0; i < 3; i++){
      float e0 = edgeFunction(v[i], v[(i+1)%3], new Vector(p.x()-delta,p.y()-delta));
      float e1 = edgeFunction(v[i], v[(i+1)%3], new Vector(p.x()+delta,p.y()-delta));
      float e2 = edgeFunction(v[i], v[(i+1)%3], new Vector(p.x()-delta,p.y()+delta));
      float e3 = edgeFunction(v[i], v[(i+1)%3], new Vector(p.x()+delta,p.y()+delta));
      float ef1 = edgeFunction(v[(i+1)%3], v[(i+2)%3], new Vector(p.x(),p.y()));
      float ef2 = edgeFunction(v[(i+2)%3], v[(i+3)%3], new Vector(p.x(),p.y()));
      if((e0 * e3 <= 0 || e1*e2 <= 0) && (ef1 > 0 && ef2>0 )){
        return new float[]{-1,-1,-1};
      }
    }
    for(int i = 0; i < 3; i++){
      edge[i] = edgeFunction(v[i], v[(i+1)%3], p);
      inside &= edge[i] > 0;
    }
  }
  if( !inside ) return null;
  lambda[0] = abs(edge[1]/area);
  lambda[1] = abs(edge[2]/area);
  lambda[2] = abs(edge[0]/area);
  return lambda;
}

boolean orientation(Vector v0, Vector v1, Vector v2){
  Vector a = new Vector( v2.x() - v0.x(), v2.y() - v0.y() );
  Vector b = new Vector( v1.x() - v0.x(), v1.y() - v0.y() );
  return a.x() * b.y() - a.y() * b.x() > 0;
}

public class Color {
    public int r;
    public int g;
    public int b;
    public Color(int r, int g, int b){
      this.r = r;
      this.g = g;
      this.b = b;
    }
}

public color randomColor(){
  Random r = new Random();
  return color(r.nextInt(256), r.nextInt(256), r.nextInt(256));
}
