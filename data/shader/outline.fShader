precision highp float;

uniform sampler2D texture0;
uniform vec2 invScreenSize;
uniform vec3 outlineColor;
uniform float outlineSize;

varying vec2 vUv;

float unpack_depth( const in vec4 rgba_depth ) {
	const vec4 bit_shift = vec4( 1.0 / ( 255.0 * 255.0 * 255.0 ), 1.0 / ( 255.0 * 255.0 ), 1.0 / 255.0, 1.0 );
    float depth = dot( rgba_depth, bit_shift );
	return depth;
}

void main() {
    float radius = outlineSize;
    const int kernelSize = 8;
	vec2 kernel[ kernelSize ];
    kernel[0] = vec2( 1, 0 ) * invScreenSize * radius;
    kernel[1] = vec2( 1, 1 ) * invScreenSize * radius;
    kernel[2] = vec2( 0, 1 ) * invScreenSize * radius;
    kernel[3] = vec2( 1, -1 ) * invScreenSize * radius;
    kernel[4] = vec2( -1, 0 ) * invScreenSize * radius;
    kernel[5] = vec2( -1, -1 ) * invScreenSize * radius;
    kernel[6] = vec2( 0, -1 ) * invScreenSize * radius;
    kernel[7] = vec2( -1, 1 ) * invScreenSize * radius;

    float currentPixelDepth = unpack_depth( texture2D( texture0, vUv ) );
    float outlineRate = 0.0;
    for( int i=0; i < kernelSize; ++i )
    {
	    float samplePixelDepth = unpack_depth( texture2D( texture0, vUv + kernel[ i ] ) );
	    outlineRate += currentPixelDepth - samplePixelDepth;
    }
    gl_FragColor = vec4(outlineColor, step(0.00002, outlineRate));
}
