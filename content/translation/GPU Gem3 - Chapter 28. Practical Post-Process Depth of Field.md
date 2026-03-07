---
title: 'GPU Gem3 - Chapter 28. Practical Post-Process Depth of Field'
tags:
  - graphics
  - post_processing
---

_DOF_

---

[원문](https://developer.nvidia.com/gpugems/gpugems3/part-iv-image-effects/chapter-28-practical-post-process-depth-field)

---

# Chapter 28. Practical Post-Process Depth of Field

# 제28장. 실용적인 포스트 프로세스 피사계 심도

GPU Gems 3는 이제 무료로 온라인에서 이용할 수 있습니다! CD 콘텐츠(데모 및 콘텐츠 포함)는 웹과 다운로드로 제공됩니다. 개발자 뉴스 피드를 구독하여 사이트의 새로운 자료에 대한 알림을 받을 수도 있습니다.

**Earl Hammon, Jr.** Infinity Ward

이 장에서는 특히 1인칭 게임에 적합한 피사계 심도(DoF) 알고리즘을 설명합니다. Infinity Ward에서 우리는 플레이어를 풍부한 영화적 경험에 몰입시키는 것을 자랑스럽게 여깁니다. 이 목표에 부합하게, 우리는 Call of Duty 4: Modern Warfare를 위해 전체 시스템 성능이나 엔진 아키텍처에 최소한의 영향을 미치면서 전경과 배경 모두에서 피사계 심도의 주요 정성적 특징을 제공하는 기술을 개발했습니다. 우리의 기술은 Shader Model 2.0 하드웨어가 필요합니다.

## 28.1 이전 연구 (Previous Work)

Potmesil과 Chakravarty 1981로 거슬러 올라가는 컴퓨터 생성 이미지에 피사계 심도를 추가하기 위한 풍부한 연구 자료가 존재합니다. Demers (2004)는 원래 GPU Gems 책에서 피사계 심도 기술을 다음 다섯 가지 클래스로 나눕니다:

- **Ray-tracing 기술**, 렌즈의 전체 영역에서 광선을 보냅니다
- **Accumulation-buffer 기술**, 여러 핀홀 카메라의 이미지를 혼합합니다
- **Compositing 기술**, 다른 초점 레벨을 가진 여러 레이어를 병합합니다
- **Forward-mapped z-buffer 기술**, 픽셀의 색상을 이웃에 분산시킵니다
- **Reverse-mapped z-buffer 기술**, 이웃 픽셀에서 색상 샘플을 수집합니다

Ray tracing, accumulation buffer, 그리고 compositing은 "composition" 기술로 간주될 수 있습니다. Demers와 마찬가지로, 우리는 z-buffer 기술(forward mapped 또는 reverse mapped)을 선호합니다. 이미지 기반 알고리즘으로서, 이들은 그래픽 하드웨어에 특히 적합합니다. 더욱이, z-buffer 정보는 소프트 파티클과 같은 다른 렌더링 효과에서도 유용하며, 깊이 이미지 생성 비용을 상각하기 때문입니다. 반면, composition 기술은 기존 그래픽 엔진에 쉽게 추가할 수 없기 때문에 제한적입니다.

Z-buffer 기술은 종종 단일 이미지 대신 독립적인 레이어 세트에서 작동하도록 확장됩니다. 이 프로세스는 잘못된 bleeding으로 인한 아티팩트를 줄이고 반투명하게 흐려진 근처 객체 뒤에 적절한 가시성을 제공할 수 있습니다.

Mulder와 van Liere 2000은 원본 이미지를 초점 평면 앞의 픽셀과 뒤의 픽셀로 분할하는 빠른 DoF 기술을 포함합니다. 그들은 두 세트 모두에서 흐릿한 이미지 세트를 구축하여 매번 해상도를 절반으로 줄입니다. 마지막으로, 깊이 테스트를 활성화한 상태에서 카메라에서 적절한 거리에 텍스처가 있는 평면을 그려서 이러한 흐릿한 레벨 각각을 원래 장면과 결합합니다. 우리의 기술도 흐릿한 이미지를 프레임 버퍼와 혼합하지만, 더 적은 패스로 생성하고 단일 전체 화면 컬러 쿼드로 최종 이미지에 적용합니다. 우리는 깊이를 넘어서 흐림으로 인한 더 많은 아티팩트를 받아들임으로써 더 높은 효율성을 달성합니다.

Demers (2004)는 각 픽셀의 circle of confusion (CoC)을 사용하여 원본 이미지의 여러 다운샘플 버전 간에 혼합하는 gathering z-buffer 기술을 설명합니다. 우리의 기술은 이것과 가장 가깝게 일치하지만, 우리는 픽셀의 CoC를 계산할 때 이웃도 고려하므로 우리의 기술은 전경 객체도 흐리게 합니다.

Scheuermann (2004)은 픽셀의 자체 CoC를 기반으로 픽셀의 이웃을 샘플링하기 위해 Poisson 필터를 사용하는 또 다른 gathering z-buffer 기술을 설명합니다. 그는 또한 이웃 픽셀의 깊이를 사용하여 전경 객체가 초점이 맞지 않는 배경 객체에 bleeding되는 것을 방지합니다. 이 기술은 먼 객체를 흐리게 하는 데 잘 작동하지만 전경을 흐리게 하는 데는 잘 확장되지 않습니다.

Kivánek 등 (2003)은 점의 CoC를 기반으로 스케일링되는 point sprite로 구성된 객체를 사용하는 scattering z-buffer 기술을 제시합니다. 그들은 더 초점이 맞지 않는 객체에 대해 더 낮은 디테일 레벨을 사용하여 성능을 향상시킵니다. 이것은 point-sprite 모델에 좋은 기술입니다. 이것은 화면의 각 픽셀을 point sprite로 취급하여 포스트 프로세스로 작동하도록 확장될 수 있지만, 그렇게 하는 것은 계산적으로 비실용적입니다.

Kass 등 (2006)은 circle of confusion의 크기가 픽셀의 "열"에 해당하는 열 확산으로 모델링하여 DoF에서 볼 수 있는 흐림을 달성합니다. 그들은 카메라 조리개에 비해 작았기 때문에 투명해진 불투명한 전경 객체 뒤에 객체를 그리기 위해 장면을 레이어로 더 나눕니다. 그들의 기술은 사전 렌더링된 장면에서 상호작용 성능으로 높은 품질을 달성하여 아티스트가 나중에 오프라인 렌더에서 사용되는 DoF 매개변수를 조작할 수 있게 합니다. 그러나 이 기술은 매 프레임마다 렌더링해야 하는 동적 장면에는 너무 계산 집약적입니다.

## 28.2 이론 (Theory)

우리의 기술에 대한 이론적 기초로서, 우리는 들어오는 빛을 이미징 평면에 초점을 맞추는 가상 렌즈에서 시작합니다. 이 렌즈는 초점 거리와 조리개로 특징지어집니다. 초점 거리는 평행 광선이 단일 점에 매핑되기 위해 이미징 평면이 렌즈에서 떨어져 있어야 하는 거리입니다. 조리개는 단순히 빛을 받는 렌즈의 직경입니다. 얇은 렌즈 방정식은 렌즈에서 객체의 거리 u를 초점이 맞는 렌즈에서의 거리 v 및 렌즈의 초점 거리 f와 연관시킵니다:

**1/u + 1/v = 1/f**

단순한 렌즈의 기하학은 그림 28-1에 나와 있습니다. 렌즈의 조리개 반경은 d입니다. 점 u_o는 v_o에 있는 이미징 평면에 초점이 맞습니다. u_n 또는 u_f의 점은 이미징 평면이 v_f 또는 v_n에 있으면 초점이 맞지만, 이미징 평면이 v_o에 있을 때 둘 다 직경 c를 가진 원에 매핑됩니다. 이 원은 circle of confusion으로 알려져 있습니다. 카메라의 피사계 심도는 CoC가 충분히 작은 값의 범위입니다.

**그림 28-1** 얇은 렌즈에 대한 Circle of Confusion

유사 삼각형을 사용하여, 우리는 다음을 발견합니다:

**c / d = |v - v_p| / v**

따라서 v_p에 초점이 맞는 공간의 임의의 점 p에 대해, 우리는 다음과 같이 circle of confusion을 지정할 수 있습니다:

**c = d * |v - v_p| / v**

우리는 얇은 렌즈 근사에 대해 v를 풀고 이를 이 방정식에 대입하여 카메라의 물리적 특성의 함수로 공간의 임의의 점에 대한 circle of confusion의 직경을 찾을 수 있습니다. 방정식 1과 같이:

**방정식 1:**

**c = (d * f * |u - u_o|) / (u * (u_o - f))**

우리는 주로 제한된 피사계 심도의 감각을 전달하기 위해 이 방정식의 정성적 특성에 관심이 있습니다. 구체적으로, 우리는 다음을 주목합니다:

- "핀홀" 카메라 모델은 d를 0으로 설정합니다. 이 경우, c는 항상 0이므로 공간의 모든 점이 항상 초점이 맞습니다. d의 더 큰 값은 이미지의 일부를 초점이 맞지 않게 만듭니다. 인간의 눈을 포함한 모든 실제 렌즈는 d가 0보다 큽니다.
- 초점보다 멀리 있는 점에 대한 circle of confusion의 직경에는 상한이 있습니다.
- 초점보다 가까이 있는 점에 대한 circle of confusion에는 상한이 없습니다.
- Circle of confusion은 배경보다 전경에서 훨씬 더 빠르게 증가합니다.

분명히, 카메라 근처의 객체를 흐리게 하는 것은 설득력 있는 피사계 심도 알고리즘에 중요합니다. 우리의 알고리즘은 근처 객체를 설득력 있게 흐리게 하기 위한 다양한 시도를 통해 발전했습니다.

## 28.3 실패한 시도 (Failed Attempts)

### 28.3.1 Stochastic Approach (확률적 접근)

우리는 Scheuermann 2004에서 설명된 기술에서 시작했습니다. 우리는 각 픽셀의 circle of confusion을 독립적으로 계산하고 이를 사용하여 원본 이미지의 샘플의 원형 Poisson 분포를 스케일링했습니다. Scheuermann처럼, 우리는 또한 각 샘플 포인트의 깊이를 읽어 카메라에 너무 가까운 것을 거부했습니다.

이것은 초점 평면 너머의 객체에 대해 매우 설득력 있는 블러를 제공합니다. 불행히도, 초점 평면 앞의 객체는 여전히 날카로운 실루엣을 가지고 있습니다. 근처 객체는 초점이 맞지 않는 것처럼 보이지 않고, 단지 낮은 품질의 텍스처를 가진 것처럼 보입니다. 이 나쁜 텍스처는 플레이어의 경험을 해치므로, 전경을 흐리게 하기 위해 이 기술을 사용하는 것보다 먼 객체를 흐리게 하는 것으로 제한하는 것이 더 나을 것입니다.

전경 객체를 흐리게 하는 이 기술은 그림 28-2의 오른쪽 상단 이미지에 표현되어 있습니다. 캐릭터의 실루엣은 참조 이미지에서 변경되지 않았습니다. 이 스크린샷은 픽셀당 66개의 텍스처 룩업에 대해 33개의 샘플 위치를 사용했지만, 특히 턱 스트랩, 칼라 및 눈 주위에 링잉 아티팩트를 여전히 겪습니다. 이것을 오른쪽 하단 이미지의 부드러운 실루엣과 매끄러운 블러와 대조하십시오.

**그림 28-2** DoF에 대한 다양한 기술로 렌더링된 캐릭터

### 28.3.2 Scatter-Based Approach (분산 기반 접근)

이 시점에서 우리는 배경을 흐리게 하는 문제가 해결되었다고 간주했으므로, 흐릿한 전경 객체를 실루엣을 넘어 bleeding하는 데 노력을 집중했습니다. 우리의 첫 번째 알고리즘은 이웃 픽셀로부터 gather를 수행했으며, 본질적으로 각 이웃이 현재 픽셀과 동일한 CoC를 가졌다고 가정했습니다. 논리적으로, 우리는 각 픽셀이 자신의 circle of confusion을 기반으로 이웃에 자신을 smear하는 것을 선호할 것입니다.

이 선택적 크기의 smearing은 scattering 작업이며, 이는 현대 GPU에 잘 매핑되지 않습니다. 우리는 이 scattering 작업을 각 픽셀의 이웃을 검색하여 그 위에 scatter된 픽셀을 찾음으로써 gather 작업으로 반전시켰습니다. 우리는 다시 Poisson 분포로 샘플링했지만, 중심 픽셀에 bleeding되는 이웃 픽셀을 검색하고 있었기 때문에 항상 최대 circle of confusion을 사용해야 했습니다.

우리는 각 이웃 샘플의 CoC를 찾고 이 픽셀과 겹치는 샘플만의 가중 합을 계산했습니다. 각 샘플의 가중치는 그 영역에 반비례했습니다. 우리는 사용된 모든 가중치의 합으로 나누어 최종 색상 값을 정규화했습니다.

불행히도, 이 기술은 계산적으로나 시각적으로 부적절한 것으로 판명되었습니다. 우리는 가능한 가장 큰 circle of confusion에서 약 1/4 미만의 픽셀을 사용하면 못생긴 링잉 아티팩트가 발생한다는 것을 알았습니다. 이것은 단 5픽셀 떨어진 최대 circle of confusion에 대해 각각 2개의 텍스처 읽기가 있는 24개의 샘플 포인트를 계산합니다(중심점을 세면 직경은 11픽셀이 됩니다). 이 비용은 알려진 이웃에 대한 정보를 사용하여 샘플을 지능적으로 컬링함으로써 완화될 수 있습니다.

그러나, 우리는 이 접근 방식을 포기했습니다. 왜냐하면 근처의 초점이 맞지 않는 픽셀과 더 먼 초점이 맞는 픽셀 사이의 불쾌한 불연속성을 유지했기 때문입니다. 왜 이것이 발생했는지 이해하려면, 큰 CoC를 가진 빨간색 소스 픽셀과 초점이 맞는 파란색 소스 픽셀 사이의 가장자리를 고려하십시오. 타겟 이미지에서, 빨간색 픽셀은 파란색 픽셀에 영향을 미쳤지만 그 반대는 아닙니다. 초점이 맞지 않는 빨간색 객체는 우리가 예상하는 연속적인 빨강-보라-파랑 전환 대신 파랑으로 흐려지는 보라색 배경에 대해 날카로운 실루엣을 가질 것입니다.

이 방법의 두 가지 더 많은 문제가 못생긴 동작으로 이어집니다. 첫째, 각 픽셀의 가중치는 원의 둘레에서 부드럽게 0으로 가야 합니다; 이것이 없으면, 출력 이미지는 블러 반경이 변경되는 곳에서 항상 불연속성을 가질 것입니다. 둘째, 픽셀은 가중치의 단순한 정규화된 합을 사용하여 결합될 수 없습니다. 원하는 동작을 얻으려면, 기여하는 픽셀을 뒤에서 앞으로 반복해야 하며, 여기서 이 반복의 출력 색상은 현재 소스 픽셀의 기여 가중치를 기반으로 이전 반복의 출력 색상에서 현재 소스 픽셀의 색상으로의 lerp입니다. 이 두 가지 변경은 이 기술을 픽셀의 CoC와 같은 직경을 가진 각 픽셀에 대해 정렬된 깊이 sprite를 렌더링하는 것과 동등하게 만들며, 본질적으로 Kivánek 등 2003의 포스트 프로세스 버전입니다. 불행히도, 그들은 또한 픽셀 셰이더를 훨씬 더 엄청나게 비싸게 만듭니다. 이러한 수정을 하더라도, 셰이더는 투명하게 흐려진 전경 객체 뒤의 장면을 적절하게 그릴 수 없었습니다.

그림 28-2의 왼쪽 하단 이미지는 12픽셀 반경으로 64개의 샘플 포인트를 사용하여 이 기술로 생성되었습니다. 추가 샘플은 확률적 접근보다 캐릭터 내부에서 더 나은 블러를 제공합니다. 그러나 64개의 샘플 포인트는 이 블러 반경에 여전히 너무 적어서, 안테나, 목 및 헬멧에서 볼 수 있는 링잉 아티팩트로 이어집니다. 실루엣은 여전히 배경에 대해 가혹한 가장자리를 형성합니다; 더 많은 샘플이 이것을 제거하지 못할 것입니다.

## 28.4 성공적인 접근 (Successful Approach)

Infinity Ward에서 우리는 정확한 시뮬레이션보다 품질 있는 사용자 경험을 우선시합니다. 그래서 우리는 근처 객체에 대해 연속적인 방식으로 circle of confusion을 적용할 때 물리 기반 접근을 포기했습니다. 대신, 우리는 무차별 대입을 사용하여 초점이 맞는 객체와 초점이 맞지 않는 전경 사이의 모든 불연속성을 제거하여 그것들을 존재에서 흐리게 했습니다. 그림 28-2의 오른쪽 하단 이미지는 이 기술을 이전 접근과 비교합니다. 블러 접근은 분명히 최고의 이미지 품질을 가지고 있지만, 또한 가장 빠릅니다.

우리는 각 전경 픽셀에 대한 circle of confusion의 반경을 렌더 타겟으로 계산하는 전체 화면 패스를 적용합니다. 초점이 맞거나 배경에 있는 픽셀은 0의 CoC를 사용합니다. 그런 다음 우리는 모든 가장자리를 제거하기 위해 CoC 이미지를 흐리게 합니다. 우리는 계산적으로 효율적이고 만족스러운 결과를 제공하기 때문에 Gaussian blur를 사용합니다. 우리는 또한 최적화로 각 축을 따라 1/4 해상도로 CoC 이미지를 다운샘플링하여 Gaussian blur가 프레임의 총 픽셀의 1/16만 영향을 미치도록 합니다.

이것만으로는 초점이 맞지 않는 객체의 실루엣에 대한 원하는 결과를 제공하지 않습니다. 전경 객체가 최대로 흐려졌지만 그 뒤의 객체가 전혀 흐려지지 않았다면, 두 객체는 경계에서 약 50% 흐려질 것입니다. 전경 객체는 이 가장자리를 따라 100% 흐려져야 합니다. 이것은 이전 불연속성만큼 나쁘지 않습니다; 그러나 전경 객체의 가장자리의 흐림이 그 뒤의 객체에 따라 달라질 때 여전히 이상해 보입니다.

이를 수정하기 위해, 우리는 특정 픽셀—다른 크기를 가진 CoC 사이의 가장자리 양쪽에 위치한 픽셀—의 크기를 항상 두 직경 중 더 큰 것을 사용하도록 조정했습니다. 그러나 픽셀은 많은 이웃을 가지고 있으며, 우리는 모든 이웃 픽셀의 검색을 피하고 싶습니다. 대신, 우리는 각 픽셀의 CoC만 계산한 다음 흐린 CoC 이미지를 사용하여 이웃 픽셀의 CoC를 추정합니다.

직경 D_0와 D_1을 가진 균일하지만 구별되는 circle of confusion을 가진 두 객체 사이의 가장자리를 고려하십시오. 분명히, 이 경우 흐린 직경 D_B는 다음과 같이 주어집니다:

**D_B = (D_0 + D_1) / 2**

이 방정식은 또한 직경의 그래디언트가 가장자리의 양쪽에서 동일하고 일부 다른 우연한 경우에 흐린 직경을 정확하게 제공합니다. 우리는 두 개의 텍스처 룩업에서 현재 픽셀의 원래 직경 D_0와 흐린 직경 D_B를 얻을 수 있습니다. 이것들로부터, 우리는 이전 방정식을 풀어 D_1을 추정합니다:

**D_1 = 2 * D_B - D_0**

따라서, 우리는 방정식으로 circle of confusion에 대한 새로운 직경 D를 정의합니다:

**D = max(D_0, 2*D_B - D_0) = 2 * max(D_0, D_B) - D_0**

D_1을 더 큰 circle of confusion이라고 합시다. 이 방정식은 두 영역 사이의 경계에서 D_1의 직경에서 영역 0 내부의 블러 반경의 한계에서 D_0로 부드럽게 전환될 것입니다. 이것이 바로 우리가 원하는 것입니다.

최대 함수는 그 입력이 연속적일 때 연속적입니다. D_0 입력은 실제로 연속적이지 않습니다. 왜냐하면 그것은 이 픽셀의 circle of confusion에 대한 흐리지 않은 직경이기 때문입니다. 이 함수는 특정 직선 가장자리를 따라 연속적이도록 선택되었습니다. 대부분의 직선 가장자리 경계는 블러 반경 내에서 이러한 가정과 상당히 잘 일치합니다. 그러나 특히 90도 모서리에서 일부 불쾌한 불연속성이 있으므로, 우리는 이 문제를 해결하기 위해 마지막으로 작은 블러를 하나 더 적용합니다.

그림 28-3과 28-4는 샘플 이미지에 적용된 이 프로세스를 보여줍니다. 각 행은 특정 샘플 이미지입니다. 첫 번째 열은 처리되지 않은 이미지이고, 두 번째 열은 최종 블러 없이 필터가 적용된 이미지입니다. 세 번째 열은 최종 흐린 결과입니다. 입력 이미지의 순수한 흰색은 최대 circle of confusion을 나타냅니다; 검은색 픽셀은 초점이 맞습니다.

**그림 28-3** 일부 테스트 이미지에 적용된 전경 Circle of Confusion 반경 계산

**그림 28-4** 그림 28-3의 "W"의 왼쪽 상단 모서리 확대

첫 번째 이미지는 단순한 흑백 장면입니다. 시각적으로, 이 글자들은 카메라에 매우 가까운 공간에 떠 있습니다. 필터는 전반적으로 잘 작동하지만, 특히 대문자 "I"에서 글자의 모서리에 여전히 일부 날카로운 가장자리가 있습니다. 이미지를 흐리게 하면 단단한 가장자리가 제거됩니다. 여전히 이상적인 것보다 더 가파른 그래디언트를 남기지만, 우리의 목적에는 충분히 좋습니다.

두 번째 행은 필터를 적용하기 전에 첫 번째 행의 샘플 이미지에 작은 Gaussian blur를 적용합니다. 이것은 glancing angle에서 객체를 보는 것에 해당합니다. 이것은 필터링된 후 원본 이미지 주위에 명확한 윤곽을 초래합니다. 최종 블러는 이 아티팩트를 크게 약화시키지만, 완전히 고치지는 않습니다.

마지막 행은 원본 이미지에 그래디언트를 적용합니다. 이것은 점진적으로 거리로 후퇴하는 객체의 전형적인 경우에 해당합니다. Circle of confusion의 반경은 "골짜기"에서 과대평가되고 "봉우리"에서 과소평가되지만, 연속적이며 두 번째 행의 정말 불쾌한 아티팩트는 없습니다. 다시, 최종 블러는 이 아티팩트를 약화시킵니다. 텍스트 내의 그래디언트가 보존되었음을 주목하십시오.

## 28.5 구현 세부사항 (Implementation Details)

우리의 완성된 알고리즘은 네 단계로 구성됩니다:

1. 각 전경 픽셀에 대한 circle of confusion의 반경을 렌더 타겟으로 계산하고, 동시에 크고 중간 크기의 Gaussian blur를 계산합니다 (Listing 28-1).
2. 큰 Gaussian blur의 추가 패스를 수행합니다.
3. Blur된 circle of confusion 반경을 사용하여 각 픽셀에 대해 사용할 적절한 circle of confusion 반경을 계산합니다 (Listing 28-2).
4. 이 반경의 작은 3x3 blur를 수행하여 이전 단계에서 발생할 수 있는 불연속성을 제거합니다 (Listing 28-3).
5. 가변 폭 블러를 장면에 적용합니다 (Listing 28-4).

### 28.5.1 Depth Pre-Pass

우리의 알고리즘은 DirectX 9 하드웨어를 사용하여 구현되며, 이는 깊이 버퍼를 텍스처로 읽는 것을 허용하지 않습니다. 우리는 깊이 pre-pass 동안 32비트 부동 소수점 컬러 버퍼를 바인딩하여 이 제한을 우회합니다. 우리는 전체 32비트 정밀도가 필요하지 않지만, 모든 타겟 하드웨어에서 최소 공통 분모이기 때문에 그 형식을 선택했습니다.

깊이 pre-pass 동안의 픽셀 셰이더는 단순히 vertex shader에서 렌더 타겟으로 world-space 거리를 전달합니다. 픽셀 셰이더에서, 우리는 HLSL clip() 내장 함수를 사용하여 1비트 알파 텍스처에 대한 투명한 픽셀을 제거합니다.

우리의 기술을 "기존 엔진에 쉽게 연결할 수 있는 순수한 포스트 프로세스"라고 부르면서, 우리는 엔진이 이미 이 정보를 생성한다고 가정합니다. 우리의 성능 영향 분석도 이 정보가 이미 사용 가능하다고 가정합니다. 이 가정이 유효하지 않으면 우리의 기술은 렌더링 엔진에 포스트 프로세싱 수정을 적용하는 것 이상을 요구합니다.

### 28.5.2 Variable-Width Blur

우리는 circle of confusion을 장면에 적용하기 위해 빠른 가변 폭 블러가 필요합니다. 우리는 Scheuermann 2004를 기반으로 한 원래 확률적 접근에서처럼 Poisson disk를 사용할 수 있습니다. 그러나, 우리는 다르게 접근하여 블러를 생성합니다. 우리는 각 픽셀이 CoC 직경을 기반으로 색상을 제공하는 함수를 가지고 있다고 생각합니다. 그런 다음 세 가지 다른 블러 반경과 원래 흐리지 않은 샘플 사이의 조각별 선형 곡선을 사용하여 이 함수를 근사합니다.

두 개의 더 큰 블러 반경은 다운샘플된 CoC가 알파 채널에서 계산되는 동시에 RGB 채널에서 계산됩니다. 가장 작은 블러 반경은 그림 28-5의 패턴을 사용하여 5x5 그리드에서 17개의 픽셀을 평균화하기 위해 5개의 텍스처 룩업을 사용하여 해결됩니다.

**그림 28-5** Small Blur를 위한 샘플 위치

이 패턴의 중심 샘플은 흐리지 않은 원래 픽셀 색상에 대한 텍스처 룩업을 재사용합니다. 이 작은 블러는 실제 블러 색상을 밀접하게 근사하는 데 중요합니다. 이것이 없으면, 이미지가 연속적으로 흐려지는 것처럼 보이지 않고, 대신 흐린 버전과 크로스페이드되는 것처럼 보입니다. 우리는 또한 단순한 선형 보간이 고차 다항식 스플라인보다 더 나은 결과를 제공한다는 것을 발견했습니다. 왜냐하면 스플라인은 일부 픽셀에 대한 색상을 외삽하는 경향이 있기 때문입니다.

### 28.5.3 Circle of Confusion for Scene

우리는 깊이 텍스처에서 카메라까지 각 픽셀의 거리를 받습니다. 우리는 방정식 1에서 circle of confusion의 반경에 대한 정확한 모델이 역수와 곱셈-덧셈 명령만 사용하여 이것으로부터 계산될 수 있음을 알 수 있으며, 엔진은 적절한 스케일 및 바이어스 상수를 제공합니다.

그러나, 우리는 다시 물리적 그럴듯함을 포기하고 예술적 제어를 선호하기 위해 컴퓨터 시뮬레이션의 자유를 활용합니다. 예술적으로, 우리는 일부 깊이 범위가 초점이 맞기를 원하며, 그 앞뒤에 특정 양의 블러를 원합니다. 이것을 물리적 카메라 치수로 변환하는 방법은 불분명합니다. 이를 편집하는 가장 직관적인 방법은 그림 28-6과 같이 조각별 선형 곡선을 사용하는 것입니다. 아티스트는 세 영역 각각에 대한 근거리 및 원거리 블러 반경과 시작 및 끝 거리를 지정합니다. 우리는 퇴화된 값을 가진 영역에 대해 블러링을 비활성화하므로 아티스트는 원하면 전경이나 배경만 흐리게 할 수 있습니다.

**그림 28-6** Circle of Confusion의 그래프

실제로, 우리는 플레이어가 관심을 가질 가능성이 있는 모든 것을 포함하는 world-near-end 거리와 world-far-start 거리를 선택합니다. 그런 다음 world-near-end 거리를 기반으로 world-near-start 거리를 설정합니다. 마찬가지로, world-far-start 거리를 기반으로 world far-end 거리를 설정합니다.

### 28.5.4 Circle of Confusion for Weapon

Infinity Ward는 1인칭 슈팅 게임을 개발합니다. 플레이어의 무기(view model)는 항상 보기에 있고 플레이어가 환경과 상호 작용하는 주요 방법이기 때문에 이러한 게임에서 매우 중요합니다. view model에서 좋게 보였던 DoF 설정은 환경에 효과가 없는 것처럼 보였고, 근처 환경에서 좋게 보였던 DoF 설정은 플레이어의 무기를 과도하게 흐리게 했습니다.

우리의 해결책은 세계와 플레이어의 view model에 대한 블러에 대한 별도의 설정을 제공하는 것이었습니다. 이것은 물리적으로 의미가 없지만, 플레이어에게 더 나은 경험을 제공합니다—아마도 플레이어가 무기의 중요한 부분이나 환경의 액션에 집중하고 있는지에 따라 DoF의 효과를 적절하게 전달하기 때문입니다. 각 무기는 슈터가 무기를 조준할 때와 엉덩이에서 들고 있을 때 사용되는 별도의 값을 가지고 자체 근거리 및 원거리 거리를 구성합니다.

이 기술이 작동하려면, 각 픽셀이 view model에 속하는지 세계에 속하는지 알아야 합니다. 우리의 깊이 정보는 32비트 부동 소수점 렌더 타겟에 저장됩니다. 음수 깊이를 사용하는 것이 이 정보 비트를 얻는 가장 편리한 방법으로 판명되었습니다. 일반적인 룩업은 자유로운 절대값 수정자만 필요합니다. 이것은 또한 근거리 circle of confusion을 선택하기 위한 효율적인 구현으로 이어집니다. 우리는 단일 mad_sat 명령을 사용하여 4개의 픽셀에 대한 근거리 CoC를 동시에 계산할 수 있습니다. 우리는 이런 식으로 view model과 세계 모두에 대한 근거리 CoC를 계산한 다음 단일 min 명령으로 모든 4개의 픽셀에 대한 적절한 CoC를 선택합니다.

### 28.5.5 Overall Algorithm

Listing 28-1의 우리 알고리즘의 대부분의 패스는 근거리 circle of confusion을 생성하여 연속적이고 전경 객체에 대한 부드러운 가장자리를 제공하는 데 사용됩니다. 우리는 또한 큰 Gaussian blur 반경을 원하므로, GPU 계산을 공유하여 장면의 흐린 버전과 근거리 circle of confusion을 동시에 계산합니다.

우리는 정규화된 480p 해상도에서 픽셀 단위로 큰 블러 반경을 지정하여 실제 화면 해상도와 독립적이도록 합니다. 그러나 두 개의 작은 블러는 실제 화면 해상도를 기반으로 합니다. 우리는 실험적으로 17-tap 작은 블러가 네이티브 해상도에서 1.4픽셀 Gaussian blur에 해당하고, 중간 블러가 네이티브 해상도에서 3.6픽셀 Gaussian blur에 해당한다고 결정했습니다.

**Listing 28-1** DofDownsample()

```hlsl
// 이것들은 게임 엔진에 의해 설정됩니다.
// 렌더 타겟 크기는 장면 렌더링 크기의 1/4입니다.
sampler colorSampler;
sampler depthSampler;
const float2 dofEqWorld;
const float2 dofEqWeapon;
const float2 dofRowDelta;
// float2( 0, 0.25 / renderTargetHeight )
const float2 invRenderTargetSize;
const float4x4 worldViewProj;

struct PixelInput
{
    float4 position : POSITION;
    float2 tcColor0 : TEXCOORD0;
    float2 tcColor1 : TEXCOORD1;
    float2 tcDepth0 : TEXCOORD2;
    float2 tcDepth1 : TEXCOORD3;
    float2 tcDepth2 : TEXCOORD4;
    float2 tcDepth3 : TEXCOORD5;
};

PixelInput DofDownVS(float4 pos : POSITION, float2 tc : TEXCOORD0)
{
    PixelInput pixel;
    pixel.position = mul(pos, worldViewProj);
    pixel.tcColor0 = tc + float2(-1.0, -1.0) * invRenderTargetSize;
    pixel.tcColor1 = tc + float2(+1.0, -1.0) * invRenderTargetSize;
    pixel.tcDepth0 = tc + float2(-1.5, -1.5) * invRenderTargetSize;
    pixel.tcDepth1 = tc + float2(-0.5, -1.5) * invRenderTargetSize;
    pixel.tcDepth2 = tc + float2(+0.5, -1.5) * invRenderTargetSize;
    pixel.tcDepth3 = tc + float2(+1.5, -1.5) * invRenderTargetSize;
    return pixel;
}

half4 DofDownPS(const PixelInput pixel) : COLOR
{
    half3 color;
    half maxCoc;
    float4 depth;
    half4 viewCoc;
    half4 sceneCoc;
    half4 curCoc;
    half4 coc;
    float2 rowOfs[4];

    // "rowOfs"는 PS2.0이 swizzling을 에뮬레이트하는 데 사용하는 이동 수를 줄입니다.
    rowOfs[0] = 0;
    rowOfs[1] = dofRowDelta.xy;
    rowOfs[2] = dofRowDelta.xy * 2;
    rowOfs[3] = dofRowDelta.xy * 3;

    // bilinear filtering을 사용하여 무료로 4개의 색상 샘플을 평균화합니다.
    color = 0;
    color += tex2D(colorSampler, pixel.tcColor0.xy + rowOfs[0]).rgb;
    color += tex2D(colorSampler, pixel.tcColor1.xy + rowOfs[0]).rgb;
    color += tex2D(colorSampler, pixel.tcColor0.xy + rowOfs[2]).rgb;
    color += tex2D(colorSampler, pixel.tcColor1.xy + rowOfs[2]).rgb;
    color /= 4;

    // 벡터 하드웨어를 효율적으로 사용하기 위해 한 번에 4개의 샘플을 처리합니다.
    // 깊이가 음수이면 CoC는 1이 되므로 "sceneCoc"와 "viewCoc" 중에서
    // 선택하기 위해 "min"을 사용합니다.
    depth[0] = tex2D(depthSampler, pixel.tcDepth0.xy + rowOfs[0]).r;
    depth[1] = tex2D(depthSampler, pixel.tcDepth1.xy + rowOfs[0]).r;
    depth[2] = tex2D(depthSampler, pixel.tcDepth2.xy + rowOfs[0]).r;
    depth[3] = tex2D(depthSampler, pixel.tcDepth3.xy + rowOfs[0]).r;
    viewCoc = saturate(dofEqWeapon.x * -depth + dofEqWeapon.y);
    sceneCoc = saturate(dofEqWorld.x * depth + dofEqWorld.y);
    curCoc = min(viewCoc, sceneCoc);
    coc = curCoc;

    depth[0] = tex2D(depthSampler, pixel.tcDepth0.xy + rowOfs[1]).r;
    depth[1] = tex2D(depthSampler, pixel.tcDepth1.xy + rowOfs[1]).r;
    depth[2] = tex2D(depthSampler, pixel.tcDepth2.xy + rowOfs[1]).r;
    depth[3] = tex2D(depthSampler, pixel.tcDepth3.xy + rowOfs[1]).r;
    viewCoc = saturate(dofEqWeapon.x * -depth + dofEqWeapon.y);
    sceneCoc = saturate(dofEqWorld.x * depth + dofEqWorld.y);
    curCoc = min(viewCoc, sceneCoc);
    coc = max(coc, curCoc);

    depth[0] = tex2D(depthSampler, pixel.tcDepth0.xy + rowOfs[2]).r;
    depth[1] = tex2D(depthSampler, pixel.tcDepth1.xy + rowOfs[2]).r;
    depth[2] = tex2D(depthSampler, pixel.tcDepth2.xy + rowOfs[2]).r;
    depth[3] = tex2D(depthSampler, pixel.tcDepth3.xy + rowOfs[2]).r;
    viewCoc = saturate(dofEqWeapon.x * -depth + dofEqWeapon.y);
    sceneCoc = saturate(dofEqWorld.x * depth + dofEqWorld.y);
    curCoc = min(viewCoc, sceneCoc);
    coc = max(coc, curCoc);

    depth[0] = tex2D(depthSampler, pixel.tcDepth0.xy + rowOfs[3]).r;
    depth[1] = tex2D(depthSampler, pixel.tcDepth1.xy + rowOfs[3]).r;
    depth[2] = tex2D(depthSampler, pixel.tcDepth2.xy + rowOfs[3]).r;
    depth[3] = tex2D(depthSampler, pixel.tcDepth3.xy + rowOfs[3]).r;
    viewCoc = saturate(dofEqWeapon.x * -depth + dofEqWeapon.y);
    sceneCoc = saturate(dofEqWorld.x * depth + dofEqWorld.y);
    curCoc = min(viewCoc, sceneCoc);
    coc = max(coc, curCoc);

    maxCoc = max(max(coc[0], coc[1]), max(coc[2], coc[3]));
    return half4(color, maxCoc);
}
```

우리는 DofDownsample()에 의해 생성된 이미지에 Gaussian blur를 적용합니다. 우리는 blur 반경을 bilinear filtering을 사용하여 한 번에 두 샘플을 읽는 수평 및 수직 필터의 최적 시퀀스로 자동으로 나누는 코드로 이를 수행합니다. 또한, 두 개의 분리된 1D 패스보다 더 많은 텍스처 룩업을 사용하지 않을 때 단일 분리되지 않은 2D 패스를 적용합니다. 2D 케이스에서, 각 텍스처 룩업은 4개의 샘플을 적용합니다. Listing 28-2는 코드를 보여줍니다.

**Listing 28-2** DofNearCoc()

```hlsl
// 이것들은 게임 엔진에 의해 설정됩니다.
sampler shrunkSampler;
// DofDownsample()의 출력
sampler blurredSampler; // shrunk sampler의 흐린 버전

// 이것은 근거리 circle of confusion에 사용되는 실제
// 값을 계산하는 픽셀 셰이더 함수입니다.
// "texCoords"는 왼쪽 하단 픽셀에서 0이고 오른쪽 상단에서 1입니다.
float4 DofNearCoc(const float2 texCoords)
{
    float3 color;
    float coc;
    half4 blurred;
    half4 shrunk;

    shrunk = tex2D(shrunkSampler, texCoords);
    blurred = tex2D(blurredSampler, texCoords);

    color = shrunk.rgb;
    coc = 2 * max(blurred.a, shrunk.a) - shrunk.a;

    return float4(color, coc);
}
```

Listing 28-3에서 우리는 DofNearCoc()의 결과에 작은 3x3 blur를 적용하여 도입된 불연속성을 매끄럽게 합니다.

**Listing 28-3** SmallBlur

```hlsl
// 이 vertex와 pixel shader는 colorMapSampler의 이미지에 3 x 3 blur를 적용하며,
// 이는 렌더 타겟과 동일한 크기입니다.
// 샘플 가중치는 모서리에서 1/16, 가장자리에서 2/16,
// 중심에서 4/16입니다.
sampler colorSampler;
// DofNearCoc()의 출력
float2 invRenderTargetSize;

struct PixelInput
{
    float4 position : POSITION;
    float4 texCoords : TEXCOORD0;
};

PixelInput SmallBlurVS(float4 position, float2 texCoords)
{
    PixelInput pixel;
    const float4 halfPixel = {-0.5, 0.5, -0.5, 0.5};

    pixel.position = Transform_ObjectToClip(position);
    pixel.texCoords = texCoords.xxyy + halfPixel * invRenderTargetSize;

    return pixel;
}

float4 SmallBlurPS(const PixelInput pixel)
{
    float4 color;

    color = 0;
    color += tex2D(colorSampler, pixel.texCoords.xz);
    color += tex2D(colorSampler, pixel.texCoords.yz);
    color += tex2D(colorSampler, pixel.texCoords.xw);
    color += tex2D(colorSampler, pixel.texCoords.yw);

    return color / 4;
}
```

우리의 마지막 셰이더인 Listing 28-4는 화면에 가변 폭 블러를 적용합니다. 우리는 현재 픽셀 아래의 색상 샘플을 실제로 룩업하는 것을 피하기 위해 프레임 버퍼와 함께 premultiplied alpha blend를 사용합니다. 셰이더에서, 우리는 실제로 읽는 모든 색상 샘플을 알파가 1인 것으로 취급합니다. 읽지 않은 중심 샘플을 셰이더 내에서 색상이 0이고 알파가 0인 것으로 취급하면 화면에서 올바른 결과를 제공합니다.

**Listing 28-4** ApplyDepthOfField()

```hlsl
sampler colorSampler;
// 원본 소스 이미지
sampler smallBlurSampler;
// SmallBlurPS()의 출력
sampler largeBlurSampler;
// DofDownsample()의 흐린 출력
float2 invRenderTargetSize;
float4 dofLerpScale;
float4 dofLerpBias;
float3 dofEqFar;

float4 tex2Doffset(sampler s, float2 tc, float2 offset)
{
    return tex2D(s, tc + offset * invRenderTargetSize);
}

half3 GetSmallBlurSample(float2 texCoords)
{
    half3 sum;
    const half weight = 4.0 / 17;

    sum = 0;
    // 알파 블렌딩으로 수행된 흐리지 않은 샘플
    sum += weight * tex2Doffset(colorSampler, tc, +0.5, -1.5).rgb;
    sum += weight * tex2Doffset(colorSampler, tc, -1.5, -0.5).rgb;
    sum += weight * tex2Doffset(colorSampler, tc, -0.5, +1.5).rgb;
    sum += weight * tex2Doffset(colorSampler, tc, +1.5, +0.5).rgb;

    return sum;
}

half4 InterpolateDof(half3 small, half3 med, half3 large, half t)
{
    half4 weights;
    half3 color;
    half alpha;

    // 각 샘플에 대한 크로스 블렌드 가중치를 효율적으로 계산합니다.
    // 흐리지 않은 샘플에서 작은 블러로의 페이드가 거리 d0에 걸쳐 발생하고,
    // 작은 블러에서 중간 블러로의 페이드가 거리 d1에 걸쳐,
    // 중간 블러에서 큰 블러로의 페이드가 거리 d2에 걸쳐 발생하며,
    // 여기서 d0 + d1 + d2 = 1입니다.
    // dofLerpScale = float4( -1 / d0, -1 / d1, -1 / d2, 1 / d2 );
    // dofLerpBias = float4( 1, (1 – d2) / d1, 1 / d2, (d2 – 1) / d2 );
    weights = saturate(t * dofLerpScale + dofLerpBias);
    weights.yz = min(weights.yz, 1 - weights.xy);

    // 가중치 "weights.x"를 가진 흐리지 않은 샘플은 알파 블렌딩으로 수행됨
    color = weights.y * small + weights.z * med + weights.w * large;
    alpha = dot(weights.yzw, half3(16.0 / 17, 1.0, 1.0));

    return half4(color, alpha);
}

half4 ApplyDepthOfField(const float2 texCoords)
{
    half3 small;
    half4 med;
    half3 large;
    half depth;
    half nearCoc;
    half farCoc;
    half coc;

    small = GetSmallBlurSample(texCoords);
    med = tex2D(smallBlurSampler, texCoords);
    large = tex2D(largeBlurSampler, texCoords).rgb;

    nearCoc = med.a;
    depth = tex2D(depthSampler, texCoords).r;

    if (depth > 1.0e6)
    {
        coc = nearCoc; // 우리는 하늘을 흐리게 하고 싶지 않습니다.
    }
    else
    {
        // dofEqFar.x와 dofEqFar.y는 먼 초점이 맞지 않는 영역에 대한
        // 깊이로 변환하기 위한 선형 ramp를 지정합니다.
        // dofEqFar.z는 원거리 블러 반경에 대한 근거리 블러 반경의 비율입니다.
        farCoc = saturate(dofEqFar.x * depth + dofEqFar.y);
        coc = max(nearCoc, farCoc * dofEqFar.z);
    }

    return InterpolateDof(small, med.rgb, large, coc);
}
```

## 28.6 성능 (Performance)

이러한 셰이더에서는 많은 산술 연산이 진행되지 않으므로, 비용은 텍스처 룩업에 의해 지배됩니다.

이것은 큰 Gaussian blur를 적용하는 데 필요한 가변 수의 샘플을 세지 않고 픽셀당 8.625개의 샘플과 같습니다. separable 필터로 구현되면, blur는 일반적으로 각각 8개의 텍스처 룩업이 있는 두 개 이하의 패스를 사용하며, 이는 bilinear filtering으로 17개의 탭을 제공합니다. 이것은 원본 이미지에서 픽셀당 평균 1개의 샘플로 평균화됩니다. 픽셀당 예상되는 텍스처 룩업 수는 약 9.6입니다.

프레임 버퍼 대역폭은 또 다른 고려 사항입니다. 이 기술은 원래 다운샘플에 대해 1/4 해상도 이미지에 한 번, 그런 다음 큰 Gaussian blur에 대해 (일반적으로) 두 번 더 씁니다. 1/4 해상도 이미지에 대해 두 개의 추가 패스가 있습니다—방정식 1을 적용하고 그 결과를 약간 흐리게 하기 위해. 마지막으로, 원본 이미지의 각 픽셀은 최종 출력을 얻기 위해 한 번 작성됩니다. 이것은 원본 이미지의 모든 픽셀에 대해 1.3125번의 쓰기로 계산됩니다.

마찬가지로, 이 기술에는 큰 Gaussian blur에 대해 두 개의 패스만 가정하여 6개의 렌더 타겟 스위치가 있습니다.

측정된 성능 비용은 Radeon X1900 및 GeForce 7900과의 테스트에서 1024x768에서 1~1.5밀리초였습니다. 차세대 콘솔의 성능 저하는 비슷합니다. 이것은 실제로 Scheuermann 2004를 기반으로 한 원래 구현보다 빠른데, 아마도 텍스처 읽기의 절반 미만을 사용하기 때문입니다.

## 28.7 결과 및 제한사항 (Results and Limitations)

우리의 접근 방식을 사용하면, 초점이 맞는 객체가 초점이 맞지 않는 배경 객체에 bleeding될 것입니다. 이것은 이 기술 및 일반적으로 포스트 프로세스 DoF 기술에서 가장 불쾌하지 않은 아티팩트입니다. 이러한 아티팩트는 17-tap blur에 대한 추가 깊이 샘플을 취함으로써 줄일 수 있습니다. 우리가 본 바와 같이, 배경은 전경보다 더 작은 블러 반경을 사용해야 하기 때문에 이것으로 충분해야 합니다.

두 번째 아티팩트는 기술에 내재되어 있습니다: 기술이 실제로 초점이 맞지 않는 객체의 블러가 아닌 화면의 블러라는 것이 명백해질 정도로 근처 객체에 대한 블러 반경을 증가시킬 수 없습니다. 그림 28-7은 이 문제의 최악의 경우 예입니다. 반면 그림 28-8은 더 일반적인 상황을 보여줍니다. 그림 28-8의 중앙 이미지는 일반적인 블러 반경을 보여줍니다. 오른쪽 이미지는 그 블러 반경의 두 배를 가지고 있습니다; 배경의 비교적 큰 바위조차 존재에서 smear되었습니다. 이것은 카메라가 움직일 때 특히 불쾌해지며, 전경 객체 주위에 안개로 나타납니다.

**그림 28-7** 우리 알고리즘의 최악의 경우 시나리오

**그림 28-8** 블러 반경이 너무 크면, 효과가 고장납니다

이것이 발생하는 반경은 초점이 맞지 않는 객체의 크기와 초점이 맞아야 하는 기하학의 디테일 양에 따라 달라집니다. 초점이 맞지 않는 더 작은 객체와 더 높은 주파수를 가진 초점이 맞는 객체는 더 작은 최대 블러 반경을 필요로 합니다. 이것은 전경 객체를 별도의 버퍼로 렌더링하여 흐려지는 색상 정보가 전경 객체에 대해서만 되도록 함으로써 극복될 수 있습니다. 이것은 누락된 픽셀을 신중하게 처리해야 합니다. 또한 렌더링 파이프라인에 기술을 더 침입적으로 만듭니다.

마지막으로, 우리는 투명도를 명시적으로 처리하지 않습니다. 투명한 표면은 그 뒤의 첫 번째 불투명 객체의 CoC를 사용합니다. 이를 수정하기 위해, 투명한 객체는 모든 불투명한 기하학에 피사계 심도가 적용된 후에 그려질 수 있습니다. 그들은 텍스처 룩업을 더 낮은 밉맵 레벨로 편향시킴으로써 DoF의 인상을 받을 수 있습니다. 파티클 효과는 또한 초점이 맞지 않을 때 파티클의 크기를 약간 증가시킴으로써 이익을 얻을 수 있습니다. 창과 같이 불투명한 객체와 가장자리를 공유하는 투명한 객체는 경계에서 여전히 일부 불쾌한 아티팩트를 가질 수 있습니다. 다시, 이것은 기술을 침입적으로 만듭니다. 우리는 투명도를 완전히 무시하는 것이 대부분의 상황에서 충분히 잘 작동한다는 것을 발견했습니다.

## 28.8 참고문헌 (References)

Demers, Joe. 2004. "Depth of Field: A Survey of Techniques." In GPU Gems, edited by Randima Fernando, pp. 375–390. Addison-Wesley.

Kass, Michael, Aaron Lefohn, and John Owens. 2006. "Interactive Depth of Field Using Simulated Diffusion on a GPU." Technical report. Pixar Animation Studios. Available online at http://graphics.pixar.com/DepthOfField/paper.pdf.

Kosloff, Todd Jerome, and Brian A. Barsky. 2007. "An Algorithm for Rendering Generalized Depth of Field Effects Based On Simulated Heat Diffusion." Technical Report No. UCB/EECS-2007-19. Available online at http://www.eecs.berkeley.edu/Pubs/TechRpts/2007/EECS-2007-19.pdf.

Kivánek, Jaroslav, Jiří Žára, and Kadi Bouatouch. 2003. "Fast Depth of Field Rendering with Surface Splatting." Presentation at Computer Graphics International 2003. Available online at http://www.cgg.cvut.cz/~xkrivanj/papers/cgi2003/9-3_krivanek_j.pdf.

Mulder, Jurriaan, and Robert van Liere. 2000. "Fast Perception-Based Depth of Field Rendering." Available online at http://www.cwi.nl/~robertl/papers/2000/vrst/paper.pdf.

Potmesil, Michael, and Indranil Chakravarty. 1981. "A Lens and Aperture Camera Model for Synthetic Image Generation." In Proceedings of the 8th Annual Conference on Computer Graphics and Interactive Techniques, pp. 297–305.

Scheuermann, Thorsten. 2004. "Advanced Depth of Field." Presentation at Game Developers Conference 2004. Available online at http://ati.amd.com/developer/gdc/Scheuermann_DepthOfField.pdf.

