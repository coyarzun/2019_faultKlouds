#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PI 3.14159265358979323846

varying vec3 vertNormal;
varying vec3 vertLightDir;

uniform float time;

void main() {  
  float intensity;
  vec4 color;
  intensity = max(0.0, dot(vertLightDir, vertNormal));

/*
  if (intensity > 0.95) {
    color = vec4(1.0, 0.5, 0.5, 1.0);
  } else if (intensity > 0.5) {
    color = vec4(0.6, 0.3, 0.3, 1.0);
  } else if (intensity > 0.25) {
    color = vec4(0.4, 0.2, 0.2, 1.0);
  } else {
    color = vec4(0.2, 0.1, 0.1, 1.0);
  }
*/
  //color = vec4(vertNormal,1.0);//vec3(intensity)
  color = vec4(vec3(mod(vertNormal.z+time,1.0),vertNormal.x,0.5+0.5*sin(mod(time,2.0*PI))),1.0);//vec3(intensity)

  gl_FragColor = color;  
}