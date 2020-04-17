//fragShader
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

  //color = vec4(vertNormal,1.0);//vec3(intensity)

  color = vec4(
                vec3(
                      vertNormal.x,//intensity*mod(time,1.0),
                      vertNormal.y,//intensity*(0.5+0.5*sin(mod(time,2.0*PI))),
                      vertNormal.z//intensity*(0.5+0.5*cos(mod(time,2.0*PI)))
                ),
                1.0);

  gl_FragColor = color;  
}