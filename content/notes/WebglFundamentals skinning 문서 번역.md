---
tags:
  - graphics
  - translation
---

_가죽 씌우기_

---

# WebGL 스키닝

그래픽스에서 스키닝이란 여러 행렬의 가중치 기반 영향에 따라 정점 집합을 이동시키는 것을 의미합니다. 이것은 꽤 추상적입니다.

스키닝이라고 불리는 이유는 일반적으로 3D 캐릭터가 "본(bones)"으로 만들어진 "스켈레톤(skeleton)"을 갖도록 하는 데 사용되기 때문인데, 여기서 "본"은 행렬의 다른 이름이고, 각 정점마다 각 본이 그 정점에 미치는 영향을 설정합니다.

예를 들어 손 본은 캐릭터의 손 근처 정점들에 거의 100% 영향을 미치는 반면, 발 본은 동일한 정점들에 0의 영향을 미칩니다. 손목 주변의 정점들은 손 본으로부터 약간의 영향과 팔 본으로부터도 약간의 영향을 받습니다.

기본적인 부분은 본(이것은 단지 행렬 계층 구조를 말하는 멋진 방식입니다)과 가중치가 필요하다는 것입니다. 가중치는 정점당 값으로 0에서 1까지의 범위를 가지며, 특정 본-행렬이 그 정점의 위치에 얼마나 영향을 미치는지를 나타냅니다. 가중치는 데이터 측면에서 정점 색상과 비슷합니다. 정점당 하나의 가중치 세트입니다. 다시 말해 가중치는 버퍼에 저장되고 속성을 통해 제공됩니다.

일반적으로 정점당 가중치 수를 제한하는데, 그렇지 않으면 데이터가 너무 많아지기 때문입니다. 캐릭터는 15개의 본(버추어 파이터 1)에서 150-300개의 본(일부 현대 게임)까지 가질 수 있습니다. 300개의 본이 있다면 정점당 본당 300개의 가중치가 필요합니다. 캐릭터에 10000개의 정점이 있다면 300만 개의 가중치가 필요합니다.

따라서 대신 대부분의 실시간 스키닝 시스템은 정점당 약 4개의 가중치로 제한합니다. 보통 이것은 블렌더/마야/3ds max와 같은 3D 패키지에서 데이터를 가져와서 각 정점에 대해 가장 높은 가중치를 가진 4개의 본을 찾고 그 가중치를 정규화하는 익스포터/변환기에서 수행됩니다.

의사 예제를 제공하자면, 스키닝되지 않은 정점은 일반적으로 다음과 같이 계산됩니다:

```glsl
gl_Position = projection * view * model * position;
```

스키닝된 정점은 실질적으로 다음과 같이 계산됩니다:

```glsl
gl_Position = projection * view *
  (bone1Matrix * position * weight1 +
   bone2Matrix * position * weight2 +
   bone3Matrix * position * weight3 +
   bone4Matrix * position * weight4);
```

보시다시피 각 정점에 대해 4개의 서로 다른 위치를 계산한 다음 가중치를 적용하여 하나로 블렌딩하는 것과 같습니다.

본 행렬을 유니폼 배열에 저장하고, 가중치와 각 가중치가 적용되는 본을 속성으로 전달한다고 가정하면 다음과 같이 할 수 있습니다:

```glsl
attribute vec4 a_position;
attribute vec4 a_weights;        // 정점당 4개의 가중치
attribute vec4 a_boneNdx;        // 정점당 4개의 본 인덱스

uniform mat4 bones[MAX_BONES];   // 본당 1개의 행렬

gl_Position = projection * view *
  (bones[int(a_boneNdx[0])] * a_position * a_weight[0] +
   bones[int(a_boneNdx[1])] * a_position * a_weight[1] +
   bones[int(a_boneNdx[2])] * a_position * a_weight[2] +
   bones[int(a_boneNdx[3])] * a_position * a_weight[3]);
```

한 가지 문제가 더 있습니다. 원점(0,0,0)이 발 사이의 바닥에 있는 사람 모델이 있다고 가정해봅시다.

이제 머리에 행렬/본/조인트를 놓고 스키닝을 위해 그 본을 사용하려고 한다고 상상해보세요. 간단하게 유지하기 위해 머리의 정점들이 머리 본에 대해 1.0의 가중치를 갖고 다른 조인트는 그 정점들에 영향을 미치지 않도록 가중치를 설정했다고 가정합니다.

문제가 있습니다. 머리 정점들은 원점보다 2 단위 위에 있습니다. 머리 본도 원점보다 2 단위 위에 있습니다. 실제로 그 머리 정점들에 머리 본 행렬을 곱하면 원점보다 4 단위 위에 있는 정점들을 얻게 됩니다. 정점의 원래 2 단위 + 머리 본 행렬의 2 단위입니다.

해결책은 "바인드 포즈(bind pose)"를 저장하는 것인데, 이것은 각 행렬이 정점에 영향을 미치는 데 사용되기 전에 어디에 있었는지를 나타내는 조인트당 추가 행렬입니다. 이 경우 머리 행렬의 바인드 포즈는 원점보다 2 단위 위에 있을 것입니다. 이제 그 행렬의 역행렬을 사용하여 추가 2 단위를 빼낼 수 있습니다.

다시 말해, 셰이더에 전달되는 본 행렬들은 각각 역 바인드 포즈와 곱해져서 메쉬의 원점을 기준으로 한 원래 위치에서 얼마나 변경되었는지만 영향을 미치도록 합니다.

작은 예제를 만들어봅시다. 다음과 같은 그리드를 2D로 애니메이션합니다:

`b0`, `b1`, `b2`는 본 행렬입니다. `b1`은 `b0`의 자식이고 `b2`는 `b1`의 자식입니다.

- `0,1`은 본 b0로부터 1.0의 가중치를 받습니다
- `2,3`은 본 b0과 b1로부터 각각 0.5의 가중치를 받습니다
- `4,5`는 본 b1로부터 1.0의 가중치를 받습니다
- `6,7`은 본 b1과 b2로부터 각각 0.5의 가중치를 받습니다
- `8,9`는 본 b2로부터 1.0의 가중치를 받습니다

[less code more fun](https://claude.ai/chat/webgl-less-code-more-fun.html)에서 설명한 유틸리티를 사용하겠습니다.

먼저 정점이 필요하고 각 정점에 대해 영향을 미치는 각 본의 인덱스와 그 본이 얼마나 영향을 미치는지를 나타내는 0에서 1까지의 숫자가 필요합니다.

```javascript
var arrays = {
  position: {
    numComponents: 2,
    data: [
      0,  1,  // 0
      0, -1,  // 1
      2,  1,  // 2
      2, -1,  // 3
      4,  1,  // 4
      4, -1,  // 5
      6,  1,  // 6
      6, -1,  // 7
      8,  1,  // 8
      8, -1,  // 9
    ],
  },
  boneNdx: {
    numComponents: 4,
    data: [
      0, 0, 0, 0,  // 0
      0, 0, 0, 0,  // 1
      0, 1, 0, 0,  // 2
      0, 1, 0, 0,  // 3
      1, 0, 0, 0,  // 4
      1, 0, 0, 0,  // 5
      1, 2, 0, 0,  // 6
      1, 2, 0, 0,  // 7
      2, 0, 0, 0,  // 8
      2, 0, 0, 0,  // 9
    ],
  },
  weight: {
    numComponents: 4,
    data: [
     1,  0,  0,  0,  // 0
     1,  0,  0,  0,  // 1
    .5, .5,  0,  0,  // 2
    .5, .5,  0,  0,  // 3
     1,  0,  0,  0,  // 4
     1,  0,  0,  0,  // 5
    .5, .5,  0,  0,  // 6
    .5, .5,  0,  0,  // 7
     1,  0,  0,  0,  // 8
     1,  0,  0,  0,  // 9
    ],
  },
  indices: {
    numComponents: 2,
    data: [
      0, 1,
      0, 2,
      1, 3,
      2, 3, //
      2, 4,
      3, 5,
      4, 5,
      4, 6,
      5, 7, //
      6, 7,
      6, 8,
      7, 9,
      8, 9,
    ],
  },
};
// gl.createBuffer, gl.bindBuffer, gl.bufferData 호출
var bufferInfo = webglUtils.createBufferInfoFromArrays(gl, arrays);
```

각 본에 대한 행렬을 포함하여 유니폼 값을 정의할 수 있습니다:

```javascript
// 4개의 행렬, 각 본당 하나
var numBones = 4;
var boneArray = new Float32Array(numBones * 16);

var uniforms = {
  projection: m4.orthographic(-20, 20, -10, 10, -1, 1),
  view: m4.translation(-6, 0, 0),
  bones: boneArray,
  color: [1, 0, 0, 1],
};
```

boneArray에 대한 뷰를 만들 수 있는데, 각 행렬당 하나씩입니다:

```javascript
// 각 본에 대한 뷰를 만듭니다. 이것은 모든 본이
// 업로드를 위해 1개의 배열에 존재하지만
// 수학 함수와 함께 사용하기 위해 별도의
// 배열로 존재할 수 있게 합니다
var boneMatrices = [];  // 유니폼 데이터
var bones = [];         // 역 바인드 행렬로 곱하기 전의 값
var bindPose = [];      // 바인드 행렬
for (var i = 0; i < numBones; ++i) {
  boneMatrices.push(new Float32Array(boneArray.buffer, i * 4 * 16, 16));
  bindPose.push(m4.identity());  // 저장 공간만 할당
  bones.push(m4.identity());     // 저장 공간만 할당
}
```

그런 다음 본 행렬을 조작하는 코드입니다. 손가락의 본처럼 계층 구조로 회전시킬 것입니다.

```javascript
// 각 본을 각도만큼 회전하고 계층 구조 시뮬레이션
function computeBoneMatrices(bones, angle) {
  var m = m4.identity();
  m4.zRotate(m, angle, bones[0]);
  m4.translate(bones[0], 4, 0, 0, m);
  m4.zRotate(m, angle, bones[1]);
  m4.translate(bones[1], 4, 0, 0, m);
  m4.zRotate(m, angle, bones[2]);
  // bones[3]은 사용되지 않음
}
```

이제 한 번 호출하여 초기 위치를 생성하고 그 결과를 사용하여 역 바인드 포즈 행렬을 계산합니다.

```javascript
// 각 행렬의 초기 위치 계산
computeBoneMatrices(bindPose, 0);

// 역행렬 계산
var bindPoseInv = bindPose.map(function(m) {
  return m4.inverse(m);
});
```

이제 렌더링할 준비가 되었습니다.

먼저 본을 애니메이션하고 각 본에 대한 새로운 월드 행렬을 계산합니다:

```javascript
var t = time * 0.001;
var angle = Math.sin(t) * 0.8;
computeBoneMatrices(bones, angle);
```

그런 다음 각각의 결과에 역 바인드 포즈를 곱하여 위에서 언급한 문제를 처리합니다:

```javascript
// 각각에 bindPoseInverse를 곱합니다
bones.forEach(function(bone, ndx) {
  m4.multiply(bone, bindPoseInv[ndx], boneMatrices[ndx]);
});
```

그런 다음 모든 일반적인 작업, 속성 설정, 유니폼 설정 및 그리기를 수행합니다.

```javascript
gl.useProgram(programInfo.program);
// gl.bindBuffer, gl.enableVertexAttribArray, gl.vertexAttribPointer 호출
webglUtils.setBuffersAndAttributes(gl, programInfo, bufferInfo);
// gl.uniformXXX, gl.activeTexture, gl.bindTexture 호출
webglUtils.setUniforms(programInfo, uniforms);
// gl.drawArrays 또는 gl.drawIndices 호출
webglUtils.drawBufferInfo(gl, bufferInfo, gl.LINES);
```

그리고 여기 결과가 있습니다:

빨간 선이 스키닝된 메쉬입니다. 녹색과 파란색 선은 각 본 또는 "조인트"의 x축과 y축을 나타냅니다. 여러 본의 영향을 받는 정점들이 그들에게 영향을 미치는 본들 사이에서 어떻게 움직이는지 볼 수 있습니다. 스키닝이 어떻게 작동하는지 설명하는 데 중요하지 않기 때문에 본이 어떻게 그려지는지는 다루지 않았습니다. 궁금하다면 코드를 보세요.

참고: 본 대 조인트는 혼란스럽습니다. 행렬이라는 하나의 것만 있습니다. 하지만 3D 모델링 패키지에서는 보통 각 행렬 사이에 기즈모(UI 위젯)를 그립니다. 그것이 결국 본처럼 보이게 됩니다. 조인트는 행렬이 있는 곳이고, 각 조인트에서 다음 조인트까지 선이나 원뿔을 그려서 일종의 스켈레톤처럼 보이게 만듭니다.

주목할 또 다른 사소한 점은 위의 예제가 가중치와 본 인덱스에 부동소수점을 사용하고 있지만, 공간을 절약하기 위해 `UNSIGNED_BYTE`를 쉽게 사용할 수 있다는 것입니다.

불행히도 셰이더에서 사용할 수 있는 유니폼의 수에는 제한이 있습니다. WebGL의 최소 제한은 64 vec4인데, 이는 단지 8 mat4이고 아마도 다른 것들을 위해 그 유니폼 중 일부가 필요할 것입니다. 예를 들어 프래그먼트 셰이더에 `color`가 있고 `projection`과 `view`가 있는데, 이는 64 vec4의 제한이 있는 장치에서는 5개의 본만 가질 수 있다는 것을 의미합니다! [WebGLStats](https://web3dsurvey.com/webgl/parameters/MAX_VERTEX_UNIFORM_VECTORS)를 확인하면 대부분의 장치가 128 vec4를 지원하고 그 중 70%가 256 vec4를 지원하지만, 위의 샘플에서는 여전히 각각 13개와 29개의 본만 가능합니다. 13개는 90년대 초반의 버추어 파이터 1 스타일 캐릭터에도 충분하지 않고 29개는 대부분의 현대 게임에서 사용되는 숫자에 근접하지 않습니다.

이를 해결하는 몇 가지 방법이 있습니다. 하나는 모델을 오프라인에서 전처리하여 각각 N개 이하의 본을 사용하는 여러 부분으로 나누는 것입니다. 이것은 꽤 복잡하고 그 자체의 문제 세트를 가져옵니다.

또 다른 방법은 본 행렬을 텍스처에 저장하는 것입니다. 이것은 텍스처가 단지 이미지가 아니라 셰이더에 전달할 수 있는 2D 랜덤 액세스 데이터 배열이며 텍스처링을 위해 이미지를 읽는 것이 아닌 모든 종류의 것에 사용할 수 있다는 중요한 알림입니다.

유니폼 제한을 우회하기 위해 행렬을 텍스처에 전달해봅시다. 이를 쉽게 만들기 위해 부동소수점 텍스처를 사용하겠습니다. 부동소수점 텍스처는 WebGL의 선택적 기능이지만 다행히 대부분의 장치에서 지원됩니다.

다음은 확장 기능을 가져오는 코드입니다. 실패하면 사용자에게 운이 없다고 알리거나 다른 해결책을 선택하고 싶을 것입니다.

```javascript
var ext = gl.getExtension('OES_texture_float');
if (!ext) {
  return;  // 이 장치에 확장 기능이 존재하지 않음
}
```

텍스처에서 행렬을 가져오도록 셰이더를 업데이트합시다. 텍스처가 행당 하나의 행렬을 갖도록 만들 것입니다. 텍스처의 각 텍셀은 R, G, B, A를 가지며, 이것은 4개의 값이므로 행렬당 4개의 픽셀만 필요합니다. 행렬의 각 행당 하나의 픽셀입니다. 텍스처는 보통 특정 차원에서 최소 2048 픽셀이 될 수 있으므로 최소 2048개의 본 행렬을 위한 공간을 제공하며, 이는 충분합니다.

```glsl
attribute vec4 a_position;
attribute vec4 a_weight;
attribute vec4 a_boneNdx;

uniform mat4 projection;
uniform mat4 view;
uniform sampler2D boneMatrixTexture;
uniform float numBones;

// 이 오프셋들은 텍스처가 4픽셀 너비라고 가정합니다
#define ROW0_U ((0.5 + 0.0) / 4.)
#define ROW1_U ((0.5 + 1.0) / 4.)
#define ROW2_U ((0.5 + 2.0) / 4.)
#define ROW3_U ((0.5 + 3.0) / 4.)

mat4 getBoneMatrix(float boneNdx) {
  float v = (boneNdx + 0.5) / numBones;
  return mat4(
    texture2D(boneMatrixTexture, vec2(ROW0_U, v)),
    texture2D(boneMatrixTexture, vec2(ROW1_U, v)),
    texture2D(boneMatrixTexture, vec2(ROW2_U, v)),
    texture2D(boneMatrixTexture, vec2(ROW3_U, v)));
}

void main() {
  gl_Position = projection * view *
    (getBoneMatrix(a_boneNdx[0]) * a_position * a_weight[0] +
     getBoneMatrix(a_boneNdx[1]) * a_position * a_weight[1] +
     getBoneMatrix(a_boneNdx[2]) * a_position * a_weight[2] +
     getBoneMatrix(a_boneNdx[3]) * a_position * a_weight[3]);
}
```

[주목할 한 가지는 텍스처의 픽셀 또는 텍셀에 대한 텍스처 좌표가 가장자리에서 계산된다는 것입니다. [텍스처에 관한 글](https://claude.ai/chat/webgl-3d-textures.html)에서 다룬 것처럼 텍스처 좌표는 텍스처 전체에서 0에서 1까지입니다. 0은 가장 왼쪽 픽셀의 왼쪽 가장자리이고 1은 가장 오른쪽 픽셀의 오른쪽 가장자리인 것으로 밝혀졌습니다. 3픽셀 너비의 텍스처가 있다면 다음과 같을 것입니다.

특정 픽셀을 찾으려면 공식은 다음과 같습니다:

```
(x + .5) / width
```

위에서 각 픽셀에 대해 다음을 볼 수 있습니다:

```
(0 + .5) / 3 = 0.166
(1 + .5) / 3 = 0.5
(2 + .5) / 3 = 0.833
```

또는

이제 본 행렬을 넣을 수 있는 텍스처를 설정합니다:

```javascript
// 본 행렬을 위한 텍스처 준비
var boneMatrixTexture = gl.createTexture();
gl.bindTexture(gl.TEXTURE_2D, boneMatrixTexture);
// 순수 데이터를 위해 텍스처를 사용하고 싶으므로
// 필터링을 끕니다
gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST);
gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST);
// 텍스처가 2의 거듭제곱이 아닐 수 있으므로 랩핑도 끕니다
gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE);
gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);
```

그리고 그 텍스처와 본의 수를 유니폼으로 전달할 것입니다:

```javascript
var uniforms = {
  projection: m4.orthographic(-20, 20, -10, 10, -1, 1),
  view: m4.translation(-6, 0, 0),
  boneMatrixTexture,
  numBones,
  color: [1, 0, 0, 1],
};
```

그런 다음 렌더링할 때 최신 본 행렬로 텍스처를 업데이트하기만 하면 됩니다:

```javascript
// 현재 행렬로 텍스처 업데이트
gl.bindTexture(gl.TEXTURE_2D, boneMatrixTexture);
gl.texImage2D(
    gl.TEXTURE_2D,
    0,             // level
    gl.RGBA,       // internal format
    4,             // 너비 4픽셀, 각 픽셀은 RGBA를 가지므로 4픽셀은 16개의 값
    numBones,      // 본당 한 행
    0,             // border
    gl.RGBA,       // format
    gl.FLOAT,      // type
    boneArray);
```

결과는 동일하지만 유니폼을 통해 행렬을 전달하기에 충분한 유니폼이 없다는 문제를 해결했습니다.

이것이 스키닝의 기본입니다. 스키닝된 메쉬를 표시하는 코드를 작성하는 것은 그리 어렵지 않습니다. 더 어려운 부분은 실제로 데이터를 얻는 것입니다. 일반적으로 블렌더/마야/3D 스튜디오 맥스와 같은 3D 소프트웨어가 필요하며, 자신만의 익스포터를 작성하거나 필요한 모든 데이터를 제공하는 익스포터와 형식을 찾아야 합니다. 살펴보면 스킨을 로드하는 데 표시하는 것보다 10배 이상의 코드가 있고, 3D 모델링 프로그램에서 데이터를 가져오는 익스포터에는 아마 20-30배 더 많은 코드가 있을 것입니다. 여담으로 이것은 자신만의 3D 엔진을 작성하는 사람들이 종종 놓치는 것 중 하나입니다. 엔진은 쉬운 부분입니다 😜

코드가 많을 것이므로 먼저 스키닝되지 않은 모델만 표시해봅시다.

glTF 파일을 로드해봅시다. [glTF](https://www.khronos.org/gltf/)는 WebGL을 위해 설계되었습니다. 웹을 검색하여 [Junskie Pastilan](https://www.blendswap.com/user/pasilan)의 [이 범고래 블렌더 파일](https://www.blendswap.com/blends/view/65255)을 찾았습니다.

glTF에는 두 가지 최상위 형식이 있습니다. `.gltf` 형식은 일반적으로 지오메트리와 애니메이션 데이터를 포함하는 바이너리 파일인 `.bin` 파일을 참조하는 JSON 파일입니다. 다른 형식은 `.glb`로 바이너리 형식입니다. 기본적으로 짧은 헤더와 연결된 각 조각 사이의 크기/유형 섹션이 있는 하나의 바이너리 파일에 JSON 및 기타 파일을 연결한 것입니다. JavaScript의 경우 `.gltf` 형식이 시작하기에 약간 더 쉽다고 생각하므로 그것을 로드해봅시다.

먼저 [.blend 파일을 다운로드](https://www.blendswap.com/blends/view/65255)하고, [블렌더](https://blender.org/)를 설치하고, [gltf 익스포터](https://github.com/KhronosGroup/glTF-Blender-IO)를 설치하고, 파일을 블렌더에 로드하고 내보냈습니다.

간단한 참고사항: Blender, Maya, 3DSMax와 같은 3D 소프트웨어는 수천 개의 옵션을 가진 매우 복잡한 소프트웨어입니다. 1996년에 처음 3DSMax를 배울 때 약 3주 동안 하루 2-3시간씩 1000페이지 이상의 매뉴얼을 읽고 튜토리얼을 따라했습니다. 몇 년 후 Maya를 배울 때 비슷한 것을 했습니다. Blender는 그만큼 복잡하며 더 나아가 거의 모든 다른 소프트웨어와 매우 다른 인터페이스를 가지고 있습니다. 이것은 사용하기로 결정한 3D 패키지를 배우는 데 상당한 시간을 할애할 것으로 예상해야 한다는 짧은 방법입니다.

내보낸 후 텍스트 편집기에 `.gltf` 파일을 로드하고 둘러보았습니다. [이 치트 시트](https://www.khronos.org/files/gltf20-reference-guide.pdf)를 사용하여 형식을 파악했습니다.

아래 코드가 완벽한 glTF 로더가 아니라는 것을 명확히 하고 싶습니다. 범고래를 표시하기에 충분한 코드일 뿐입니다. 다른 파일을 시도하면 변경이 필요한 영역을 발견할 것 같습니다.

가장 먼저 해야 할 일은 파일을 로드하는 것입니다. 더 간단하게 만들기 위해 JavaScript의 [async/await](https://javascript.info/async-await)를 사용합시다. 먼저 `.gltf` 파일과 참조하는 모든 파일을 로드하는 코드를 작성합시다.

```javascript
async function loadGLTF(url) {
  const gltf = await loadJSON(url);
  
  // gltf 파일을 기준으로 참조된 모든 파일 로드
  const baseURL = new URL(url, location.href);
  gltf.buffers = await Promise.all(gltf.buffers.map((buffer) => {
    const url = new URL(buffer.uri, baseURL.href);
    return loadBinary(url.href);
  }));
  ...

async function loadFile(url, typeFunc) {
  const response = await fetch(url);
  if (!response.ok) {
    throw new Error(`could not load: ${url}`);
  }
  return await response[typeFunc]();
}

async function loadBinary(url) {
  return loadFile(url, 'arrayBuffer');
}

async function loadJSON(url) {
  return loadFile(url, 'json');
}
```

이제 데이터를 탐색하고 연결해야 합니다.

먼저 glTF가 메쉬로 간주하는 것을 처리합시다. 메쉬는 프리미티브의 모음입니다. 프리미티브는 효과적으로 무언가를 렌더링하는 데 필요한 버퍼와 속성입니다. [less code more fun](https://claude.ai/chat/webgl-less-code-more-fun.html)에서 다룬 webgl 유틸리티를 사용합시다. 메쉬를 탐색하고 각각에 대해 `webglUtils.setBuffersAndAttributes`에 전달할 수 있는 `BufferInfo`를 만들 것입니다. `BufferInfo`는 효과적으로 속성 정보, 인덱스(있는 경우), `gl.drawXXX`에 전달할 요소 수입니다. 예를 들어 위치와 법선만 있는 큐브는 다음 구조를 가진 BufferInfo를 가질 수 있습니다:

```javascript
const cubeBufferInfo = {
  attribs: {
    'a_POSITION': { buffer: WebGLBuffer, type: gl.FLOAT, numComponents: 3, },
    'a_NORMAL': { buffer: WebGLBuffer, type: gl.FLOAT, numComponents: 3, },
  },
  numElements: 24,
  indices: WebGLBuffer,
  elementType: gl.UNSIGNED_SHORT,
}
```

따라서 각 프리미티브를 탐색하고 그와 같은 BufferInfo를 생성할 것입니다.

프리미티브에는 속성 배열이 있으며, 각 속성은 접근자를 참조합니다. 접근자는 어떤 종류의 데이터가 있는지, 예를 들어 `VEC3`/`gl.FLOAT`를 말하고 bufferView를 참조합니다. 접근자 인덱스가 주어지면 데이터가 로드된 WebGLBuffer, 접근자, bufferView에 지정된 stride를 반환하는 코드를 작성할 수 있습니다.

```javascript
// 접근자 인덱스가 주어지면 접근자, WebGLBuffer 및 stride를 반환
function getAccessorAndWebGLBuffer(gl, gltf, accessorIndex) {
  const accessor = gltf.accessors[accessorIndex];
  const bufferView = gltf.bufferViews[accessor.bufferView];
  if (!bufferView.webglBuffer) {
    const buffer = gl.createBuffer();
    const target = bufferView.target || gl.ARRAY_BUFFER;
    const arrayBuffer = gltf.buffers[bufferView.buffer];
    const data = new Uint8Array(arrayBuffer, bufferView.byteOffset, bufferView.byteLength);
    gl.bindBuffer(target, buffer);
    gl.bufferData(target, data, gl.STATIC_DRAW);
    bufferView.webglBuffer = buffer;
  }
  return {
    accessor,
    buffer: bufferView.webglBuffer,
    stride: bufferView.stride || 0,
  };
}
```

또한 glTF 접근자 유형을 컴포넌트 수로 변환하는 방법이 필요합니다:

```javascript
function throwNoKey(key) {
  throw new Error(`no key: ${key}`);
}

const accessorTypeToNumComponentsMap = {
  'SCALAR': 1,
  'VEC2': 2,
  'VEC3': 3,
  'VEC4': 4,
  'MAT2': 4,
  'MAT3': 9,
  'MAT4': 16,
};

function accessorTypeToNumComponents(type) {
  return accessorTypeToNumComponentsMap[type] || throwNoKey(type);
}
```

이제 이러한 함수를 만들었으므로 메쉬를 설정하는 데 사용할 수 있습니다:

참고: glTF 파일은 재질을 정의할 수 있지만 익스포터는 재질 내보내기가 체크되어 있어도 파일에 재질을 넣지 않았습니다. 익스포터가 블렌더의 모든 종류의 재질을 처리하지 않는다고 추측할 수 있는데, 이는 불행한 일입니다. 파일에 재질이 없으면 기본 재질을 사용할 것입니다. 이 파일에 재질이 없으므로 glTF 재질을 사용하는 코드는 여기에 없습니다.

```javascript
const defaultMaterial = {
  uniforms: {
    u_diffuse: [.5, .8, 1, 1],
  },
};

// 메쉬 설정
gltf.meshes.forEach((mesh) => {
  mesh.primitives.forEach((primitive) => {
    const attribs = {};
    let numElements;
    for (const [attribName, index] of Object.entries(primitive.attributes)) {
      const {accessor, buffer, stride} = getAccessorAndWebGLBuffer(gl, gltf, index);
      numElements = accessor.count;
      attribs[`a_${attribName}`] = {
        buffer,
        type: accessor.componentType,
        numComponents: accessorTypeToNumComponents(accessor.type),
        stride,
        offset: accessor.byteOffset | 0,
      };
    }
    
    const bufferInfo = {
      attribs,
      numElements,
    };
    
    if (primitive.indices !== undefined) {
      const {accessor, buffer} = getAccessorAndWebGLBuffer(gl, gltf, primitive.indices);
      bufferInfo.numElements = accessor.count;
      bufferInfo.indices = buffer;
      bufferInfo.elementType = accessor.componentType;
    }
    
    primitive.bufferInfo = bufferInfo;
    
    // 이 프리미티브에 대한 재질 정보 저장
    primitive.material = gltf.materials && gltf.materials[primitive.material] || defaultMaterial;
  });
});
```

이제 각 프리미티브에는 `bufferInfo`와 `material` 속성이 있습니다.

스키닝을 위해서는 거의 항상 어떤 종류의 씬 그래프가 필요합니다. [씬 그래프에 관한 글](https://claude.ai/chat/webgl-scene-graph.html)에서 씬 그래프를 만들었으므로 그것을 사용합시다.

```javascript
class TRS {
  constructor(position = [0, 0, 0], rotation = [0, 0, 0, 1], scale = [1, 1, 1]) {
    this.position = position;
    this.rotation = rotation;
    this.scale = scale;
  }
  getMatrix(dst) {
    dst = dst || new Float32Array(16);
    m4.compose(this.position, this.rotation, this.scale, dst);
    return dst;
  }
}

class Node {
  constructor(source, name) {
    this.name = name;
    this.source = source;
    this.parent = null;
    this.children = [];
    this.localMatrix = m4.identity();
    this.worldMatrix = m4.identity();
    this.drawables = [];
  }
  setParent(parent) {
    if (this.parent) {
      this.parent._removeChild(this);
      this.parent = null;
    }
    if (parent) {
      parent._addChild(this);
      this.parent = parent;
    }
  }
  updateWorldMatrix(parentWorldMatrix) {
    const source = this.source;
    if (source) {
      source.getMatrix(this.localMatrix);
    }
    
    if (parentWorldMatrix) {
      // 행렬이 전달되었으므로 계산 수행
      m4.multiply(parentWorldMatrix, this.localMatrix, this.worldMatrix);
    } else {
      // 행렬이 전달되지 않았으므로 로컬을 월드에 복사
      m4.copy(this.localMatrix, this.worldMatrix);
    }
    
    // 이제 모든 자식 처리
    const worldMatrix = this.worldMatrix;
    for (const child of this.children) {
      child.updateWorldMatrix(worldMatrix);
    }
  }
  traverse(fn) {
    fn(this);
    for (const child of this.children) {
      child.traverse(fn);
    }
  }
  _addChild(child) {
    this.children.push(child);
  }
  _removeChild(child) {
    const ndx = this.children.indexOf(child);
    this.children.splice(ndx, 1);
  }
}
```

[씬 그래프 글](https://claude.ai/chat/webgl-scene-graph.html)의 코드와 몇 가지 주목할 만한 변경 사항이 있습니다.

이 코드는 ES6의 `class` 기능을 사용하고 있습니다. 클래스를 정의하는 옛날 스타일보다 `class` 구문을 사용하는 것이 훨씬 좋습니다.

`Node`에 drawables 배열을 추가했습니다. 이것은 이 Node에서 그릴 것들을 나열할 것입니다. 실제 그리기를 담당하는 클래스의 인스턴스를 이 목록에 넣을 것입니다. 이렇게 하면 다른 클래스를 사용하여 다양한 것들을 일반적으로 그릴 수 있습니다.

참고: Node에 drawables 배열을 넣는 것이 최선의 결정인지 명확하지 않습니다. 씬 그래프 자체가 drawables를 전혀 포함하지 않아야 할 것 같습니다. 그려야 하는 것들은 대신 데이터를 가져올 그래프의 노드를 참조할 수 있습니다. 그래프에 drawables가 있는 이 방식이 일반적이므로 그것으로 시작합시다.

`traverse` 메서드를 추가했습니다. 현재 노드를 전달하여 함수를 호출한 다음 모든 자식 노드에 대해 재귀적으로 동일한 작업을 수행합니다.

`TRS` 클래스는 회전에 쿼터니언을 사용하고 있습니다. 쿼터니언을 다루지 않았고 솔직히 설명할 만큼 충분히 이해하지 못한다고 생각합니다. 다행히 사용하는 방법을 알기 위해 작동 방식을 알 필요는 없습니다. gltf 파일에서 데이터를 가져와 그 데이터에서 행렬을 만드는 함수를 호출하고 행렬을 사용하기만 하면 됩니다.

glTF 파일의 노드는 플랫 배열로 저장됩니다. glTF의 노드 데이터를 `Node` 인스턴스로 변환할 것입니다. 나중에 필요할 것이므로 노드 데이터의 이전 배열을 `origNodes`로 저장합니다.

```javascript
const origNodes = gltf.nodes;
gltf.nodes = gltf.nodes.map((n) => {
  const {name, skin, mesh, translation, rotation, scale} = n;
  const trs = new TRS(translation, rotation, scale);
  const node = new Node(trs, name);
  const realMesh = gltf.meshes[mesh];
  if (realMesh) {
    node.drawables.push(new MeshRenderer(realMesh));
  }
  return node;
});
```

위에서 각 노드에 대해 `TRS` 인스턴스를 만들고, 각 노드에 대해 `Node` 인스턴스를 만들고, `mesh` 속성이 있으면 이전에 설정한 메쉬 데이터를 찾아서 그것을 그리기 위한 `MeshRenderer`를 만들었습니다.

`MeshRenderer`를 만들어봅시다. 이것은 [less code more fun](https://claude.ai/chat/webgl-less-code-more-fun.html)에서 단일 모델을 렌더링하는 데 사용한 코드의 캡슐화일 뿐입니다. 메쉬에 대한 참조를 보유하고 각 프리미티브에 대해 프로그램, 속성 및 유니폼을 설정하고 마지막으로 `webglUtils.drawBufferInfo`를 통해 `gl.drawArrays` 또는 `gl.drawElements`를 호출합니다.

```javascript
class MeshRenderer {
  constructor(mesh) {
    this.mesh = mesh;
  }
  render(node, projection, view, sharedUniforms) {
    const {mesh} = this;
    gl.useProgram(meshProgramInfo.program);
    for (const primitive of mesh.primitives) {
      webglUtils.setBuffersAndAttributes(gl, meshProgramInfo, primitive.bufferInfo);
      webglUtils.setUniforms(meshProgramInfo, {
        u_projection: projection,
        u_view: view,
        u_world: node.worldMatrix,
      });
      webglUtils.setUniforms(meshProgramInfo, primitive.material.uniforms);
      webglUtils.setUniforms(meshProgramInfo, sharedUniforms);
      webglUtils.drawBufferInfo(gl, primitive.bufferInfo);
    }
  }
}
```

노드를 만들었으니 이제 실제로 씬 그래프로 배열해야 합니다. 이것은 glTF에서 2가지 수준에서 수행됩니다. 먼저, 각 노드에는 노드 배열의 인덱스인 자식의 선택적 배열이 있으므로 모든 노드를 탐색하고 자식을 부모로 지정할 수 있습니다:

```javascript
function addChildren(nodes, node, childIndices) {
  childIndices.forEach((childNdx) => {
    const child = nodes[childNdx];
    child.setParent(node);
  });
}

// 노드를 그래프로 배열
gltf.nodes.forEach((node, ndx) => {
  const children = origNodes[ndx].children;
  if (children) {
    addChildren(gltf.nodes, node, children);
  }
});
```

그런 다음 씬 배열이 있습니다. 씬은 씬의 맨 아래에 있는 노드 배열의 인덱스로 노드 배열을 참조합니다. 단일 루트 노드로 시작하지 않은 이유가 명확하지 않지만, glTF 파일에 있는 것이므로 루트 노드를 만들고 씬의 모든 자식을 그 노드의 부모로 지정합니다:

```javascript
// 씬 설정
for (const scene of gltf.scenes) {
  scene.root = new Node(new TRS(), scene.name);
  addChildren(gltf.nodes, scene.root, scene.nodes);
}

return gltf;
}
```

그리고 로딩이 완료되었습니다. 적어도 메쉬만요. 메인 함수를 `async`로 표시하여 `await` 키워드를 사용할 수 있도록 합시다.

```javascript
async function main() {
```

그리고 다음과 같이 gltf 파일을 로드할 수 있습니다:

```javascript
const gltf = await loadGLTF('resources/models/killer_whale/whale.CYCLES.gltf');
```

렌더링하려면 gltf 파일의 데이터와 일치하는 셰이더가 필요합니다. gltf 파일에 있는 프리미티브의 데이터를 살펴봅시다:

```json
{
  "name" : "orca",
  "primitives" : [
    {
      "attributes" : {
        "JOINTS_0" : 5,
        "NORMAL" : 2,
        "POSITION" : 1,
        "TANGENT" : 3,
        "TEXCOORD_0" : 4,
        "WEIGHTS_0" : 6
      },
      "indices" : 0
    }
  ]
}
```

그것을 보면 렌더링하기 위해 `NORMAL`과 `POSITION`만 사용합시다. 각 속성 앞에 `a_`를 붙였으므로 다음과 같은 버텍스 셰이더가 작동할 것입니다:

```glsl
attribute vec4 a_POSITION;
attribute vec3 a_NORMAL;

uniform mat4 u_projection;
uniform mat4 u_view;
uniform mat4 u_world;

varying vec3 v_normal;

void main() {
  gl_Position = u_projection * u_view * u_world * a_POSITION;
  v_normal = mat3(u_world) * a_NORMAL;
}
```

그리고 프래그먼트 셰이더의 경우 간단한 방향성 조명을 사용합시다:

```glsl
precision mediump float;

varying vec3 v_normal;

uniform vec4 u_diffuse;
uniform vec3 u_lightDirection;

void main () {
  vec3 normal = normalize(v_normal);
  float light = dot(u_lightDirection, normal) * .5 + .5;
  gl_FragColor = vec4(u_diffuse.rgb * light, u_diffuse.a);
}
```

[방향성 조명에 관한 글](https://claude.ai/chat/webgl-3d-lighting-directional.html)에서 다룬 것처럼 내적을 취하지만, 여기서는 내적에 .5를 곱하고 .5를 더합니다. 일반적인 방향성 조명에서는 표면이 조명을 직접 마주할 때 100% 밝아지고 표면이 조명에 수직일 때 0%로 떨어집니다. 즉, 조명에서 멀어지는 모델의 전체 1/2이 검은색입니다. .5를 곱하고 .5를 더함으로써 내적을 -1 <-> 1에서 0 <-> 1로 변환하여 완전히 반대 방향을 향할 때만 검은색이 됩니다. 이것은 간단한 테스트를 위한 저렴하지만 만족스러운 조명을 제공합니다.

따라서 셰이더를 컴파일하고 링크해야 합니다.

```javascript
// 셰이더를 컴파일하고 링크하며, 속성 및 유니폼 위치를 찾습니다
const meshProgramInfo = webglUtils.createProgramInfo(gl, ["meshVS", "fs"]);
```

그런 다음 렌더링하기 위해 이전과 다른 것은 다음과 같습니다:

```javascript
const sharedUniforms = {
  u_lightDirection: m4.normalize([-1, 3, 5]),
};

function renderDrawables(node) {
  for(const drawable of node.drawables) {
    drawable.render(node, projection, view, sharedUniforms);
  }
}

for (const scene of gltf.scenes) {
  // 씬의 모든 월드 행렬 업데이트
  scene.root.updateWorldMatrix();
  // 씬을 탐색하고 모든 렌더러블 렌더링
  scene.root.traverse(renderDrawables);
}
```

이전에 남은 것(위에 표시되지 않음)은 투영 행렬, 카메라 행렬 및 뷰 행렬을 계산하는 코드입니다. 그런 다음 각 씬을 탐색하고, `scene.root.updateWorldMatrix`를 호출하여 그래프의 모든 노드의 월드 행렬을 업데이트합니다. 그런 다음 `renderDrawables`로 `scene.root.traverse`를 호출합니다.

`renderDrawables`는 `sharedUniforms`를 통해 투영, 뷰 및 조명 정보를 전달하면서 해당 노드의 모든 drawables의 render 메서드를 호출합니다.

이제 작동하니 스킨을 처리해봅시다.

먼저 스킨을 나타내는 클래스를 만들어봅시다. 씬 그래프에 적용되는 노드의 다른 단어인 조인트 목록을 관리할 것입니다. 역 바인드 행렬도 가질 것이고 조인트 행렬을 넣을 텍스처를 관리할 것입니다.

```javascript
class Skin {
  constructor(joints, inverseBindMatrixData) {
    this.joints = joints;
    this.inverseBindMatrices = [];
    this.jointMatrices = [];
    // 조인트당 하나의 행렬을 위한 충분한 공간 할당
    this.jointData = new Float32Array(joints.length * 16);
    // 각 조인트와 inverseBindMatrix에 대한 뷰 생성
    for (let i = 0; i < joints.length; ++i) {
      this.inverseBindMatrices.push(new Float32Array(
          inverseBindMatrixData.buffer,
          inverseBindMatrixData.byteOffset + Float32Array.BYTES_PER_ELEMENT * 16 * i,
          16));
      this.jointMatrices.push(new Float32Array(
          this.jointData.buffer,
          Float32Array.BYTES_PER_ELEMENT * 16 * i,
          16));
    }
    // 조인트 행렬을 보유할 텍스처 생성
    this.jointTexture = gl.createTexture();
    gl.bindTexture(gl.TEXTURE_2D, this.jointTexture);
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST);
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST);
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE);
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);
  }
  update(node) {
    const globalWorldInverse = m4.inverse(node.worldMatrix);
    // 각 조인트를 순회하고 현재 worldMatrix를 가져옵니다
    // 역 바인드 행렬을 적용하고
    // 전체 결과를 텍스처에 저장합니다
    for (let j = 0; j < this.joints.length; ++j) {
      const joint = this.joints[j];
      const dst = this.jointMatrices[j];
      m4.multiply(globalWorldInverse, joint.worldMatrix, dst);
      m4.multiply(dst, this.inverseBindMatrices[j], dst);
    }
    gl.bindTexture(gl.TEXTURE_2D, this.jointTexture);
    gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, 4, this.joints.length, 0,
                  gl.RGBA, gl.FLOAT, this.jointData);
  }
}
```

그리고 `MeshRenderer`가 있었던 것처럼 `Skin`을 사용하여 스키닝된 메쉬를 렌더링하는 `SkinRenderer`를 만들어봅시다.

```javascript
class SkinRenderer {
  constructor(mesh, skin) {
    this.mesh = mesh;
    this.skin = skin;
  }
  render(node, projection, view, sharedUniforms) {
    const {skin, mesh} = this;
    skin.update(node);
    gl.useProgram(skinProgramInfo.program);
    for (const primitive of mesh.primitives) {
      webglUtils.setBuffersAndAttributes(gl, skinProgramInfo, primitive.bufferInfo);
      webglUtils.setUniforms(skinProgramInfo, {
        u_projection: projection,
        u_view: view,
        u_world: node.worldMatrix,
        u_jointTexture: skin.jointTexture,
        u_numJoints: skin.joints.length,
      });
      webglUtils.setUniforms(skinProgramInfo, primitive.material.uniforms);
      webglUtils.setUniforms(skinProgramInfo, sharedUniforms);
      webglUtils.drawBufferInfo(gl, primitive.bufferInfo);
    }
  }
}
```

`MeshRenderer`와 매우 유사한 것을 볼 수 있습니다. 렌더링하는 데 필요한 모든 행렬을 업데이트하는 데 사용하는 `Skin`에 대한 참조가 있습니다. 그런 다음 렌더링을 위한 표준 패턴을 따라 프로그램을 사용하고, 속성을 설정하고, 텍스처도 바인딩하는 `webglUtils.setUniforms`를 사용하여 모든 유니폼을 설정한 다음 렌더링합니다.

또한 스키닝을 지원하는 버텍스 셰이더가 필요합니다:

```glsl
<script id="skinVS" type="notjs">
attribute vec4 a_POSITION;
attribute vec3 a_NORMAL;
attribute vec4 a_WEIGHTS_0;
attribute vec4 a_JOINTS_0;

uniform mat4 u_projection;
uniform mat4 u_view;
uniform mat4 u_world;
uniform sampler2D u_jointTexture;
uniform float u_numJoints;

varying vec3 v_normal;

// 이 오프셋들은 텍스처가 4픽셀 너비라고 가정합니다
#define ROW0_U ((0.5 + 0.0) / 4.)
#define ROW1_U ((0.5 + 1.0) / 4.)
#define ROW2_U ((0.5 + 2.0) / 4.)
#define ROW3_U ((0.5 + 3.0) / 4.)

mat4 getBoneMatrix(float jointNdx) {
  float v = (jointNdx + 0.5) / u_numJoints;
  return mat4(
    texture2D(u_jointTexture, vec2(ROW0_U, v)),
    texture2D(u_jointTexture, vec2(ROW1_U, v)),
    texture2D(u_jointTexture, vec2(ROW2_U, v)),
    texture2D(u_jointTexture, vec2(ROW3_U, v)));
}

void main() {
  mat4 skinMatrix = getBoneMatrix(a_JOINTS_0[0]) * a_WEIGHTS_0[0] +
                    getBoneMatrix(a_JOINTS_0[1]) * a_WEIGHTS_0[1] +
                    getBoneMatrix(a_JOINTS_0[2]) * a_WEIGHTS_0[2] +
                    getBoneMatrix(a_JOINTS_0[3]) * a_WEIGHTS_0[3];
  mat4 world = u_world * skinMatrix;
  gl_Position = u_projection * u_view * world * a_POSITION;
  v_normal = mat3(world) * a_NORMAL;
}
</script>
```

이것은 위의 스키닝 셰이더와 거의 동일합니다. gltf 파일에 있는 것과 일치하도록 속성의 이름을 변경했습니다. 가장 큰 변화는 `skinMatrix`를 만드는 것입니다. 이전 스키닝 셰이더에서는 위치에 각 개별 조인트/본 행렬을 곱하고 각 조인트에 대한 영향력의 가중치를 곱했습니다. 이 경우 대신 가중치를 곱한 행렬을 더하고 위치에 한 번만 곱합니다. 이것은 동일한 결과를 생성하지만 법선도 곱해야 하는 `skinMatrix`를 사용할 수 있으며, 그렇지 않으면 법선이 스킨과 일치하지 않습니다.

또한 여기서 `u_world` 행렬을 곱한다는 점에 주목하세요. 다음 줄과 함께 `Skin.update`에서 빼냈습니다:

```javascript
const globalWorldInverse = m4.inverse(node.worldMatrix);
// 각 조인트를 순회하고 현재 worldMatrix를 가져옵니다
// 역 바인드 행렬을 적용하고
// 전체 결과를 텍스처에 저장합니다
for (let j = 0; j < this.joints.length; ++j) {
  const joint = this.joints[j];
  const dst = this.jointMatrices[j];
  m4.multiply(globalWorldInverse, joint.worldMatrix, dst);
```

그것을 하든 안 하든 당신에게 달려 있습니다. 그렇게 하는 이유는 스킨을 인스턴스화할 수 있기 때문입니다. 다시 말해, 동일한 프레임에서 스키닝된 메쉬를 정확히 동일한 포즈로 여러 곳에서 렌더링할 수 있습니다. 아이디어는 조인트가 많다면 스키닝된 메쉬에 대한 모든 행렬 수학을 수행하는 것이 느리므로 그 수학을 한 번 수행한 다음 다른 월드 행렬로 다시 렌더링하여 다른 곳에 스키닝된 메쉬를 표시할 수 있다는 것입니다.

캐릭터 군중을 표시하는 데 유용할 수 있습니다. 불행히도 모든 캐릭터가 정확히 동일한 포즈에 있을 것이므로 실제로 그렇게 유용한지 명확하지 않습니다. 그런 상황이 실제로 얼마나 자주 발생합니까? `Skin`의 노드의 역 월드 행렬로 곱하는 것을 제거하고 셰이더에서 `u_world`로 곱하는 것을 제거할 수 있으며 결과는 동일하게 보일 것이며, 단지 그 스키닝된 메쉬를 인스턴스화할 수 없을 뿐입니다. 물론 동일한 스키닝된 메쉬를 다른 포즈로 원하는 만큼 렌더링할 수 있습니다. 다른 방향에 있는 다른 노드를 가리키는 다른 `Skin` 객체가 필요할 것입니다.

로딩 코드로 돌아가서, `Node` 인스턴스를 만들 때 `skin` 속성이 있으면 기억하여 `Skin`을 만들 수 있습니다.

```javascript
const skinNodes = [];
const origNodes = gltf.nodes;
gltf.nodes = gltf.nodes.map((n) => {
  const {name, skin, mesh, translation, rotation, scale} = n;
  const trs = new TRS(translation, rotation, scale);
  const node = new Node(trs, name);
  const realMesh = gltf.meshes[mesh];
  if (skin !== undefined) {
    skinNodes.push({node, mesh: realMesh, skinNdx: skin});
  } else if (realMesh) {
    node.drawables.push(new MeshRenderer(realMesh));
  }
  return node;
});
```

`Node`를 만든 후 `Skin`을 만들어야 합니다. 스킨은 조인트에 대한 행렬을 제공하는 노드의 인덱스 목록인 `joints` 배열을 통해 노드를 참조합니다. 스킨은 또한 파일에 저장된 역 바인드 포즈 행렬을 참조하는 접근자를 참조합니다.

```javascript
// 스킨 설정
gltf.skins = gltf.skins.map((skin) => {
  const joints = skin.joints.map(ndx => gltf.nodes[ndx]);
  const {stride, array} = getAccessorTypedArrayAndStride(gl, gltf, skin.inverseBindMatrices);
  return new Skin(joints, array);
});
```

위의 코드는 접근자 인덱스가 주어진 `getAccessorTypedArrayAndStride`를 호출했습니다. 그 코드를 제공해야 합니다. 주어진 접근자에 대해 버퍼의 데이터에 액세스하기 위한 올바른 유형의 [TypedArray](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/TypedArray) 뷰를 반환할 것입니다.

```javascript
const glTypeToTypedArrayMap = {
  '5120': Int8Array,    // gl.BYTE
  '5121': Uint8Array,   // gl.UNSIGNED_BYTE
  '5122': Int16Array,   // gl.SHORT
  '5123': Uint16Array,  // gl.UNSIGNED_SHORT
  '5124': Int32Array,   // gl.INT
  '5125': Uint32Array,  // gl.UNSIGNED_INT
  '5126': Float32Array, // gl.FLOAT
}

// GL 타입이 주어지면 필요한 TypedArray 반환
function glTypeToTypedArray(type) {
  return glTypeToTypedArrayMap[type] || throwNoKey(type);
}

// 접근자 인덱스가 주어지면 접근자와
// 버퍼의 올바른 부분에 대한 TypedArray를 모두 반환
function getAccessorTypedArrayAndStride(gl, gltf, accessorIndex) {
  const accessor = gltf.accessors[accessorIndex];
  const bufferView = gltf.bufferViews[accessor.bufferView];
  const TypedArray = glTypeToTypedArray(accessor.componentType);
  const buffer = gltf.buffers[bufferView.buffer];
  return {
    accessor,
    array: new TypedArray(
        buffer,
        bufferView.byteOffset + (accessor.byteOffset || 0),
        accessor.count * accessorTypeToNumComponents(accessor.type)),
    stride: bufferView.byteStride || 0,
  };
}
```

위의 코드에 대해 주목할 점은 하드 코딩된 WebGL 상수가 있는 테이블을 만들었다는 것입니다. 이것은 처음으로 이렇게 했습니다. 상수는 변경되지 않으므로 이렇게 하는 것이 안전합니다.

이제 스킨이 있으므로 돌아가서 참조한 노드에 추가할 수 있습니다.

```javascript
// 스킨이 있는 노드에 SkinRenderer 추가
for (const {node, mesh, skinNdx} of skinNodes) {
  node.drawables.push(new SkinRenderer(mesh, gltf.skins[skinNdx]));
}
```

이렇게 렌더링하면 차이를 볼 수 없을 수 있습니다. 노드 중 일부를 애니메이션해야 합니다. `Skin`의 각 노드, 즉 각 조인트를 순회하여 로컬 X축에서 약간 플러스 마이너스로 회전시켜봅시다.

이를 위해 각 조인트에 대한 원래 로컬 행렬을 저장합니다. 그런 다음 각 프레임마다 그 원래 행렬을 약간 회전시키고 특수 함수인 `m4.decompose`를 사용하여 행렬을 다시 위치, 회전, 스케일로 조인트로 변환합니다.

```javascript
const origMatrix = new Map();
function animSkin(skin, a) {
  for(let i = 0; i < skin.joints.length; ++i) {
    const joint = skin.joints[i];
    // 이 조인트에 대해 저장된 행렬이 없으면
    if (!origMatrix.has(joint)) {
      // 조인트에 대한 행렬 저장
      origMatrix.set(joint, joint.source.getMatrix());
    }
    // 원래 행렬 가져오기
    const origMatrix = origRotations.get(joint);
    // 회전
    const m = m4.xRotate(origMatrix, a);
    // 위치, 회전, 스케일로 분해하여
    // 조인트로 다시
    m4.decompose(m, joint.source.position, joint.source.rotation, joint.source.scale);
  }
}
```

그런 다음 렌더링하기 직전에 호출합니다:

```javascript
animSkin(gltf.skins[0], Math.sin(time) * .5);
```

참고로 `animSkin`은 대부분 해킹입니다. 이상적으로는 일부 아티스트가 만든 애니메이션을 로드하거나 코드에서 어떤 방식으로든 조작하고 싶은 특정 조인트의 이름을 알 것입니다. 이 경우 스키닝이 작동하는지 확인하고 싶었고 이것이 가장 쉬운 방법인 것 같았습니다.

계속하기 전에 몇 가지 참고 사항:

처음 작동시키려고 했을 때 대부분의 프로그램과 마찬가지로 화면에 나타나지 않았습니다.

따라서 가장 먼저 한 일은 스키닝 셰이더의 끝으로 가서 이 줄을 추가한 것입니다:

```glsl
gl_Position = u_projection * u_view * a_POSITION;
```

프래그먼트 셰이더에서는 끝에 이것을 추가하여 단색만 그리도록 변경했습니다:

```glsl
gl_FragColor = vec4(1, 0, 0, 1);
```

이것은 모든 스키닝을 제거하고 원점에 메쉬만 그립니다. 좋은 뷰를 얻을 때까지 카메라 위치를 조정했습니다.

```javascript
const cameraPosition = [5, 0, 5];
const target = [0, 0, 0];
```

이것은 범고래의 실루엣을 보여주었으므로 적어도 일부 데이터가 작동하고 있음을 알았습니다.

다음으로 프래그먼트 셰이더가 법선을 표시하도록 만들었습니다:

```glsl
gl_FragColor = vec4(normalize(v_normal) * .5 + .5, 1);
```

법선은 -1에서 1까지이므로 `* .5 + .5`는 색상으로 보기 위해 0에서 1로 조정합니다.

버텍스 셰이더로 돌아가서 법선을 그대로 전달했습니다:

```glsl
v_normal = a_NORMAL;
```

다음과 같은 뷰를 얻었습니다:

법선이 나쁠 것이라고 예상하지 않았지만 예상대로 작동하는 것으로 시작하고 실제로 작동하는지 확인하는 것이 좋았습니다.

다음으로 가중치를 확인하려고 생각했습니다. 버텍스 셰이더에서 가중치를 법선으로 전달하기만 하면 되었습니다:

```glsl
v_normal = a_WEIGHTS_0.xyz * 2. - 1.;
```

가중치는 0에서 1까지이지만 프래그먼트 셰이더가 법선을 기대하고 있으므로 가중치를 -1에서 1로 만들었습니다.

이것은 원래 색상의 엉망진창을 만들었습니다. 버그를 해결한 후 다음과 같은 이미지를 얻었습니다:

완전히 명백하게 정확하지는 않지만 어느 정도 의미가 있습니다. 각 본에 가장 가까운 정점이 강한 색상을 가질 것으로 예상하고 그 영역의 가중치가 1.0이거나 적어도 모두 유사할 것이므로 본 주변의 정점에서 그 색상의 링을 볼 것으로 예상합니다.

원래 이미지가 너무 지저분했기 때문에 조인트 인덱스도 표시해보았습니다:

```glsl
v_normal = a_JOINTS_0.xyz / (u_numJoints - 1.) * 2. - 1.;
```

인덱스는 0에서 numJoints - 1까지이므로 위의 코드는 -1에서 1까지의 값을 제공합니다.

작동하면 다음과 같은 이미지를 얻었습니다:

다시 원래는 색상의 엉망진창이었습니다. 위의 이미지는 수정된 후의 모습입니다. 범고래의 가중치에 대해 예상되는 것과 거의 일치합니다. 각 본 주변의 색상 링입니다.

버그는 `webglUtils.createBufferInfoFromArrays`가 컴포넌트 수를 파악하는 방법과 관련이 있었습니다. 지정된 것을 무시하고 추측을 시도하고 잘못 추측한 경우가 있었습니다. 버그가 수정되면 셰이더에 대한 변경 사항을 제거했습니다. 위의 코드에서 주석 처리된 상태로 남겨두었으니 원한다면 사용해볼 수 있습니다.

위의 코드가 스키닝을 설명하는 데 도움이 되도록 만들어졌음을 명확히 하고 싶습니다. 프로덕션 준비가 된 스키닝 엔진을 위한 것이 아닙니다. 프로덕션 품질 엔진을 만들려고 한다면 변경하고 싶은 많은 것들이 있을 것이라고 생각하지만, 이 예제를 거치면서 스키닝을 약간 이해하는 데 도움이 되기를 바랍니다.
