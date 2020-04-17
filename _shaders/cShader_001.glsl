#define PROCESSING_COLOR_SHADER

#define PI 3.14159265358979323846

uniform float time;
uniform vec2 resolution;


void main(void) {
  vec2 p = gl_FragCoord.xy / resolution.xy;
  p = -1.0+2.0*p;//center
  vec2 rm = abs(p);
  float r = length(rm);
  float a = atan(rm.y,rm.x);


  float rr =r*1.0;//*sin(time*1.0*a);
  float gg =a*1.0;//*cos(time*1.0*a);
  float bb =r*1.0*sin(-time*2.0*a);
  

  gl_FragColor = (1.0)*vec4(rr,gg,bb,1.0);
}