#define PROCESSING_COLOR_SHADER

#define PI 3.14159265358979323846

uniform float time;
uniform vec2 resolution;

void main(void) {
  vec2 p = gl_FragCoord.xy / resolution.xy;
  
  vec2 rm = -1.0+2.0*p;
  //rm = abs(rm);///2.0;
  float r = length(rm);
  float a = atan(rm.y,rm.x);
  r = r*sin(1.0*a);//+time*0.025);
  a+=time*0.25;
  float rr =r*cos(a);
  float gg =r*sin(a)*rm.y;
  float bb =0.5+0.5*sin(a);//1.0*p.y;//*sin(time*PI/30.);  //r*1.0*sin(-time*2.0*a);
  

  gl_FragColor = (1.0)*vec4(rr,gg,bb,1.0);
}