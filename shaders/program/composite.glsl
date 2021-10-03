/*
Complementary Shaders by EminGT, based on BSL Shaders by Capt Tatsu
*/
//Common//
#include "/lib/common.glsl"

//Varyings//
varying vec2 texCoord;

varying vec3 sunVec, upVec;

//////////Fragment Shader//////////Fragment Shader//////////Fragment Shader//////////
#ifdef FSH

//Uniforms//
uniform int frameCounter;
uniform int isEyeInWater;
uniform int worldDay;
uniform int worldTime;

uniform float blindFactor;
uniform float far, near;
uniform float frameTimeCounter;
uniform float rainStrengthS;
uniform float screenBrightness; 
uniform float timeAngle, timeBrightness, moonBrightness;
uniform float viewWidth, viewHeight, aspectRatio;
uniform float eyeAltitude;

uniform ivec2 eyeBrightnessSmooth;

uniform vec3 cameraPosition;
uniform vec3 fogColor;
uniform vec3 skyColor;

uniform mat4 gbufferProjection, gbufferProjectionInverse;
uniform mat4 gbufferModelViewInverse;
uniform mat4 shadowModelView;
uniform mat4 shadowProjection;

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D depthtex0;
uniform sampler2D depthtex1;

#ifdef LIGHT_SHAFTS
	uniform sampler2DShadow shadowtex0;
	uniform sampler2DShadow shadowtex1;
	uniform sampler2D shadowcolor0;
#endif

#ifdef RAINBOW
	uniform float rainStrength;
	uniform float wetness;
	uniform float isDry, isRainy, isSnowy;
#endif

#if ((defined BLACK_OUTLINE || defined PROMO_OUTLINE) && defined OUTLINE_ON_EVERYTHING && defined END && defined ENDER_NEBULA) || defined WATER_REFRACT || defined LIGHT_SHAFTS || defined RAINBOW
	uniform float shadowFade;
	uniform sampler2D noisetex;
#endif

#if NIGHT_VISION > 1 || ((defined BLACK_OUTLINE || defined PROMO_OUTLINE) && defined OUTLINE_ON_EVERYTHING)
	uniform float nightVision;
#endif

//Attributes//

//Optifine Constants//
const bool colortex2Clear = false;

//Common Variables//
float eBS = eyeBrightnessSmooth.y / 240.0;
float sunVisibility = clamp(dot( sunVec,upVec) + 0.0625, 0.0, 0.125) * 8.0;
float vsBrightness = clamp(screenBrightness, 0.0, 1.0);

#if WORLD_TIME_ANIMATION == 2
float modifiedWorldDay = mod(worldDay, 100.0) + 5.0;
float frametime = (worldTime + modifiedWorldDay * 24000) * 0.05 * ANIMATION_SPEED;
float cloudtime = frametime;
#endif
#if WORLD_TIME_ANIMATION == 1
float modifiedWorldDay = mod(worldDay, 100.0) + 5.0;
float frametime = frameTimeCounter * ANIMATION_SPEED;
float cloudtime = (worldTime + modifiedWorldDay * 24000) * 0.05 * ANIMATION_SPEED;
#endif
#if WORLD_TIME_ANIMATION == 0
float frametime = frameTimeCounter * ANIMATION_SPEED;
float cloudtime = frametime;
#endif

vec3 lightVec = sunVec * (1.0 - 2.0 * float(timeAngle > 0.5325 && timeAngle < 0.9675));

//Common Functions//
float GetLuminance(vec3 color) {
	return dot(color,vec3(0.299, 0.587, 0.114));
}

float GetLinearDepth(float depth) {
   return (2.0 * near) / (far + near - depth * (far - near));
}

#if defined LIGHT_SHAFTS || defined VL_CLOUDS || defined VL_NETHER
	float GetDepth(float depth) {
		return 2.0 * near * far / (far + near - (2.0 * depth - 1.0) * (far - near));
	}

	float GetDistX(float dist) {
		return (far * (dist - near)) / (dist * (far - near));
	}
#endif

#ifdef RAINBOW
	vec3 hsv2rgb(vec3 c) {
		vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
		vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
		return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
	}
#endif

//Includes//
#include "/lib/color/waterColor.glsl"
#include "/lib/color/skyColor.glsl"
#include "/lib/util/dither.glsl"
#include "/lib/atmospherics/waterFog.glsl"
#include "/lib/color/dimensionColor.glsl"
#include "/lib/util/spaceConversion.glsl"

#ifdef LIGHT_SHAFTS
	#ifdef SMOKEY_WATER_LIGHTSHAFTS
		#include "/lib/lighting/caustics.glsl"
	#endif
	#include "/lib/atmospherics/volumetricLight.glsl"
#endif

#ifdef VL_CLOUDS
	#include "/lib/atmospherics/volumetricClouds.glsl"
#endif

#ifdef VL_NETHER
	#include "/lib/atmospherics/volumetricNether.glsl"
#endif

#if (defined BLACK_OUTLINE || defined PROMO_OUTLINE) && defined OUTLINE_ON_EVERYTHING
	#ifdef OVERWORLD
		#include "/lib/atmospherics/sky.glsl"
	#endif
	#if defined END && defined ENDER_NEBULA
		#include "/lib/atmospherics/skyboxEffects.glsl"
	#endif

	#include "/lib/atmospherics/fog.glsl"
#endif

#if defined PROMO_OUTLINE && defined OUTLINE_ON_EVERYTHING
	#include "/lib/outline/promoOutline.glsl"
#endif

#if defined BLACK_OUTLINE && defined OUTLINE_ON_EVERYTHING
	#include "/lib/color/blocklightColor.glsl"
	#include "/lib/outline/blackOutline.glsl"
#endif

//Program//
void main() {
    vec4 color = texture2D(colortex0, texCoord.xy);
    vec3 translucent = texture2D(colortex1,texCoord.xy).rgb;
	float z0 = texture2D(depthtex0, texCoord.xy).r;
	float z1 = texture2D(depthtex1, texCoord.xy).r;
	float water = 0.0;

	if (translucent.b > 0.999 && z1 > z0) {
		water = 1.0;
		translucent = vec3(1.0);
	}

	#if defined LIGHT_SHAFTS || defined WATER_REFRACT || defined RAINBOW
		vec4 viewPos = gbufferProjectionInverse * (vec4(texCoord, z0, 1.0) * 2.0 - 1.0);
		viewPos /= viewPos.w;
	#endif

	#ifdef WATER_REFRACT
		if (water > 0.5) {
			vec3 worldPos = ViewToWorld(viewPos.xyz);
			vec3 refractPos = worldPos.xyz + cameraPosition.xyz;
			refractPos *= 0.005;
			float refractSpeed = 0.0035 * WATER_SPEED;
			vec2 refractPos2 = refractPos.xz + refractPos.y * 0.5 + refractSpeed * frametime;

			vec2 refractNoise = texture2D(noisetex, refractPos2).rg - vec2(0.5);

			float hand = 1.0 - float(z0 < 0.56);
			float d0 = GetLinearDepth(z0);
			//float d1 = GetLinearDepth(z1);
			float distScale0 = max((far - near) * d0 + near, 6.0);
			float fovScale = gbufferProjection[1][1] / 1.37;
			float refractScale = fovScale / distScale0;
			vec2 refractMult = vec2(0.07 * refractScale);
			refractMult *= hand * REFRACT_STRENGTH;
			refractNoise *= refractMult;
			vec2 refractCoord = texCoord.xy + refractNoise;

			float waterCheck = float(texture2D(colortex1, refractCoord).b > 0.999);
			float depthCheck0 = texture2D(depthtex0, refractCoord).r;
			float depthCheck1 = texture2D(depthtex1, refractCoord).r;
			float depthDif = GetLinearDepth(depthCheck1) - GetLinearDepth(depthCheck0);
			refractNoise *= clamp(depthDif * 150.0, 0.0, 1.0);
			refractCoord = texCoord.xy + refractNoise;
			if (depthCheck0 >= 0.56) {
				if (waterCheck > 0.95) {
					color.rgb = texture2D(colortex0, refractCoord).rgb;
					if (isEyeInWater == 1) {
						translucent = texture2D(colortex1, refractCoord).rgb;
						if (translucent.b > 0.999) translucent = vec3(1.0);
						z0 = texture2D(depthtex0, refractCoord).r;
						z1 = texture2D(depthtex1, refractCoord).r;
					}
				}
			}
		}
	#endif
    
	#if defined LIGHT_SHAFTS || defined VL_CLOUDS || defined VL_NETHER
		float dither = Bayer64(gl_FragCoord.xy);
	#endif

	#if defined BLACK_OUTLINE && defined OUTLINE_ON_EVERYTHING
		float outlineMask = BlackOutlineMask(depthtex0, depthtex1);
		float wFogMult = 1.0 + eBS;
		if (outlineMask > 0.5 || isEyeInWater > 0.5)
			BlackOutline(color.rgb, depthtex0, wFogMult);
	#endif
	
	#if defined PROMO_OUTLINE && defined OUTLINE_ON_EVERYTHING
		if (z1 - z0 > 0.0) PromoOutline(color.rgb, depthtex0);
	#endif

	if (isEyeInWater == 1 && z0 == 1.0) {
		//color.rgb *= pow(underwaterColor.rgb, vec3(0.5)) * 3;
		color.rgb = 0.8 * pow(underwaterColor.rgb * (1.0 - blindFactor), vec3(2.0));
	}

	if (isEyeInWater == 2) color.rgb *= vec3(1.0, 0.25, 0.01);

	#if defined LIGHT_SHAFTS || defined VL_CLOUDS || defined RAINBOW || defined VL_NETHER
		#ifdef OVERWORLD
			vec3 nViewPos = normalize(viewPos.xyz);
			float cosS = dot(nViewPos, lightVec);
		#else
			#ifdef NETHER
				vec3 nViewPos = normalize(viewPos.xyz);
				float cosS = dot(nViewPos, lightVec);
			#else
				float cosS = 0.0;
			#endif
		#endif
	#endif

	vec3 vl = vec3(0.0);
	vec4 clouds = vec4(0.0);
	#if defined LIGHT_SHAFTS || defined VL_CLOUDS || defined VL_NETHER
		vec3 vlAlbedo = translucent;
		if (isEyeInWater == 0 && water > 0.5) vlAlbedo = vec3(0.0);
		float depth0 = GetDepth(z0);
		float depth1 = GetDepth(z1);
		#ifdef LIGHT_SHAFTS
			vl = GetVolumetricRays(depth0, depth1, vlAlbedo, dither, cosS);
		#endif
		#if defined VL_CLOUDS && defined OVERWORLD
			clouds = GetVolumetricClouds(depth0, depth1, vlAlbedo, dither, viewPos);
		#endif
		#if defined VL_NETHER && defined NETHER
			clouds = GetVolumetricNetherClouds(depth0, depth1, vlAlbedo, dither, viewPos);
		#endif
	#endif

	#ifdef RAINBOW
		float rainbowTime = pow2(max(sunVisibility * shadowFade - timeBrightness, 0.0));
		#ifdef RAINBOW_AFTER_RAIN_CHECK
			rainbowTime *= sqrt3(max(wetness - 0.1, 0.0) * (1.0 - rainStrength) * (1.0 - rainStrengthS)) * isRainy;
		#endif
		if (rainbowTime > 0.001) {
			vec3 rainbowAlbedo = translucent;
			if (isEyeInWater == 0 && water > 0.5) rainbowAlbedo = vec3(0.0);
			float rainbowDistance = far * 0.4;
			float rainbowLength = far * 0.6;

			vec4 viewPosZ1 = gbufferProjectionInverse * (vec4(texCoord, z1, 1.0) * 2.0 - 1.0);
			viewPosZ1 /= viewPosZ1.w;
			float lViewPosZ1 = length(viewPosZ1.xyz);
			float lViewPosZ0 = length(viewPos.xyz);

			float rainbowCoord = 1.0 - (cosS + 0.7) / 0.075; // -0.7
			float rainbowCoordM = pow(rainbowCoord, 1.5);
				  rainbowCoordM = smoothstep(0.0, 1.0, rainbowCoordM * 0.75) + 0.05;
			vec3 rainbow = hsv2rgb(vec3(rainbowCoordM, 1.0, 0.5));
			rainbow = pow(rainbow, vec3(2.2)) * vec3(1.0, 0.3, 1.0);
			/*vec3 rainbow = vec3(0.5 - abs(rainbowCoord - 0.2),
								0.5 - abs(rainbowCoord - 0.5),
								0.5 - abs(rainbowCoord - 0.8));
				 rainbow = smoothstep(vec3(0.0), vec3(1.0), rainbow * 2.0);
				 rainbow *= rainbow;
				 rainbow *= rainbow;
				 rainbow *= vec3(0.5, 0.125, 0.5);*/

			float rainbowFactor = clamp(1.0 - rainbowCoord, 0.0, 1.0) * clamp(rainbowCoord, 0.0, 1.0);
				  rainbowFactor *= rainbowFactor;
				  rainbowFactor *= min(max(lViewPosZ1 - rainbowDistance, 0.0) / rainbowLength, 1.0);
				  rainbowFactor *= rainbowTime;

			if (z1 > z0 && lViewPosZ0 < rainbowDistance + rainbowLength)
			rainbow *= mix(rainbowAlbedo, vec3(1.0),
					   clamp((lViewPosZ0 - rainbowDistance) / rainbowLength, 0.0, 1.0));

			rainbow = clamp(rainbow, vec3(0.0), vec3(1.0));
			color.rgb = mix(color.rgb, rainbow * 10.0 * RAINBOW_BRIGHTNESS, rainbowFactor);
			vl = mix(vl, vec3(0.0), min(rainbowFactor * 2.0, 1.0));
			//color.rgb += rainbow;
		}
	#endif

	#if NIGHT_VISION > 1
		if (nightVision > 0.0) {
			float nightVisionGreen = length(color.rgb);
			nightVisionGreen = smoothstep(0.0, 1.0, nightVisionGreen) * 3.0 + 0.25 * sqrt(nightVisionGreen);
			float whiteFactor = 0.01;
			vec3 nightVisionFinal = vec3(nightVisionGreen * whiteFactor, nightVisionGreen, nightVisionGreen * whiteFactor);
			color.rgb = mix(color.rgb, nightVisionFinal, nightVision);
		}
	#endif
	
    /*DRAWBUFFERS:01*/
	gl_FragData[0] = color;
	gl_FragData[1] = vec4(vl, 1.0);

	#if defined VL_CLOUDS || defined VL_NETHER
    /*DRAWBUFFERS:015*/
	gl_FragData[2] = clouds;
	#endif
}

#endif

//////////Vertex Shader//////////Vertex Shader//////////Vertex Shader//////////
#ifdef VSH

//Uniforms//
uniform float timeAngle;

uniform mat4 gbufferModelView;

//Common Variables//
#ifdef OVERWORLD
	float timeAngleM = timeAngle;
#else
	#if !defined SEVEN && !defined SEVEN_2
		float timeAngleM = 0.25;
	#else
		float timeAngleM = 0.5;
	#endif
#endif

//Program//
void main() {
	texCoord = gl_MultiTexCoord0.xy;
	
	gl_Position = ftransform();

	const vec2 sunRotationData = vec2(cos(sunPathRotation * 0.01745329251994), -sin(sunPathRotation * 0.01745329251994));
	float ang = fract(timeAngleM - 0.25);
	ang = (ang + (cos(ang * 3.14159265358979) * -0.5 + 0.5 - ang) / 3.0) * 6.28318530717959;
	sunVec = normalize((gbufferModelView * vec4(vec3(-sin(ang), cos(ang) * sunRotationData) * 2000.0, 1.0)).xyz);

	upVec = normalize(gbufferModelView[1].xyz);
}

#endif
