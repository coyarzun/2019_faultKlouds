#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;

uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;

void main(void) {
  vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
  vec2 m = -1.0 + 2.0 * mouse.xy / resolution.xy;

  float r = length(p);
  float a = atan(p.y,p.x);

  vec2 uv;
  uv.x = p.x+r+time;//cos(a+time);//r*cos(a+time);//p.x;
  uv.y = -p.y+r+time;//sin(a+time);//;//r*cos(a);//+time/1.0);//p.y;//

  //float w = r1 * r2 * 0.8;
  vec3 col = texture2D(texture, 0.5+0.5 * uv).xyz;

  gl_FragColor = vec4(col , 1.0);/// (0.01 + w)
}