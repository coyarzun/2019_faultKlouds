#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

#define PI 3.14159265358979323846

uniform sampler2D texture;

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
float rand(float n){return fract(sin(n) * 43758.5453123);}
void main(void) {
  vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
 
  float r = length(p);
  float a = atan(p.y,p.x);

  vec2 uv;
  float gmin = -0.5, gmax = -gmin;
  
  if(abs(mod(p.y*200.0,2.0))<=1.0){
      uv.x = p.x+0.5*sin(5.0*(p.y)*PI+time*0.5);//+time);//+time;//cos(a+time);//r*cos(a+time);//p.x;
      uv.y = -p.y+0.5*sin(2.0*(p.x)*PI+time*0.5);//;//+r+time;//sin(a+time);//;//r*cos(a);//+time/1.0);//p.y;//
  }else{
      uv.x = p.x;
      uv.y = -p.y;
  }

  if(p.x<gmin){
    uv.x = gmin;
    uv.y = -uv.y;
  }else if(p.x>gmax){
      uv.x = gmax;
      uv.y = -uv.y;
  }


  vec3 col = texture2D(texture, 0.5+0.5 * uv).xyz;
  float h = col.x;
  h = mod(h+time,1.0);

  gl_FragColor = vec4(hsv2rgb(vec3(h,1.0,1.0)), 1.0);///  //rgb2hsv
}