#define PROCESSING_COLOR_SHADER

#define PI 3.14159265358979323846

uniform float time;
uniform vec2 resolution;

vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}
vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main(void) {
  vec2 p = gl_FragCoord.xy / resolution.xy;
  
  vec2 rm = -1.0+2.0*p;
  //rm = abs(rm);///2.0;
  float r = length(rm);
  float a = atan(rm.y,rm.x);
  //r = r*cos(0.25*a)*sin(0.125*a);//+time*0.025);
  //a+=time*0.25;
  float auxA = (a+mod(time/4.0,2.0*PI));
  float h    = 8.0*mod(0.5+0.5*sin(a)+p.y,0.125*0.25);
  
  float s   = r*cos(2.0*a);//1.0;//a;//mod(auxA,1.0);//r*sin(a)*rm.y;
  float v   = 0.5+0.5*sin(auxA);//r+time*0.25;//r*cos(a);//1.0*p.y;//*sin(time*PI/30.);  //r*1.0*sin(-time*2.0*a);
  

  gl_FragColor = (1.0)*vec4(hsv2rgb(vec3(h,s,v)),1.0);
}

