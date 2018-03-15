precision highp float;

uniform sampler2D texture0;
uniform vec3 lightDir;
uniform vec3 lightSpecColor;

varying vec3 vColor;
varying vec2 vUv;
varying vec3 vObjectNormal;
varying vec3 vEyeDir;

void main() {
    vec3 eyeDir = normalize(vEyeDir);
    float specularRate = pow(max(dot(reflect(normalize(lightDir), vObjectNormal), -eyeDir), 0.0), 20.0);

    gl_FragColor = texture2D( texture0, vUv );
    gl_FragColor.rgb *= vColor;
    gl_FragColor.rgb += specularRate * lightSpecColor;
    if(gl_FragColor.a<0.2)
        discard;
}
