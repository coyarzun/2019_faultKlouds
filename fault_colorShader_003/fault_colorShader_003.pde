import ddf.minim.*;
//////////////////////////////////////////////
Minim       minim;
AudioInput  in;
//////////////////////////////////////////////
PShader shader;
int     cfn;
String filename = "pNoiseShader_041";
PImage klouds;// = loadImage("../_data/klouds.jpg");
PImage    micIn;
boolean doGlitch;
//////////////////////////////////////////////
void setup() {
  cfn = 0;
  /*filename = new String[40];
  for(int i=0; i<filename.length; i++){
    filename[i] = "pNoiseShader_"+nf(i+1,3);
  }
  //size(800, 400, P3D);*/
  

  
  minim = new Minim(this);
  in = minim.getLineIn();
  micIn = createImage(in.bufferSize()/4,1,RGB);
  
  
  klouds = loadImage("../_data/klouds.jpg");
  
    peazo = createImage(vx,1170*10,RGB);
    
    
  size(1920, 1080, P3D);
  noStroke();
  loadShaderF();
}
void loadShaderF(){
  shader = loadShader("../_shaders/"+filename+".glsl");
  shader.set("resolution", float(width), float(height));
  
  //println("loading "+filename[cfn]+"...");
}
void draw() {
  noCursor();
    doMicIn();
    
  slideKlouds();
  shader.set("time", frameCount*0.1*3);  //500.0
  shader.set("texture", klouds);
  shader.set("micIn", micIn);
  
  
  float doLGlitch = 0.0, doRGlitch = 0.0;
  if(doGlitch || true){
    /*if(mode==100){
      doLGlitch = 1.0;
      doRGlitch = 1.0;
    }else*/{
      doLGlitch = random(100)>70? 1.0:0.0;
      doRGlitch = random(100)>70? 1.0:0.0;
    }
  }
  
  shader.set("doLGlitch", doLGlitch);
  shader.set("doRGlitch", doRGlitch);
  shader.set("leftGlitch", random(0.5));
  shader.set("rightGlitch", random(0.5,1));
  
  
  shader(shader);
  noStroke();
  scale(4);
  rect(0, 0, width/4, height/4);
  if(recording)record();
}

boolean recording;

void record(){
  saveFrame("../_renders/_animated/"+filename+"/"+filename+"_####.png");
  globalFrame++;
  println("saving zqnce");
  if(globalFrame>= 1*60*30+58*30 ) recording= false;
}
void keyPressed(){
//  if(keyCode==37){
//    cfn--; cfn+=filename.length; cfn%=(filename.length);
//    loadShaderF();
//  }
//  if(keyCode==39){
//    cfn++; cfn%=(filename.length);
//    loadShaderF();
//  }
  if(keyCode==32){
    recording=!recording;
    if(recording==true)globalFrame = 0;
  }
  if(key=='s'){
    //saveFrame("../_renders/_stills/"+filename+"_####.png");
    println("still saved");
  }
    if(key=='u'){
    loadShaderF();
  }
}
int globalFrame;
int vx = 1;
PImage peazo;// = createImage(20,klouds.height,RGB);

void slideKlouds(){
  peazo.copy(klouds, 0, 0, vx, klouds.height, 0, 0, peazo.width, peazo.height);
  klouds.copy(klouds,vx,0,klouds.width,klouds.height,0,0,klouds.width-vx,klouds.height);
  klouds.copy(peazo,0,0,peazo.width,peazo.height,klouds.width-vx,0,klouds.width,klouds.height);
  if(random(10000)>9800) klouds = loadImage("../_data/klouds.jpg");
}
void doMicIn(){
  for(int i = 0; i < micIn.width; i++)  {//crear var independiente para resolucion de audio
    float c = abs(in.left.get(i))*255*inputGain;
    micIn.set(i, 0, color(c,c,c));
  }
}
float inputGain, timeScale = 0.015;
