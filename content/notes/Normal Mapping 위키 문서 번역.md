---
tags:
  - graphics
  - translation
---

_bump mapping_

---

[원문](https://en.wikipedia.org/wiki/Normal_mapping)

---

# 노멀 매핑

이 문서에는 추가 인용이 필요합니다.

[3D 컴퓨터 그래픽스](https://en.wikipedia.org/wiki/3D_computer_graphics)에서 노멀 매핑(normal mapping) 또는 Dot3 범프 매핑(bump mapping)은 범프와 움푹한 곳의 조명을 속이는 데 사용되는 [텍스처 매핑](https://en.wikipedia.org/wiki/Texture_mapping) 기법으로, [범프 매핑](https://en.wikipedia.org/wiki/Bump_mapping)의 한 구현입니다. 이는 더 많은 [폴리곤](https://en.wikipedia.org/wiki/Polygonal_modeling)을 사용하지 않고도 디테일을 추가하는 데 사용됩니다. 이 기법의 일반적인 사용 방법은 고폴리곤 모델이나 [높이 맵](https://en.wikipedia.org/wiki/Heightmap)으로부터 노멀 맵을 생성하여 [저폴리곤 모델](https://en.wikipedia.org/wiki/Low_poly)의 외관과 디테일을 크게 향상시키는 것입니다.

노멀 맵은 일반적으로 일반 [RGB](https://en.wikipedia.org/wiki/RGB) 이미지로 저장되며, RGB 구성 요소는 각각 [표면 법선](https://en.wikipedia.org/wiki/Surface_normal)의 X, Y, Z 좌표에 대응합니다.

## 역사

1978년 [Jim Blinn](https://en.wikipedia.org/wiki/Jim_Blinn)은 기하학적으로 평평한 면이 세밀한 외관을 갖도록 만들기 위해 표면의 법선을 어떻게 교란할 수 있는지 설명했습니다.

고폴리곤 모델에서 기하학적 디테일을 가져오는 아이디어는 Krishnamurthy와 Levoy의 "Fitting Smooth Surfaces to Dense Polygon Meshes"(Proc. [SIGGRAPH](https://en.wikipedia.org/wiki/SIGGRAPH) 1996)에서 소개되었으며, 이 접근 방식은 [nurbs](https://en.wikipedia.org/wiki/Nurbs) 위에 [디스플레이스먼트 맵](https://en.wikipedia.org/wiki/Displacement_mapping)을 생성하는 데 사용되었습니다. 1998년, 고폴리곤 메시에서 저폴리곤 메시로 노멀 맵을 사용하여 디테일을 전송하는 핵심 아이디어를 담은 두 편의 논문이 발표되었습니다: Cohen 등의 "Appearance Preserving Simplification"(SIGGRAPH 1998)과 Cignoni 등의 "A general method for preserving attribute values on simplified meshes"(IEEE Visualization '98). 전자는 변위 대신 표면 법선을 텍스처에 직접 저장하는 아이디어를 소개했지만, 저세밀도 모델이 특정한 제약된 단순화 알고리즘에 의해 생성되어야 했습니다. 후자는 고폴리곤 메시와 저폴리곤 메시를 분리하고, 저세밀도 모델이 어떻게 생성되었는지에 의존하지 않는 방식으로 고세밀도 모델의 모든 속성(색상, [텍스처 좌표](https://en.wikipedia.org/wiki/Texture_mapping), [변위](https://en.wikipedia.org/wiki/Displacement_mapping) 등)을 재현할 수 있는 더 간단한 접근 방식을 제시했습니다. 텍스처에 법선을 저장하는 것과 더 일반적인 생성 프로세스의 조합은 현재 사용 가능한 대부분의 도구에서 여전히 사용되고 있습니다.

## 좌표 공간

좌표축의 방향은 노멀 맵이 인코딩된 [공간](https://en.wikipedia.org/wiki/Vector_Space)에 따라 다릅니다.

### 오브젝트 공간

간단한 구현에서는 오브젝트 공간의 법선을 인코딩하여 빨강, 초록, 파랑 구성 요소가 X, Y, Z 좌표와 직접 대응하도록 합니다.

오브젝트 공간에서는 좌표 시스템이 일정합니다.

그러나 오브젝트 공간 노멀 맵은 표면의 방향이 다르기 때문에 여러 모델에서 쉽게 재사용할 수 없습니다. 색상 텍스처 맵은 자유롭게 재사용할 수 있고, 노멀 맵은 특정 텍스처 맵과 대응하는 경향이 있으므로, 아티스트에게는 노멀 맵이 동일한 속성을 가지는 것이 바람직합니다.

### 탄젠트 공간

노멀 맵 재사용은 [탄젠트 공간](https://en.wikipedia.org/wiki/Tangent_space)에서 맵을 인코딩함으로써 가능해집니다.

탄젠트 공간은 모델 표면에 접하는 [벡터 공간](https://en.wikipedia.org/wiki/Vector_Space)입니다.

좌표 시스템은 표면을 가로질러 부드럽게 변화합니다(텍스처 좌표에 대한 위치의 도함수를 기반으로).

탄젠트 공간 노멀 맵은 표면에서 직접 바깥쪽을 향하는 벡터에 해당하는 지배적인 보라색으로 식별할 수 있습니다. [계산](https://en.wikipedia.org/wiki/Normal_mapping#Calculation)을 참조하세요.

## 계산

이 섹션은 대부분의 독자가 이해하기에 너무 기술적일 수 있습니다.(2022년 1월)

표면 법선은 컴퓨터 그래픽스에서 주로 [경면 반사](https://en.wikipedia.org/wiki/Specular_reflection)라는 현상을 모방하여 조명 목적으로 사용됩니다. 물체의 가시적 이미지는 표면에서 반사되는 빛이므로, 표면의 각 지점에서 얻은 빛 정보는 대신 해당 지점의 탄젠트 공간에서 계산할 수 있습니다.

3차원 공간의 표면의 각 탄젠트 공간에 대해, 탄젠트 공간의 모든 벡터에 수직인 두 개의 벡터가 있습니다. 이 벡터들은 [법선 벡터](https://en.wikipedia.org/wiki/Normal_\(geometry\))라고 하며, 이 두 벡터 중 하나를 선택하면 그 지점에서 표면이 어떻게 [방향지어져](https://en.wikipedia.org/wiki/Orientability) 있는지에 대한 설명을 제공합니다. 왜냐하면 광선과 법선 벡터 사이의 입사각에 빛 정보가 의존하며, 빛은 조건을 만족할 때만 보이기 때문입니다. 그러한 경우, 법선 벡터를 따라 방향 를 가진 광선의 반사는 다음과 같이 주어집니다:

여기서 법선에 대한 광선의 [투영](https://en.wikipedia.org/wiki/Vector_projection)은 입니다.

직관적으로, 이것은 단순히 외부에서 보고 있다면 물체의 바깥쪽 면만 볼 수 있고, 내부에서 보고 있다면 안쪽 면만 볼 수 있다는 것을 의미합니다. 빛 정보는 국소적이므로, 표면이 반드시 전체적으로 방향지을 수 있을 필요는 없습니다. 이것이 [뫼비우스의 띠](https://en.wikipedia.org/wiki/M%C3%B6bius_strip)나 [클라인 병](https://en.wikipedia.org/wiki/Klein_bottle)과 같은 공간들이 방향지을 수 없음에도 불구하고 여전히 시각화할 수 있는 이유입니다.

법선은 다양한 좌표 시스템으로 지정할 수 있습니다. 컴퓨터 그래픽스에서는 표면의 탄젠트 평면에 상대적으로 법선을 계산하는 것이 유용합니다.

이것은 응용 프로그램의 표면이 렌더링 과정이나 골격 애니메이션과 같은 다양한 변환을 거치기 때문에 유용하며, 따라서 법선 벡터 정보가 이러한 변환 하에서 보존되는 것이 중요합니다.

그러한 변환의 예로는 변환, 회전, 전단 및 스케일링, 원근 투영, 또는 정밀하게 세밀한 캐릭터의 골격 애니메이션이 있습니다.

컴퓨터 그래픽스의 목적상, 표면의 가장 일반적인 표현은 [삼각분할](https://en.wikipedia.org/wiki/Triangulation_\(topology\))이며, 그 결과 한 점에서의 탄젠트 평면은 그 점과 교차하는 각 삼각형을 포함하는 평면들 사이를 보간함으로써 얻을 수 있습니다.

마찬가지로, 탄젠트 공간을 가진 [매개변수 곡면](https://en.wikipedia.org/wiki/Parametric_surface)의 경우, 매개변수화는 편미분을 산출하며, 이러한 도함수는 [모든 점에서 탄젠트 공간의 기저로 사용될 수 있습니다](https://en.wikipedia.org/wiki/Tangent_space#Tangent_vectors_as_directional_derivatives).

법선에서 교란을 찾기 위해서는 탄젠트 공간이 올바르게 계산되어야 합니다. 가장 자주 법선은 모델 및 뷰 행렬을 적용한 후 프래그먼트 셰이더에서 교란됩니다[출처 필요]. 일반적으로 기하학은 법선과 탄젠트를 제공합니다. 탄젠트는 탄젠트 평면의 일부이며 행렬의 [선형](https://en.wikipedia.org/wiki/Affine_transformation) 부분(상위 3x3)으로 간단히 변환할 수 있습니다. 그러나 법선은 [역전치](https://en.wikipedia.org/wiki/Surface_normal#Transforming_normals)로 변환되어야 합니다. 대부분의 응용 프로그램은 변환된 기하학(및 관련 UV)과 일치하도록 바이탄젠트를 원합니다. 따라서 바이탄젠트를 탄젠트에 수직이 되도록 강제하는 대신, 일반적으로 탄젠트처럼 바이탄젠트를 변환하는 것이 더 바람직합니다. 를 탄젠트, 를 바이탄젠트, 를 법선, 를 3x3 모델 행렬의 선형 부분, 를 3x3 뷰 행렬의 선형 부분이라고 하겠습니다.

표면의 [람베르트](https://en.wikipedia.org/wiki/Lambertian_reflectance)(확산) 조명을 계산하기 위해, 셰이딩 점에서 광원으로의 단위 [벡터](https://en.wikipedia.org/wiki/Vector_\(geometric\))를 그 표면에 수직인 단위 벡터와 [내적](https://en.wikipedia.org/wiki/Dot_product)하고, 그 결과가 그 표면의 빛의 강도입니다. 구의 다각형 모델을 상상해보세요 - 표면의 형태를 근사할 수만 있습니다. 모델 전체에 텍스처화된 3채널 비트맵을 사용하면, 더 상세한 법선 벡터 정보를 인코딩할 수 있습니다. 비트맵의 각 채널은 공간 차원(X, Y, Z)에 해당합니다. 이러한 공간 차원은 오브젝트 공간 노멀 맵의 경우 일정한 좌표 시스템에 상대적이거나, 탄젠트 공간 노멀 맵의 경우 부드럽게 변화하는 좌표 시스템(텍스처 좌표에 대한 위치의 도함수를 기반으로)에 상대적입니다. 이것은 특히 고급 조명 기법과 결합하여 모델 표면에 훨씬 더 많은 디테일을 추가합니다.

u, v 텍스처 좌표에 해당하는 단위 법선 벡터가 노멀 맵에 매핑됩니다. 뷰어를 향해 가리키는 벡터(z: 0에서 -1, [왼손 방향](https://en.wikipedia.org/wiki/Orientation_\(vector_space\)))만 존재하는데, 뷰어로부터 멀어지는 기하학의 벡터는 절대 표시되지 않기 때문입니다. 매핑은 다음과 같습니다:

X: -1에서 +1 : 빨강: 0에서 255 Y: -1에서 +1 : 초록: 0에서 255 Z: 0에서 -1 : 파랑: 128에서 255

연한 초록 | 연한 노랑 | 진한 청록색 | 연한 파랑 | 연한 빨강 | 진한 파랑 | 진한 자홍색

- 뷰어를 직접 향하는 법선(0,0,-1)은 (128,128,255)로 매핑됩니다. 따라서 뷰어를 직접 향하는 물체의 부분은 연한 파랑입니다. 노멀 맵에서 가장 흔한 색상입니다.
- 텍스처의 오른쪽 상단 모서리를 가리키는 법선(1,1,0)은 (255,255,128)로 매핑됩니다. 따라서 물체의 오른쪽 상단 모서리는 일반적으로 연한 노랑입니다. 색상 맵의 가장 밝은 부분입니다.
- 텍스처의 오른쪽을 가리키는 법선(1,0,0)은 (255,128,128)로 매핑됩니다. 따라서 물체의 오른쪽 가장자리는 일반적으로 연한 빨강입니다.
- 텍스처의 위쪽을 가리키는 법선(0,1,0)은 (128,255,128)로 매핑됩니다. 따라서 물체의 위쪽 가장자리는 일반적으로 연한 초록입니다.
- 텍스처의 왼쪽을 가리키는 법선(-1,0,0)은 (0,128,128)로 매핑됩니다. 따라서 물체의 왼쪽 가장자리는 일반적으로 진한 청록색입니다.
- 텍스처의 아래쪽을 가리키는 법선(0,-1,0)은 (128,0,128)로 매핑됩니다. 따라서 물체의 아래쪽 가장자리는 일반적으로 진한 자홍색입니다.
- 텍스처의 왼쪽 하단 모서리를 가리키는 법선(-1,-1,0)은 (0,0,128)로 매핑됩니다. 따라서 물체의 왼쪽 하단 모서리는 일반적으로 진한 파랑입니다. 색상 맵의 가장 어두운 부분입니다.

법선이 확산 조명 계산을 위한 [내적](https://en.wikipedia.org/wiki/Dot_product) 계산에 사용될 것이므로, {0, 0, –1}이 {128, 128, 255} 값으로 재매핑되어 노멀 맵에서 보이는 그런 하늘색을 제공한다는 것을 알 수 있습니다(파랑(z) 좌표는 원근(깊이) 좌표이고 RG-xy는 화면상의 평면 좌표입니다). {0.3, 0.4, –0.866}은 ({0.3, 0.4, –0.866}/2+{0.5, 0.5, 0.5})*255={0.15+0.5, 0.2+0.5, -0.433+0.5}*255={0.65, 0.7, 0.067}*255={166, 179, 17} 값으로 재매핑됩니다. z 좌표(파랑 채널)의 부호는 노멀 맵의 법선 벡터를 눈(시점 또는 카메라) 또는 광선 벡터와 일치시키기 위해 반전되어야 합니다. 음의 z 값은 정점이 카메라 뒤가 아니라 카메라 앞에 있다는 것을 의미하므로, 이 규약은 광선 벡터와 법선 벡터가 일치할 때 정확히 표면이 최대 강도로 빛나도록 보장합니다.

## 실시간 렌더링에서의 사용

대화형 노멀 맵 렌더링은 원래 [노스캐롤라이나 대학교 채플힐](https://en.wikipedia.org/wiki/University_of_North_Carolina_at_Chapel_Hill)에서 제작된 [병렬 렌더링](https://en.wikipedia.org/wiki/Parallel_rendering) 머신인 [PixelFlow](https://en.wikipedia.org/wiki/PixelFlow?action=edit&redlink=1)에서만 가능했습니다[출처 필요]. 나중에는 멀티패스 렌더링과 [프레임버퍼](https://en.wikipedia.org/wiki/Framebuffer) 연산을 사용하여 고급 [SGI](https://en.wikipedia.org/wiki/Silicon_Graphics) 워크스테이션에서 또는 팔레트 텍스처를 사용하는 몇 가지 트릭으로 저사양 PC 하드웨어에서 노멀 매핑을 수행할 수 있었습니다. 그러나 개인용 컴퓨터와 게임 콘솔에 [셰이더](https://en.wikipedia.org/wiki/Shader)가 등장하면서, 노멀 매핑은 2000년대 초반에 널리 보급되었으며, 이를 구현한 최초의 게임 중 일부는 [Evolva](https://en.wikipedia.org/wiki/Evolva)(2000), [Giants: Citizen Kabuto](https://en.wikipedia.org/wiki/Giants:_Citizen_Kabuto), [Virtua Fighter 4](https://en.wikipedia.org/wiki/Virtua_Fighter_4)(2001)였습니다. [실시간 렌더링](https://en.wikipedia.org/wiki/Real-time_rendering)에서 노멀 매핑의 인기는 유사한 효과를 생성하는 다른 방법에 비해 처리 요구 사항 대비 좋은 품질 비율 때문입니다. 이러한 효율성의 대부분은 [거리 인덱스 디테일 스케일링](https://en.wikipedia.org/wiki/Level_of_detail_\(computer_graphics\))에 의해 가능해지는데, 이는 주어진 텍스처의 노멀 맵 디테일을 선택적으로 감소시키는 기법([밉맵핑](https://en.wikipedia.org/wiki/Mipmapping) 참조)으로, 더 먼 표면은 덜 복잡한 조명 시뮬레이션을 필요로 한다는 것을 의미합니다. 많은 제작 파이프라인은 고해상도 모델을 [베이킹](https://en.wikipedia.org/wiki/Baking_\(computer_graphics\))하여 노멀 맵으로 증강된 저/중해상도 인게임 모델로 만듭니다.

## 게임 콘솔

기본적인 노멀 매핑은 팔레트 텍스처를 지원하는 모든 하드웨어에서 구현할 수 있습니다. 전문화된 노멀 매핑 하드웨어를 가진 최초의 게임 콘솔은 세가 [드림캐스트](https://en.wikipedia.org/wiki/Dreamcast)였습니다. 그러나 마이크로소프트의 [Xbox](https://en.wikipedia.org/wiki/Xbox_\(console\))가 소매 게임에서 이 효과를 널리 사용한 최초의 콘솔이었습니다. [6세대 콘솔](https://en.wikipedia.org/wiki/Sixth_generation_console) 중[출처 필요], [PlayStation 2](https://en.wikipedia.org/wiki/PlayStation_2)의 [GPU](https://en.wikipedia.org/wiki/PlayStation_2#Technical_specifications)만이 내장 노멀 매핑 지원이 없었지만, PlayStation 2 하드웨어의 벡터 유닛을 사용하여 시뮬레이션할 수 있었습니다. [Xbox 360](https://en.wikipedia.org/wiki/Xbox_360)과 [PlayStation 3](https://en.wikipedia.org/wiki/PlayStation_3)용 게임은 노멀 매핑에 크게 의존했으며, [패럴랙스 매핑](https://en.wikipedia.org/wiki/Parallax_mapping)을 사용한 최초의 게임 콘솔 세대였습니다. [닌텐도 3DS](https://en.wikipedia.org/wiki/Nintendo_3DS)는 [바이오하저드: 레벨레이션스](https://en.wikipedia.org/wiki/Resident_Evil:_Revelations)와 [메탈기어 솔리드 3: 스네이크 이터](https://en.wikipedia.org/wiki/Metal_Gear_Solid_3:_Snake_Eater)로 입증된 것처럼 노멀 매핑을 지원하는 것으로 나타났습니다.

## 참조

1. "LearnOpenGL - Normal Mapping". learnopengl.com. 2024-05-21에 확인함.
2. Blinn. Simulation of Wrinkled Surfaces, Siggraph 1978
3. Krishnamurthy and Levoy, Fitting Smooth Surfaces to Dense Polygon Meshes, SIGGRAPH 1996
4. Cohen et al., Appearance-Preserving Simplification, SIGGRAPH 1998 (PDF)
5. Cignoni et al., A general method for preserving attribute values on simplified meshes, IEEE Visualization 1998 (PDF)
6. Akenine-Möller, Tomas; Haines, Eric; Hoffman, Naty; Pesce, Angelo; Iwanicki, Michał; Hillaire, Sébastien (2018). Real-Time Rendering 4th Edition (4 ed.). Boca Raton, FL, USA: A K Peters/CRC Press. p. 57. ISBN 978-1-13862-700-0. 2024년 8월 2일에 확인함.
7. Mikkelsen, Simulation of Wrinkled Surfaces Revisited, 2008 (PDF)
8. "LearnOpenGL - Normal Mapping". learnopengl.com. 2021-10-19에 확인함.
9. Heidrich and Seidel, Realistic, Hardware-accelerated Shading and Lighting (2005-01-29에 아카이브됨 at the Wayback Machine, SIGGRAPH 1999 (PDF)
10. "Virtua Fighter 4". Sega Retro. 2023-11-30. 2024-03-03에 확인함.
11. "Tecnologías gráficas en los juegos". Meristation (스페인어). 2012-04-18. 2024-03-03에 확인함.

## 외부 링크

위키미디어 공용에 노멀 매핑 관련 미디어가 있습니다.

- Normal Map Tutorial - Dot3 노멀 매핑 뒤의 픽셀당 로직
- NormalMap-Online - 브라우저 내 무료 생성기
- Normal Mapping on sunandblackcat.com
- Blender Normal Mapping
- Normal Mapping with paletted textures - 오래된 OpenGL 확장을 사용
- Normal Map Photography - 디지털 사진을 레이어링하여 수동으로 노멀 맵 생성
- Normal Mapping Explained
- Simple Normal Mapper - 오픈 소스 노멀 맵 생성기

---

