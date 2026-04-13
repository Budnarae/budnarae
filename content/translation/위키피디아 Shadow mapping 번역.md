---
title: '위키피디아 Shadow mapping 번역'
tags:
  - graphics
  - translation
---

_들어가는 말_

---

**섀도우 매핑**

**섀도우 매핑(Shadow mapping) 또는 섀도잉 프로젝션(shadowing projection)은 3D 컴퓨터 그래픽스에 그림자를 추가하는 프로세스이다.** 이 개념은 1978년 Lance Williams가 "Casting curved shadows on curved surfaces"라는 제목의 논문에서 소개하였다. 그 이후로 이것은 많은 콘솔 및 PC 게임의 사전 렌더링(pre-rendered) 및 실시간(realtime) 장면 모두에 사용되어 왔다.

**그림자는 픽셀을 광원의 시야에 저장된 z-버퍼(z-buffer) 또는 깊이 이미지(depth image)와 비교하여, 해당 픽셀이 광원으로부터 보이는지 여부를 테스트함으로써 생성된다.** 이 깊이 정보는 텍스처 형태로 저장된다.

---

**섀도우 및 섀도우 맵의 원리**

광원에서 밖을 바라본다면, 보이는 모든 물체는 빛 속에 나타날 것이다. 그러나 그 물체들 뒤에 있는 모든 것은 그림자 속에 있게 될 것이다. 이것이 섀도우 맵을 생성하는 데 사용되는 기본 원리이다. 광원의 시야를 렌더링하고, 광원이 보는 모든 표면의 깊이(섀도우 맵)를 저장한한다. 다음으로, 일반적인 장면을 렌더링하고 그려지는 모든 점의 깊이(눈이 아닌 광원에 의해 보이는 것처럼)를 이 깊이 맵과 비교한다.

이 기법은 **섀도우 볼륨(shadow volumes)**보다 정확도는 낮으나, 섀도우 맵은 특정 애플리케이션에서 두 기법 중 어느 쪽이 얼마나 많은 채우기 시간(fill time)을 필요로 하는지에 따라 더 빠른 대안이 될 수 있으며, 따라서 실시간 애플리케이션에 더 적합할 수 있다. 게다가, 섀도우 맵은 추가적인 스텐실 버퍼(stencil buffer) 사용을 요구하지 않으며 부드러운 가장자리(soft edge)를 가진 그림자를 생성하도록 수정될 수 있다. 그러나 섀도우 볼륨과는 달리, 섀도우 맵의 정확도는 해상도에 의해 제한된다.

---

**알고리즘 개요**

그림자가 적용된 장면을 렌더링하는 과정은 두 가지 주요 그리기 단계(drawing steps)를 포함하다. 첫 번째는 섀도우 맵 자체를 생성하고, 두 번째는 그것을 장면에 적용한다. 구현 방식(및 광원의 개수)에 따라, 이 과정은 두 번 이상의 그리기 패스(drawing passes)를 필요로 할 수 있다.

**섀도우 맵 생성**

첫 번째 단계는 광원의 시점에서 장면을 렌더링하는 것이다. **점 광원(point light source)**의 경우, 시야는 원하는 효과 각도만큼 넓은 **원근 투영(perspective projection)**이어야 한다(일종의 정사각형 스포트라이트와 같을 것이다). **방향성 광원(directional light, 예: 태양광)**의 경우, **직교 투영(orthographic projection)**을 사용해야 한다.

이 렌더링으로부터 **깊이 버퍼(depth buffer)**가 추출되어 저장된다. 깊이 정보만이 관련되므로, 그리기 시간을 절약하기 위해 이 렌더링에서는 색상 버퍼 업데이트를 피하고 모든 조명 및 텍스처 계산을 비활성화하는 것이 일반적이다. 이 깊이 맵은 종종 그래픽 메모리에 **텍스처(texture)**로 저장된다.

이 깊이 맵은 광원이나 장면에 있는 객체에 변경 사항이 생길 때마다 업데이트되어야 하지만, 시점 카메라만 움직이는 상황과 같은 다른 경우에는 재사용될 수 있다. (광원이 여러 개 있는 경우, 각 광원에 대해 별도의 깊이 맵을 사용해야 한다.)

많은 구현에서, 맵을 다시 그리는 데 걸리는 시간을 절약하기 위해 장면의 객체 하위 집합(subset)만을 섀도우 맵에 렌더링하는 것이 실용적이다. 또한, 다음 단계에서 그려지는 표면(즉, 그림자를 드리우는 표면)의 깊이와 깊이 맵 값이 가까워지는 **스티칭 문제(stitching problems)**를 해결하기 위한 시도로, 객체를 광원에서 멀리 이동시키는 **깊이 오프셋(depth offset)**이 섀도우 맵 렌더링에 적용될 수 있다. 대안으로, 비슷한 결과를 위해 때때로 앞면 컬링(culling front faces)을 하고 객체의 뒷면만 섀도우 맵에 렌더링하는 방법이 사용되기도 한다.

**장면 셰이딩**

두 번째 단계는 일반적인 카메라 시점에서 장면을 그리고 섀도우 맵을 적용하는 것이다. 이 프로세스는 세 가지 주요 구성 요소로 이루어진다. 첫 번째는 광원에서 보이는 객체의 좌표를 찾는 것이다. 3D 객체는 화면에 기하학적 모양을 나타내기 위해 X축과 Y축을 가진 2D 좌표만 사용하므로, 이 **정점 좌표(vertex coordinates)**는 섀도우 맵(깊이 맵) 자체 내의 그림자 부분에 해당하는 가장자리와 일치할 것이다. 두 번째는 객체의 z 값을 깊이 맵의 z 값과 비교하는 **깊이 테스트(depth test)**이며, 마지막으로, 이 작업이 완료되면 객체는 그림자 속에 있거나 빛을 받는 상태로 그려져야 한다.

**광원 공간 좌표**

깊이 맵에 대해 한 점을 테스트하기 위해, 장면 좌표(scene coordinates)에서의 그 위치는 광원에 의해 보이는 것과 동등한 위치로 변환되어야 한다. 이것은 **행렬 곱셈(matrix multiplication)**을 통해 달성된다. 화면에서의 객체의 위치는 일반적인 좌표 변환에 의해 결정되지만, 객체를 광원 공간에 배치하기 위해 두 번째 좌표 세트가 생성되어야 한다.

월드 좌표(world coordinates)를 광원의 시야 좌표로 변환하는 데 사용되는 행렬은 첫 번째 단계에서 섀도우 맵을 렌더링하는 데 사용된 행렬과 동일하다(OpenGL에서는 이는 모델, 뷰 및 투영 행렬의 곱이다). 이것은 **동차 좌표(homogeneous coordinates)** 세트를 생성할 것이며, 이는 **정규화된 장치 좌표(normalized device coordinates)**가 되기 위해 원근 분할(perspective division, 3D 투영 참조)을 필요로 하며, 이 좌표에서 각 구성 요소(x, y 또는 z)는 -1과 1 사이에 놓인다(광원 시야에서 보인다면). 많은 구현(예: OpenGL 및 Direct3D)은 이러한 -1에서 1 사이의 값을 0에서 1 사이로 매핑하기 위해 추가적인 **스케일 및 바이어스 행렬 곱셈(scale and bias matrix multiplication)**을 요구하는데, 이는 깊이 맵(텍스처 맵) 조회를 위한 보다 일반적인 좌표이다. 이 스케일링은 원근 분할 이전에 수행될 수 있으며, 다음 행렬을 곱함으로써 이전 변환 계산에 쉽게 통합될 수 있다.

0.5 0 0 0.5

0 0.5 0 0.5

0 0 0.5 0.5

0 0 0 1

**셰이더(shader)** 또는 다른 그래픽 하드웨어 확장으로 수행되는 경우, 이 변환은 일반적으로 **정점(vertex) 레벨**에서 적용되며, 생성된 값은 다른 정점들 사이에서 **보간(interpolate)**되어 **프래그먼트(fragment) 레벨**로 전달된다.

**깊이 맵 테스트**

일단 광원 공간 좌표가 발견되면, x 및 y 값은 일반적으로 깊이 맵 텍스처의 위치에 해당하고, z 값은 그와 연관된 깊이에 해당하며, 이제 깊이 맵에 대해 테스트될 수 있다.

적절한 (x,y) 위치에서 깊이 맵에 저장된 값보다 z 값이 크면, 그 객체는 가려진(occluding) 객체 뒤에 있는 것으로 간주되어 **실패(failure)**로 표시되어 그리기 프로세스에 의해 그림자 속에 그려져야 한다. 그렇지 않으면, 빛을 받은 상태로 그려져야 한다.

(x,y) 위치가 깊이 맵의 범위를 벗어나는 경우, 프로그래머는 기본적으로 해당 표면이 빛을 받거나(보통 빛을 받는 것으로 결정한다) 그림자 속에 있어야 한다고 결정해야 한다.

셰이더 구현에서, 이 테스트는 프래그먼트 레벨에서 수행될 것이다. 또한, 하드웨어에서 사용될 **텍스처 맵 저장소의 유형**을 선택할 때 주의해야 한다. **보간(interpolation)**이 불가능하면 그림자가 날카롭고 들쭉날쭉한 가장자리(jagged edge)를 가진 것처럼 보일 것인데(섀도우 맵 해상도가 높을수록 이 효과는 줄어들 수 있다), 이 효과에 주의해야 한다.

단순히 통과 또는 실패가 아닌, 값의 범위(그림자 가장자리에 대한 근접성을 기반으로 함)를 사용하여 부드러운 가장자리를 가진 그림자를 생성하도록 깊이 맵 테스트를 수정하는 것이 가능하다.

섀도우 매핑 기법은 또한 빛을 받는 영역에 텍스처를 그려 프로젝터 효과를 시뮬레이션하도록 수정될 수 있다.

**장면 그리기**

그림자를 사용하여 장면을 그리는 것은 몇 가지 다른 방식으로 수행될 수 있다. **프로그래머블 셰이더(programmable shaders)**를 사용할 수 있다면, (섀도우 맵을 생성하기 위한 초기 이전 패스 후에) 프래그먼트 셰이더가 깊이 맵 테스트를 수행하여 결과에 따라 객체를 그림자 속에 있거나 빛을 받은 상태로 단순히 그리고, 한 번의 패스로 장면을 그릴 수 있다.

셰이더를 사용할 수 없는 경우, 깊이 맵 테스트 수행은 일반적으로 일부 하드웨어 확장(예: GL_ARB_shadow)에 의해 구현되어야 하며, 이는 일반적으로 두 가지 조명 모델(빛을 받는 상태와 그림자진 상태) 중 하나를 선택하는 것을 허용하지 않아 더 많은 렌더링 패스를 필요로 한다:

- 전체 장면을 그림자 속에 렌더링한한다. 가장 일반적인 조명 모델(Phong 반사 모델 참조)의 경우, 기술적으로는 빛의 **주변광(ambient component)**만을 사용하여 수행되어야 하지만, 그림자 속에서 곡면이 평평하게 보이는 것을 방지하기 위해 희미한 **확산광(diffuse light)**도 포함하도록 일반적으로 조정된다.
    
- 깊이 맵 테스트를 활성화하고 장면을 빛을 받은 상태로 렌더링하다. 깊이 맵 테스트에 실패한 영역은 덮어쓰여지지 않고 그림자진 상태로 남아 있을 것이다.
    
- 추가적인 광원 각각에 대해 **가산 혼합(additive blending)**을 사용하여 그 효과를 이미 그려진 빛과 결합하는 추가 패스가 사용될 수 있다. (이러한 각 패스는 관련 섀도우 맵을 생성하기 위한 추가적인 이전 패스를 필요로 한다.)
    

이 글의 예시 그림들은 OpenGL 확장인 **GL_ARB_shadow_ambient**를 사용하여 두 번의 패스로 섀도우 맵 프로세스를 달성하였다.

---

**섀도우 맵 실시간 구현**

실시간 섀도우 매핑의 주요 단점 중 하나는 섀도우 맵의 크기와 깊이가 최종 그림자의 품질을 결정한다는 것이다. 이는 일반적으로 **앨리어싱(aliasing)** 또는 **그림자 연속성 결함(shadow continuity glitches)**으로 나타난다. 이 한계를 극복하는 간단한 방법은 섀도우 맵 크기를 늘리는 것이지만, 메모리, 계산 또는 하드웨어 제약으로 인해 항상 가능한 것은 아니다. 이 한계를 우회하기 위해 실시간 섀도우 매핑을 위한 일반적으로 사용되는 기법들이 개발되었다. 여기에는 **캐스케이드 섀도우 맵(Cascaded Shadow Maps, CSM)**, **사다리꼴 섀도우 맵(Trapezoidal Shadow Maps, TSM)**, **광원 공간 원근 섀도우 맵(Light Space Perspective Shadow maps, LiSPSM)**, 또는 **평행 분할 섀도우 맵(Parallel-Split Shadow maps, PSSM)**이 포함된다.

또한, 생성된 그림자는 앨리어싱이 없더라도 항상 바람직하지 않은 **단단한 가장자리(hard edges)**를 갖는다는 점도 주목할 만하다. 실제와 같은 부드러운 그림자(**soft shadows**)를 에뮬레이션하기 위해, 섀도우 맵에 대한 여러 번의 조회(lookups)를 수행하거나, 부드러운 가장자리를 에뮬레이션하기 위한 기하학적 구조를 생성하거나, 비표준 깊이 섀도우 맵을 생성하는 등 여러 해결책이 개발되었다. 이들의 주목할 만한 예로는 **Percentage Closer Filtering (PCF)**, **Smoothies**, 및 **Variance Shadow maps (VSM)**이 있다.

---

**섀도우 매핑 기법**

**단순(Simple)**

- SSM "Simple"
    

**분할(Splitting)**

- PSSM "Parallel Split"
    
- CSM "Cascaded"
    

**변형(Warping)**

- LiSPSM "Light Space Perspective"
    
- TSM "Trapezoid"
    
- PSM "Perspective"
    
- CSSM "Camera Space"
    

**스무딩(Smoothing)**

- PCF "Percentage Closer Filtering"
    

**필터링(Filtering)**

- ESM "Exponential"
    
- CSM "Convolution"
    
- VSM "Variance"
    
- SAVSM "Summed Area Variance"
    
- SMSR "Shadow Map Silhouette Revectorization"
    

**부드러운 그림자(Soft Shadows)**

- PCSS "Percentage Closer"
    
- VSSM "Variance Soft Shadow Mapping"
    
- SSSS "Screen space soft shadows"
    
- FIV "Fullsphere Irradiance Vector"
    

**기타(Assorted)**

- ASM "Adaptive"
    
- AVSM "Adaptive Volumetric"
    
- CSSM "Camera Space"
    
- DASM "Deep Adaptive"1
    
- DPSM "Dual Paraboloid"2
    
- DSM "Deep"3
    
- FSM "Forward"4
    
- LPSM "Logarithmic"5
    
- MDSM "Multiple Depth"6
    
- RTW "Rectilinear"7
    
- RMSM "Resolution Matched"8
    
- SDSM "Sample Distribution"9
    
- SPPSM "Separating Plane Perspective"10
    
- SSSM "Shadow Silhouet11te"
    

---

**기타(Miscellaneous)**

- Shadow Depth Maps (SDM)
    
- Perspective shadow maps (PSMs)
    
- Light Space Perspective Shadow Maps (LSPSMs)
    
- Cascaded Shadow Maps (CSMs)
    
- Variance Shadow Maps (VSMs)

