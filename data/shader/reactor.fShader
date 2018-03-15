precision highp float;
uniform sampler2D texture0;

varying vec4 vColor;

void main() {

    gl_FragColor = vColor * texture2D(texture0, gl_PointCoord);
    gl_FragColor.a = 0.5 - distance(gl_PointCoord, vec2(0.5, 0.5));
}