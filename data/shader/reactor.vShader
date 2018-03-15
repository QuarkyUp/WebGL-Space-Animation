attribute vec3 position;
attribute vec3 color;
attribute vec2 uv;

uniform mat4 objectMatrix;
uniform mat4 projectionMatrix;
uniform mat4 viewMatrix;
uniform float currentTime;

varying vec4 vColor;
varying vec2 vUv;
void main() {
    float fireLength = 2500.0;
    float startSize = 75000.0;
    float endSize = 0.0;
    vec4 startColor = vec4(0.0, 0.8, 1.0, 1.0);
    vec4 endColor = vec4(0.0, 0.1, 1.0, 0.0);

    float particuleLife01 = fract(currentTime + position.z);

    vec4 pos4 = vec4(position, 1.0);

    pos4.z += 100.0 + particuleLife01 * fireLength;

    vColor = mix(startColor, endColor, particuleLife01);
    vUv = uv;

    float dist = length(viewMatrix * objectMatrix * pos4);

    gl_PointSize = mix(startSize, endSize, particuleLife01) / dist * cos(1000.0 * position.z) * 2.0;
    gl_Position = projectionMatrix * viewMatrix * objectMatrix * pos4;
}