---
title: 'learnopengl.com Normal-Mapping 문서 번역'
tags:
  - graphics
  - translation
---

_빛이 있으라_

---

[원문](https://learnopengl.com/Advanced-Lighting/Normal-Mapping)

---

# 노멀 매핑

Advanced-Lighting/Normal-Mapping

우리의 모든 장면은 메시로 가득 차 있으며, 각각은 수백 또는 수천 개의 삼각형으로 구성되어 있습니다. 우리는 이 평평한 삼각형에 2D 텍스처를 감싸서 폴리곤이 그저 작은 평평한 삼각형이라는 사실을 숨김으로써 사실감을 높였습니다. 텍스처는 도움이 되지만, 메시를 가까이에서 자세히 보면 여전히 기저의 평평한 표면을 보는 것은 꽤 쉽습니다. 하지만 대부분의 실제 표면은 평평하지 않으며 많은 (울퉁불퉁한) 디테일을 나타냅니다.

예를 들어, 벽돌 표면을 생각해보세요. 벽돌 표면은 꽤 거친 표면이며 명백히 완전히 평평하지 않습니다: 움푹 들어간 시멘트 줄무늬와 많은 세밀한 작은 구멍과 균열이 있습니다. 조명이 있는 장면에서 그러한 벽돌 표면을 본다면 몰입감은 쉽게 깨집니다. 아래에서 우리는 포인트 라이트에 의해 조명되는 평평한 표면에 적용된 벽돌 텍스처를 볼 수 있습니다.

![OpenGL의 포인트 라이트에 의해 조명된 벽돌 표면. 너무 현실적이지 않습니다; 평평한 구조가 이제 꽤 명백합니다](https://claude.ai/img/advanced-lighting/normal_mapping_flat.png)

조명은 작은 균열과 구멍을 전혀 고려하지 않으며 벽돌 사이의 깊은 줄무늬를 완전히 무시합니다; 표면은 완벽하게 평평해 보입니다. 우리는 깊이나 다른 디테일 때문에 일부 표면이 덜 조명되는 것처럼 가장하기 위해 스페큘러 맵을 사용하여 평평한 외관을 부분적으로 수정할 수 있지만, 그것은 실제 솔루션이라기보다는 해킹에 가깝습니다. 우리에게 필요한 것은 표면의 모든 작은 깊이 같은 디테일에 대해 조명 시스템에 알릴 수 있는 방법입니다.

이것을 빛의 관점에서 생각해본다면: 표면이 완전히 평평한 표면으로 조명되는 이유는 무엇일까요? 답은 표면의 법선 벡터입니다. 조명 기법의 관점에서 볼 때, 물체의 형태를 결정하는 유일한 방법은 수직 법선 벡터입니다. 벽돌 표면은 단일 법선 벡터만 가지고 있으며, 그 결과 표면은 이 법선 벡터의 방향을 기반으로 균일하게 조명됩니다. 각 프래그먼트에 대해 동일한 표면별 법선 대신, 각 프래그먼트에 대해 다른 프래그먼트별 법선을 사용하면 어떨까요? 이렇게 하면 표면의 작은 디테일을 기반으로 법선 벡터를 약간 벗어나게 할 수 있습니다; 이것은 표면이 훨씬 더 복잡하다는 착각을 줍니다:

![OpenGL의 노멀 매핑을 위한 표면별 법선과 프래그먼트별 법선을 표시하는 표면](https://claude.ai/img/advanced-lighting/normal_mapping_surfaces.png)

프래그먼트별 법선을 사용함으로써 우리는 조명을 속여 표면이 (법선 벡터에 수직인) 작은 평면들로 구성되어 있다고 믿게 만들 수 있으며, 표면에 엄청난 디테일 향상을 제공합니다. 표면별 법선과 비교하여 프래그먼트별 법선을 사용하는 이 기법을 **노멀 매핑(normal mapping)** 또는 **범프 매핑(bump mapping)**이라고 합니다.

![OpenGL에서 노멀 매핑이 없는 표면과 있는 표면](https://claude.ai/img/advanced-lighting/normal_mapping_compare.png)

보시다시피, 이것은 상대적으로 낮은 비용으로 디테일의 엄청난 향상을 제공합니다. 프래그먼트당 법선 벡터만 변경하므로 조명 방정식을 변경할 필요가 없습니다. 이제 우리는 보간된 표면 법선 대신 프래그먼트별 법선을 조명 알고리즘에 전달합니다. 그러면 조명이 나머지를 처리합니다.

## 노멀 매핑

노멀 매핑이 작동하도록 하려면 프래그먼트별 법선이 필요합니다. 디퓨즈 맵과 스페큘러 맵으로 했던 것과 유사하게, 프래그먼트별 법선 데이터를 저장하기 위해 2D 텍스처를 사용할 수 있습니다. 이렇게 하면 특정 프래그먼트에 대한 법선 벡터를 얻기 위해 2D 텍스처를 샘플링할 수 있습니다.

법선 벡터는 기하학적 엔티티이고 텍스처는 일반적으로 색상 정보에만 사용되지만, 텍스처에 법선 벡터를 저장하는 것이 즉시 명백하지 않을 수 있습니다. 텍스처의 색상 벡터에 대해 생각해보면 `r`, `g`, `b` 구성 요소가 있는 3D 벡터로 표현됩니다. 우리는 유사하게 법선 벡터의 `x`, `y`, `z` 구성 요소를 각각의 색상 구성 요소에 저장할 수 있습니다. 법선 벡터는 `-1`과 `1` 사이의 범위를 가지므로 먼저 `[0, 1]`로 매핑됩니다:

```glsl
vec3 rgb_normal = normal * 0.5 + 0.5; // [-1,1]에서 [0,1]로 변환
```

이렇게 RGB 색상 구성 요소로 변환된 법선 벡터를 사용하여, 표면의 형태로부터 파생된 프래그먼트별 법선을 2D 텍스처에 저장할 수 있습니다. 예제 **노멀 맵**은 다음과 같습니다:

![OpenGL 노멀 매핑의 노멀 맵 이미지](https://claude.ai/img/advanced-lighting/normal_mapping_normal_map.png)

이것(그리고 온라인에서 찾을 수 있는 거의 모든 노멀 맵)은 푸르스름한 색조를 가질 것입니다. 이것은 법선들이 모두 양의 z축 $(0, 0, 1)$을 향해 바깥쪽을 가리키고 있기 때문입니다: 푸르스름한 색상. 색상의 편차는 일반적인 양의 z 방향에서 약간 벗어난 법선 벡터를 나타내며, 텍스처에 깊이감을 제공합니다. 예를 들어, 각 벽돌의 상단에서 색상이 더 녹색을 띠는 경향이 있는 것을 볼 수 있는데, 이것은 벽돌의 상단면이 양의 y 방향 $(0, 1, 0)$을 더 많이 가리키는 법선을 가질 것이기 때문에 이치에 맞으며, 이것은 우연히 녹색입니다!

양의 z축을 보고 있는 간단한 평면으로, 우리는 [이](https://claude.ai/img/textures/brickwall.jpg) 디퓨즈 텍스처와 [이](https://claude.ai/img/textures/brickwall_normal.jpg) 노멀 맵을 사용하여 이전 섹션의 이미지를 렌더링할 수 있습니다. 링크된 노멀 맵은 위에 표시된 것과 다릅니다. 그 이유는 OpenGL이 텍스처 좌표를 y(또는 v) 좌표가 텍스처가 일반적으로 생성되는 방식과 반대로 읽기 때문입니다. 따라서 링크된 노멀 맵은 y(또는 녹색) 구성 요소가 반전되어 있습니다(녹색이 이제 아래쪽을 가리키는 것을 볼 수 있습니다); 이것을 고려하지 않으면 조명이 잘못됩니다. 두 텍스처를 로드하고 적절한 텍스처 유닛에 바인딩하고, 조명 프래그먼트 셰이더에서 다음과 같은 변경 사항으로 평면을 렌더링하세요:

```glsl
uniform sampler2D normalMap;

void main()
{
    // [0,1] 범위의 노멀 맵에서 법선 얻기
    normal = texture(normalMap, fs_in.TexCoords).rgb;
    // 법선 벡터를 [-1,1] 범위로 변환
    normal = normalize(normal * 2.0 - 1.0);
    [...]
    // 정상적으로 조명 진행
}
```

여기서 우리는 샘플링된 법선 색상을 `[0, 1]`에서 `[-1, 1]`로 다시 매핑하여 법선을 RGB 색상으로 매핑하는 과정을 역전시킨 다음, 다가오는 조명 계산에 샘플링된 법선 벡터를 사용합니다. 이 경우 우리는 Blinn-Phong 셰이더를 사용했습니다.

시간이 지남에 따라 광원을 천천히 움직이면 노멀 맵을 사용하여 깊이감을 정말로 느낄 수 있습니다. 이 노멀 매핑 예제를 실행하면 이 장의 시작 부분에 표시된 것과 정확히 동일한 결과를 얻습니다:

![OpenGL에서 노멀 매핑이 없는 표면과 있는 표면](https://claude.ai/img/advanced-lighting/normal_mapping_correct.png)

하지만 노멀 맵의 이러한 사용을 크게 제한하는 문제가 하나 있습니다. 우리가 사용한 노멀 맵은 모두 양의 z 방향을 어느 정도 가리키는 법선 벡터를 가지고 있었습니다. 이것은 평면의 표면 법선도 양의 z 방향을 가리키고 있었기 때문에 작동했습니다. 하지만 양의 y 방향을 가리키는 표면 법선 벡터를 가진 바닥에 놓인 평면에 같은 노멀 맵을 사용하면 어떻게 될까요?

![OpenGL에서 탄젠트 공간 변환 없이 노멀 매핑이 적용된 평면의 이미지, 잘못 보입니다](https://claude.ai/img/advanced-lighting/normal_mapping_ground.png)

조명이 올바르게 보이지 않습니다! 이것은 이 평면의 샘플링된 법선이 대부분 양의 y 방향을 가리켜야 함에도 불구하고 여전히 대략 양의 z 방향을 가리키고 있기 때문에 발생합니다. 그 결과, 조명은 평면이 양의 z 방향을 가리키고 있었을 때와 표면의 법선이 동일하다고 생각합니다; 조명이 잘못되었습니다. 아래 이미지는 이 표면에서 샘플링된 법선이 대략 어떻게 보이는지 보여줍니다:

![OpenGL에서 탄젠트 공간 변환 없이 노멀 매핑이 적용되고 법선이 표시된 평면의 이미지, 잘못 보입니다](https://claude.ai/img/advanced-lighting/normal_mapping_ground_normals.png)

모든 법선이 양의 y 방향을 가리켜야 함에도 불구하고 어느 정도 양의 z 방향을 가리키고 있는 것을 볼 수 있습니다. 이 문제에 대한 한 가지 해결책은 표면의 가능한 각 방향에 대해 노멀 맵을 정의하는 것입니다; 큐브의 경우 6개의 노멀 맵이 필요합니다. 하지만 수백 개 이상의 가능한 표면 방향을 가질 수 있는 고급 메시의 경우 이것은 실행 불가능한 접근법이 됩니다.

다른 좌표 공간에서 모든 조명을 수행하는 다른 솔루션이 존재합니다: 노멀 맵 벡터가 항상 양의 z 방향을 가리키는 좌표 공간입니다; 그러면 다른 모든 조명 벡터가 이 양의 z 방향에 상대적으로 변환됩니다. 이렇게 하면 방향에 관계없이 항상 같은 노멀 맵을 사용할 수 있습니다. 이 좌표 공간을 **탄젠트 공간(tangent space)**이라고 합니다.

## 탄젠트 공간

노멀 맵의 법선 벡터는 탄젠트 공간에서 표현되며, 여기서 법선은 항상 대략 양의 z 방향을 가리킵니다. 탄젠트 공간은 삼각형의 표면에 로컬인 공간입니다: 법선은 개별 삼각형의 로컬 참조 프레임에 상대적입니다. 그것을 노멀 맵의 벡터의 로컬 공간으로 생각하세요; 최종 변환된 방향에 관계없이 모두 양의 z 방향을 가리키도록 정의됩니다. 특정 행렬을 사용하여 이 로컬 탄젠트 공간에서 월드 또는 뷰 좌표로 법선 벡터를 변환하여 최종 매핑된 표면의 방향을 따라 방향을 지정할 수 있습니다.

양의 y 방향을 보고 있는 이전 섹션의 잘못된 노멀 맵 표면이 있다고 가정해봅시다. 노멀 맵은 탄젠트 공간에서 정의되므로, 문제를 해결하는 한 가지 방법은 탄젠트 공간에서 다른 공간으로 법선을 변환하여 표면의 법선 방향과 정렬되도록 하는 행렬을 계산하는 것입니다: 그러면 법선 벡터가 모두 대략 양의 y 방향을 가리킵니다. 탄젠트 공간의 좋은 점은 탄젠트 공간의 z 방향을 표면의 법선 방향과 적절하게 정렬할 수 있도록 모든 유형의 표면에 대해 이 행렬을 계산할 수 있다는 것입니다.

그러한 행렬을 **TBN** 행렬이라고 하며, 이는 **T**angent, **B**itangent, **N**ormal 벡터의 약자입니다. 이것들은 탄젠트 공간에서 다른 공간으로 변환하는 데 필요한 벡터입니다. 이 세 벡터를 생성하기 위해 [카메라](https://learnopengl.com/Getting-Started/Camera) 장에서 했던 것과 유사한 과정이 필요합니다.

우리는 이미 표면의 법선 벡터인 위쪽 벡터를 알고 있습니다. 오른쪽과 앞쪽 벡터는 각각 탄젠트와 바이탄젠트 벡터입니다. 다음 표면의 이미지는 표면의 세 벡터를 모두 보여줍니다:

![OpenGL에서 표면의 노멀 매핑 탄젠트, 바이탄젠트, 법선 벡터](https://claude.ai/img/advanced-lighting/normal_mapping_tbn_vectors.png)

탄젠트와 바이탄젠트 벡터를 계산하는 것은 법선 벡터만큼 직관적이지 않습니다. 이미지에서 우리는 노멀 맵의 탄젠트와 바이탄젠트 벡터의 방향이 표면의 텍스처 좌표를 정의하는 방향과 정렬된다는 것을 볼 수 있습니다. 우리는 이 사실을 사용하여 각 표면에 대한 탄젠트와 바이탄젠트 벡터를 계산할 것입니다. 그것들을 가져오려면 약간의 수학이 필요합니다; 다음 이미지를 살펴보세요:

![TBN 행렬 계산에 필요한 OpenGL 표면의 가장자리](https://claude.ai/img/advanced-lighting/normal_mapping_surface_edges.png)

이미지에서 우리는 삼각형의 가장자리 $E_2$의 텍스처 좌표 차이($\Delta U_2$와 $\Delta V_2$로 표시됨)가 탄젠트 벡터 $T$와 바이탄젠트 벡터 $B$와 같은 방향으로 표현된다는 것을 볼 수 있습니다. 이 때문에 우리는 삼각형의 표시된 두 가장자리 $E_1$과 $E_2$ 모두를 탄젠트 벡터 $T$와 바이탄젠트 벡터 $B$의 선형 결합으로 쓸 수 있습니다:

$$E_1 = \Delta U_1T + \Delta V_1B$$ $$E_2 = \Delta U_2T + \Delta V_2B$$

다음과 같이 쓸 수도 있습니다:

$$(E_{1x}, E_{1y}, E_{1z}) = \Delta U_1(T_x, T_y, T_z) + \Delta V_1(B_x, B_y, B_z)$$ $$(E_{2x}, E_{2y}, E_{2z}) = \Delta U_2(T_x, T_y, T_z) + \Delta V_2(B_x, B_y, B_z)$$

$E$를 두 삼각형 위치 사이의 차이 벡터로, $\Delta U$와 $\Delta V$를 텍스처 좌표 차이로 계산할 수 있습니다. 그러면 두 개의 미지수(탄젠트 $T$와 바이탄젠트 $B$)와 두 개의 방정식이 남습니다. 대수 수업에서 이것이 $T$와 $B$를 풀 수 있게 한다는 것을 기억하실 것입니다.

마지막 방정식을 사용하면 다른 형태로 쓸 수 있습니다: 행렬 곱셈의 형태로:

$$\begin{bmatrix} E_{1x} & E_{1y} & E_{1z} \ E_{2x} & E_{2y} & E_{2z} \end{bmatrix} = \begin{bmatrix} \Delta U_1 & \Delta V_1 \ \Delta U_2 & \Delta V_2 \end{bmatrix} \begin{bmatrix} T_x & T_y & T_z \ B_x & B_y & B_z \end{bmatrix}$$

머릿속으로 행렬 곱셈을 시각화해보고 이것이 실제로 같은 방정식임을 확인하세요. 방정식을 행렬 형태로 다시 쓰는 이점은 $T$와 $B$를 푸는 것이 더 쉽게 이해된다는 것입니다. 방정식의 양변에 $\Delta U \Delta V$ 행렬의 역행렬을 곱하면:

$$\begin{bmatrix} \Delta U_1 & \Delta V_1 \ \Delta U_2 & \Delta V_2 \end{bmatrix}^{-1} \begin{bmatrix} E_{1x} & E_{1y} & E_{1z} \ E_{2x} & E_{2y} & E_{2z} \end{bmatrix} = \begin{bmatrix} T_x & T_y & T_z \ B_x & B_y & B_z \end{bmatrix}$$

이것은 $T$와 $B$를 풀 수 있게 해줍니다. 이것은 델타 텍스처 좌표 행렬의 역행렬을 계산할 것을 요구합니다. 행렬의 역행렬을 계산하는 수학적 세부 사항에는 들어가지 않겠지만, 대략적으로 행렬의 행렬식에 대한 1에 그 수반 행렬을 곱한 것으로 해석됩니다:

$$\begin{bmatrix} T_x & T_y & T_z \ B_x & B_y & B_z \end{bmatrix} = \frac{1}{\Delta U_1 \Delta V_2 - \Delta U_2 \Delta V_1} \begin{bmatrix} \Delta V_2 & -\Delta V_1 \ -\Delta U_2 & \Delta U_1 \end{bmatrix} \begin{bmatrix} E_{1x} & E_{1y} & E_{1z} \ E_{2x} & E_{2y} & E_{2z} \end{bmatrix}$$

이 최종 방정식은 삼각형의 두 가장자리와 텍스처 좌표로부터 탄젠트 벡터 $T$와 바이탄젠트 벡터 $B$를 계산하는 공식을 제공합니다.

이것의 수학을 완전히 이해하지 못하더라도 걱정하지 마세요. 삼각형의 정점과 텍스처 좌표로부터 탄젠트와 바이탄젠트를 계산할 수 있다는 것을 이해하는 한(텍스처 좌표가 탄젠트 벡터와 같은 공간에 있기 때문에) 반은 온 것입니다.

## 탄젠트와 바이탄젠트의 수동 계산

이전 데모에서 우리는 양의 z 방향을 향하는 간단한 노멀 맵 평면을 가지고 있었습니다. 이번에는 탄젠트 공간을 사용하여 노멀 매핑을 구현하여 이 평면을 원하는 대로 방향을 지정할 수 있고 노멀 매핑이 여전히 작동하도록 하고 싶습니다. 이전에 논의한 수학을 사용하여 이 표면의 탄젠트와 바이탄젠트 벡터를 수동으로 계산할 것입니다.

평면이 다음 벡터로 구성된다고 가정합시다(1, 2, 3과 1, 3, 4를 두 삼각형으로):

```cpp
// 위치
glm::vec3 pos1(-1.0,  1.0, 0.0);
glm::vec3 pos2(-1.0, -1.0, 0.0);
glm::vec3 pos3( 1.0, -1.0, 0.0);
glm::vec3 pos4( 1.0,  1.0, 0.0);
// 텍스처 좌표
glm::vec2 uv1(0.0, 1.0);
glm::vec2 uv2(0.0, 0.0);
glm::vec2 uv3(1.0, 0.0);
glm::vec2 uv4(1.0, 1.0);
// 법선 벡터
glm::vec3 nm(0.0, 0.0, 1.0);
```

먼저 첫 번째 삼각형의 가장자리와 델타 UV 좌표를 계산합니다:

```cpp
glm::vec3 edge1 = pos2 - pos1;
glm::vec3 edge2 = pos3 - pos1;
glm::vec2 deltaUV1 = uv2 - uv1;
glm::vec2 deltaUV2 = uv3 - uv1;
```

탄젠트와 바이탄젠트를 계산하는 데 필요한 데이터로, 이전 섹션의 방정식을 따를 수 있습니다:

```cpp
float f = 1.0f / (deltaUV1.x * deltaUV2.y - deltaUV2.x * deltaUV1.y);

tangent1.x = f * (deltaUV2.y * edge1.x - deltaUV1.y * edge2.x);
tangent1.y = f * (deltaUV2.y * edge1.y - deltaUV1.y * edge2.y);
tangent1.z = f * (deltaUV2.y * edge1.z - deltaUV1.y * edge2.z);

bitangent1.x = f * (-deltaUV2.x * edge1.x + deltaUV1.x * edge2.x);
bitangent1.y = f * (-deltaUV2.x * edge1.y + deltaUV1.x * edge2.y);
bitangent1.z = f * (-deltaUV2.x * edge1.z + deltaUV1.x * edge2.z);

[...] // 평면의 두 번째 삼각형에 대한 탄젠트/바이탄젠트 계산을 위한 유사한 절차
```

여기서 우리는 먼저 방정식의 분수 부분을 `f`로 사전 계산한 다음 각 벡터 구성 요소에 대해 `f`를 곱한 해당 행렬 곱셈을 수행합니다. 이 코드를 최종 방정식과 비교하면 직접적인 변환임을 알 수 있습니다. 삼각형은 항상 평평한 형태이기 때문에 삼각형의 각 정점에 대해 동일할 것이므로 삼각형당 단일 탄젠트/바이탄젠트 쌍만 계산하면 됩니다.

결과 탄젠트와 바이탄젠트 벡터는 각각 `(1, 0, 0)`과 `(0, 1, 0)`의 값을 가져야 하며, 법선 `(0, 0, 1)`과 함께 직교 TBN 행렬을 형성합니다. 평면에서 시각화하면 TBN 벡터는 다음과 같이 보입니다:

![OpenGL에서 평면에 시각화된 TBN 벡터 이미지](https://claude.ai/img/advanced-lighting/normal_mapping_tbn_shown.png)

정점별로 정의된 탄젠트와 바이탄젠트 벡터로, 적절한 노멀 매핑을 구현할 수 있습니다.

## 탄젠트 공간 노멀 매핑

노멀 매핑이 작동하도록 하려면 먼저 셰이더에서 TBN 행렬을 생성해야 합니다. 이를 위해 이전에 계산한 탄젠트와 바이탄젠트 벡터를 버텍스 속성으로 버텍스 셰이더에 전달합니다:

```glsl
#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aNormal;
layout (location = 2) in vec2 aTexCoords;
layout (location = 3) in vec3 aTangent;
layout (location = 4) in vec3 aBitangent;
```

그런 다음 버텍스 셰이더의 `main` 함수 내에서 TBN 행렬을 생성합니다:

```glsl
void main()
{
    [...]
    vec3 T = normalize(vec3(model * vec4(aTangent,   0.0)));
    vec3 B = normalize(vec3(model * vec4(aBitangent, 0.0)));
    vec3 N = normalize(vec3(model * vec4(aNormal,    0.0)));
    mat3 TBN = mat3(T, B, N);
}
```

여기서 우리는 먼저 모든 TBN 벡터를 작업하고 싶은 좌표 시스템으로 변환하는데, 이 경우 모델 행렬과 곱하므로 월드 공간입니다. 그런 다음 `mat3` 생성자에 `T`, `B`, `N` 벡터를 직접 제공하여 실제 TBN 행렬을 생성합니다. 이것을 더 간결하게 하고 싶다면 수학적으로 탄젠트와 바이탄젠트 벡터가 법선 벡터에 수직이라면 외적으로 바이탄젠트를 생성할 수 있습니다:

```glsl
vec3 B = cross(N, T);
```

이제 TBN 행렬이 있으므로, 노멀 매핑에 어떻게 사용할까요? TBN 행렬을 노멀 매핑에 사용하는 두 가지 방법이 있으며, 둘 다 시연하겠습니다:

1. 탄젠트에서 월드 공간으로 벡터를 변환하는 TBN 행렬을 가져와서 프래그먼트 셰이더에 전달하고, TBN 행렬을 사용하여 샘플링된 법선을 탄젠트 공간에서 월드 공간으로 변환합니다; 그러면 법선은 다른 조명 변수와 같은 공간에 있습니다.
2. 월드 공간에서 탄젠트 공간으로 벡터를 변환하는 TBN 행렬의 역행렬을 가져와서 이 행렬을 사용하여 법선이 아닌 다른 관련 조명 변수를 탄젠트 공간으로 변환합니다; 그러면 법선은 다시 다른 조명 변수와 같은 공간에 있습니다.

첫 번째 경우를 검토해봅시다. 노멀 맵에서 샘플링하는 법선 벡터는 탄젠트 공간에서 표현되는 반면, 다른 조명 벡터(광선과 뷰 방향)는 월드 공간에서 표현됩니다. TBN 행렬을 프래그먼트 셰이더에 전달함으로써 샘플링된 탄젠트 공간 법선에 이 TBN 행렬을 곱하여 법선 벡터를 다른 조명 벡터와 같은 참조 공간으로 변환할 수 있습니다. 이렇게 하면 모든 조명 계산(특히 내적)이 의미가 있습니다.

TBN 행렬을 프래그먼트 셰이더에 보내는 것은 쉽습니다:

```glsl
out VS_OUT {
    vec3 FragPos;
    vec2 TexCoords;
    mat3 TBN;
} vs_out;

void main()
{
    [...]
    vs_out.TBN = mat3(T, B, N);
}
```

프래그먼트 셰이더에서 유사하게 `mat3`를 입력 변수로 취합니다:

```glsl
in VS_OUT {
    vec3 FragPos;
    vec2 TexCoords;
    mat3 TBN;
} fs_in;
```

이 TBN 행렬로 이제 탄젠트-월드 공간 변환을 포함하도록 노멀 매핑 코드를 업데이트할 수 있습니다:

```glsl
normal = texture(normalMap, fs_in.TexCoords).rgb;
normal = normal * 2.0 - 1.0;
normal = normalize(fs_in.TBN * normal);
```

결과 법선이 이제 월드 공간에 있으므로, 조명 코드가 법선 벡터가 월드 공간에 있다고 가정하기 때문에 다른 프래그먼트 셰이더 코드를 변경할 필요가 없습니다.

두 번째 경우도 검토해봅시다. 여기서 우리는 TBN 행렬의 역행렬을 가져와서 모든 관련 월드 공간 벡터를 샘플링된 법선 벡터가 있는 공간인 탄젠트 공간으로 변환합니다. TBN 행렬의 구성은 동일하게 유지되지만, 프래그먼트 셰이더에 보내기 전에 먼저 행렬을 역행렬로 만듭니다:

```glsl
vs_out.TBN = transpose(mat3(T, B, N));
```

여기서 `transpose` 함수를 사용하여 TBN 행렬을 역행렬로 만듭니다. 이것은 직교 행렬(각 축이 단위 벡터이고 서로 수직인 행렬)의 좋은 속성을 활용하는 작은 트릭입니다. 직교 행렬의 경우 전치 행렬이 역행렬과 같습니다. 이것은 우리가 비용이 많이 드는 역행렬 연산을 절약할 수 있기 때문에 좋은 트릭입니다.

프래그먼트 셰이더 내에서 법선 벡터를 변환하지 않고, 다른 관련 벡터를 탄젠트 공간으로 변환합니다. 즉, `lightDir`와 `viewDir` 벡터를 말이죠. 그렇게 하면 각 벡터가 같은 좌표 공간인 탄젠트 공간에 있게 됩니다.

```glsl
void main()
{
    vec3 normal = texture(normalMap, fs_in.TexCoords).rgb;
    normal = normalize(normal * 2.0 - 1.0);
   
    vec3 lightDir = fs_in.TBN * normalize(lightPos - fs_in.FragPos);
    vec3 viewDir  = fs_in.TBN * normalize(viewPos - fs_in.FragPos);
    [...]
}
```

두 번째 접근법은 더 많은 작업처럼 보이고 프래그먼트 셰이더에서 행렬 곱셈도 필요하므로, 왜 두 번째 접근법을 신경 쓸까요?

월드에서 탄젠트 공간으로 벡터를 변환하는 것은 프래그먼트 셰이더가 아닌 버텍스 셰이더에서 모든 관련 조명 벡터를 탄젠트 공간으로 변환할 수 있다는 추가 이점이 있습니다. `lightPos`와 `viewPos`는 모든 프래그먼트 실행마다 업데이트되지 않고, `fs_in.FragPos`의 경우 버텍스 셰이더에서 탄젠트 공간 위치를 계산하고 프래그먼트 보간이 작동하도록 할 수 있기 때문에 이것은 작동합니다. 프래그먼트 셰이더에서 벡터를 탄젠트 공간으로 변환할 실질적인 필요가 없지만, 샘플링된 법선 벡터가 각 프래그먼트 셰이더 실행에 특정하기 때문에 첫 번째 접근법에서는 필요합니다.

따라서 TBN 행렬의 역행렬을 프래그먼트 셰이더에 보내는 대신, 탄젠트 공간 광원 위치, 뷰 위치, 정점 위치를 프래그먼트 셰이더에 보냅니다. 이렇게 하면 프래그먼트 셰이더에서 행렬 곱셈을 하지 않아도 됩니다. 버텍스 셰이더가 프래그먼트 셰이더보다 훨씬 적게 실행되기 때문에 이것은 좋은 최적화입니다. 이것이 이 접근법이 종종 선호되는 접근법인 이유입니다.

```glsl
out VS_OUT {
    vec3 FragPos;
    vec2 TexCoords;
    vec3 TangentLightPos;
    vec3 TangentViewPos;
    vec3 TangentFragPos;
} vs_out;

uniform vec3 lightPos;
uniform vec3 viewPos;

[...]
  
void main()
{    
    [...]
    mat3 TBN = transpose(mat3(T, B, N));
    vs_out.TangentLightPos = TBN * lightPos;
    vs_out.TangentViewPos  = TBN * viewPos;
    vs_out.TangentFragPos  = TBN * vec3(model * vec4(aPos, 1.0));
}
```

프래그먼트 셰이더에서 이러한 새로운 입력 변수를 사용하여 탄젠트 공간에서 조명을 계산합니다. 법선 벡터가 이미 탄젠트 공간에 있으므로 조명이 의미가 있습니다.

탄젠트 공간에서 노멀 매핑이 적용되면, 이 장의 시작 부분에서 얻은 것과 유사한 결과를 얻어야 합니다. 하지만 이번에는 평면을 원하는 대로 방향을 지정할 수 있고 조명은 여전히 올바를 것입니다:

```cpp
glm::mat4 model = glm::mat4(1.0f);
model = glm::rotate(model, (float)glfwGetTime() * -10.0f, glm::normalize(glm::vec3(1.0, 0.0, 1.0)));
shader.setMat4("model", model);
RenderQuad();
```

실제로 적절한 노멀 매핑처럼 보입니다:

![OpenGL에서 탄젠트 공간 변환을 사용한 올바른 노멀 매핑](https://claude.ai/img/advanced-lighting/normal_mapping_correct_tangent.png)

소스 코드는 [여기](https://claude.ai/code_viewer_gh.php?code=src/5.advanced_lighting/4.normal_mapping/normal_mapping.cpp)에서 찾을 수 있습니다.

## 복잡한 오브젝트

탄젠트와 바이탄젠트 벡터를 수동으로 계산하여 탄젠트 공간 변환과 함께 노멀 매핑을 사용하는 방법을 시연했습니다. 다행히도 이러한 탄젠트와 바이탄젠트 벡터를 수동으로 계산해야 하는 것은 우리가 자주 하는 일이 아닙니다. 대부분의 경우 커스텀 모델 로더에서 한 번 구현하거나, 우리의 경우 Assimp를 사용하여 [모델 로더](https://learnopengl.com/Model-Loading/Assimp)를 사용합니다.

Assimp는 모델을 로드할 때 설정할 수 있는 매우 유용한 구성 비트인 `aiProcess_CalcTangentSpace`를 가지고 있습니다. `aiProcess_CalcTangentSpace` 비트가 Assimp의 `ReadFile` 함수에 제공되면, Assimp는 로드된 각 정점에 대해 부드러운 탄젠트와 바이탄젠트 벡터를 계산하며, 이는 우리가 이전 섹션에서 했던 것과 유사한 방식입니다.

```cpp
const aiScene *scene = importer.ReadFile(
    path, aiProcess_Triangulate | aiProcess_FlipUVs | aiProcess_CalcTangentSpace
);
```

Assimp 내에서 다음과 같이 계산된 탄젠트를 가져올 수 있습니다:

```cpp
vector.x = mesh->mTangents[i].x;
vector.y = mesh->mTangents[i].y;
vector.z = mesh->mTangents[i].z;
vertex.Tangent = vector;
```

그런 다음 텍스처된 모델에서 노멀 맵도 로드하도록 모델 로더를 업데이트해야 합니다. wavefront 오브젝트 형식(.obj)은 Assimp의 규칙과 약간 다르게 노멀 맵을 내보내는데, `aiTextureType_NORMAL`은 노멀 맵을 로드하지 않고 `aiTextureType_HEIGHT`가 로드합니다:

```cpp
vector<Texture> normalMaps = loadMaterialTextures(material, aiTextureType_HEIGHT, "texture_normal");
```

물론 이것은 로드된 모델과 파일 형식의 각 유형에 따라 다릅니다.

업데이트된 모델 로더를 사용하여 스페큘러와 노멀 맵이 있는 모델에서 애플리케이션을 실행하면 다음과 같은 결과를 얻습니다:

![Assimp로 로드된 복잡한 오브젝트에 대한 OpenGL의 노멀 매핑](https://claude.ai/img/advanced-lighting/normal_mapping_complex_compare.png)

보시다시피, 노멀 매핑은 너무 많은 추가 비용 없이 오브젝트의 디테일을 놀라울 정도로 증가시킵니다.

노멀 맵을 사용하는 것은 성능을 향상시키는 좋은 방법이기도 합니다. 노멀 매핑 이전에는 메시에 많은 수의 디테일을 얻기 위해 많은 수의 정점을 사용해야 했습니다. 노멀 매핑으로 훨씬 적은 정점을 사용하여 메시에 같은 수준의 디테일을 얻을 수 있습니다. Paolo Cignoni의 아래 이미지는 두 방법의 좋은 비교를 보여줍니다:

![노멀 매핑이 있는 메시와 없는 메시의 디테일 시각화 비교](https://claude.ai/img/advanced-lighting/normal_mapping_comparison.png)

고정점 메시와 노멀 매핑이 있는 저정점 메시의 디테일은 거의 구별할 수 없습니다. 따라서 노멀 매핑은 멋지게 보일 뿐만 아니라 (너무 많은) 디테일을 잃지 않고 고정점 메시를 저정점 메시로 대체하는 훌륭한 도구입니다.

## 마지막 한 가지

너무 많은 추가 비용 없이 품질을 약간 향상시키는 마지막 트릭이 하나 남았습니다.

탄젠트 벡터가 상당한 양의 정점을 공유하는 더 큰 메시에서 계산될 때, 탄젠트 벡터는 일반적으로 평균화되어 좋고 부드러운 결과를 제공합니다. 이 접근법의 문제는 세 개의 TBN 벡터가 비수직이 될 수 있다는 것이며, 이는 결과 TBN 행렬이 더 이상 직교하지 않게 된다는 것을 의미합니다. 비직교 TBN 행렬로 노멀 매핑은 약간만 벗어날 것이지만, 여전히 개선할 수 있는 것입니다.

**Gram-Schmidt 과정**이라는 수학적 트릭을 사용하면 TBN 벡터를 다시 직교화할 수 있습니다. 버텍스 셰이더 내에서 다음과 같이 TBN 행렬을 생성하기 직전에 Gram-Schmidt 과정을 적용할 수 있습니다:

```glsl
vec3 T = normalize(vec3(model * vec4(aTangent,   0.0)));
vec3 N = normalize(vec3(model * vec4(aNormal,    0.0)));
// N에 대해 T를 재직교화
T = normalize(T - dot(T, N) * N);
// 그런 다음 T와 N의 외적으로 수직 벡터 B를 가져옵니다
vec3 B = cross(N, T);

mat3 TBN = mat3(T, B, N)
```

이것은 비록 약간이지만 일반적으로 약간의 추가 비용으로 노멀 매핑 결과를 개선합니다. 이 과정이 실제로 어떻게 작동하는지에 대한 훌륭한 설명은 추가 리소스의 Normal Mapping Mathematics 비디오 끝 부분을 참조하세요.

## 추가 리소스

- [Tutorial 26: Normal Mapping](http://ogldev.atspace.co.uk/www/tutorial26/tutorial26.html): ogldev의 노멀 매핑 튜토리얼.
- [How Normal Mapping Works](https://www.youtube.com/watch?v=LIOPYmknj5Q): TheBennyBox의 노멀 매핑 작동 방식에 대한 좋은 비디오 튜토리얼.
- [Normal Mapping Mathematics](https://www.youtube.com/watch?v=4FaWLgsctqY): TheBennyBox의 노멀 매핑 뒤의 수학에 관한 유사한 비디오.
- [Tutorial 13: Normal Mapping](http://www.opengl-tutorial.org/intermediate-tutorials/tutorial-13-normal-mapping/): opengl-tutorial.org의 노멀 매핑 튜토리얼

