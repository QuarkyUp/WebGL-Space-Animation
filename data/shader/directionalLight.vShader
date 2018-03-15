attribute vec3 position;
attribute vec3 color;
attribute vec2 uv;

uniform mat4 objectMatrix;
uniform mat4 projectionMatrix;
uniform mat4 viewMatrix;

uniform vec3 lightDir;
uniform vec3 lightColor;
uniform vec3 ambientColor;

attribute vec3 normal;

varying vec3 vColor;
varying vec2 vUv;
varying vec4 vPos;

float NL(vec3 N, vec3 L) {
  vec3 nrmN = normalize(N);
  vec3 nrmL = normalize(L);
  float result = dot(nrmN, nrmL);
  return max(result, 0.0);
}

vec3 normalizeNormal(mat4 objectMatrix, vec3 normal) {
    return (objectMatrix * vec4(normal, 0.0)).xyz;
}

void main() {
    vColor = ambientColor + color * clamp(NL(normalizeNormal(objectMatrix, normal), lightDir), 0.0, 1.0);
    vUv = uv;
    gl_Position = projectionMatrix * viewMatrix * objectMatrix * vec4(position, 1.0);
}
