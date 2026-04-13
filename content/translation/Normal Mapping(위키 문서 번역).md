---
title: 'Normal Mapping(위키 문서 번역)'
tags:
  - graphics
  - translation
---

---

## ✅ 영문 원문

Normal mapping  
Texture mapping technique

In 3D computer graphics, normal mapping, or Dot3 bump mapping, is a texture mapping technique used for faking the lighting of bumps and dents – an implementation of bump mapping. It is used to add details without using more polygons. A common use of this technique is to greatly enhance the appearance and details of a low polygon model by generating a normal map from a high polygon model or height map.

Normal maps are commonly stored as regular RGB images where the RGB components correspond to the X, Y, and Z coordinates, respectively, of the surface normal.

---

### History

In 1978 Jim Blinn described how the normals of a surface could be perturbed to make geometrically flat faces have a detailed appearance.  
The idea of taking geometric details from a high polygon model was introduced in “Fitting Smooth Surfaces to Dense Polygon Meshes” by Krishnamurthy and Levoy, Proc.

---

### Calculating tangent spaces

Surface normals are used in computer graphics primarily for the purposes of lighting, through mimicking a phenomenon called specular reflection. Since the visible image of an object is the light bouncing off of its surface, the light information obtained from each point of the surface can instead be computed on its tangent space at that point.  
For each tangent space of a surface in three‑dimensional space, there are two vectors which are perpendicular to every vector of the tangent space. These vectors are called normal vectors, and choosing between these two vectors provides a description on how the surface is oriented at that point, as the light information depends on the angle of incidence between the ray **r** and the normal vector **n**, and the light will only be visible if **r · n > 0**. In such a case, the reflection **s** of the ray with direction **r** along the normal vector **n** is given by  
Examples of such transforms include transformation, rotation, shearing and scaling, perspective projection, or the skeletal animations on a finely detailed character.

For the purposes of computer graphics, the most common representation of a surface is a triangulation, and as a result, the tangent plane at a point can be obtained through interpolating between the planes that contain the triangles that each intersect that point. Similarly, for parametric surfaces with tangent spaces, the parametrizations will yield partial derivatives, and these derivatives can be used as a basis of the tangent spaces at every point.

In order to find the perturbation in the normal the tangent space must be correctly calculated. Most often the normal is perturbed in a fragment shader after applying the model and view matrices[citation needed]. Typically the geometry provides a normal and tangent. The tangent is part of the tangent plane and can be transformed simply with the linear part of the matrix (the upper 3×3). However, the normal needs to be transformed by the inverse transpose. Most applications will want bitangent to match the transformed geometry (and associated UVs). So instead of enforcing the bitangent to be perpendicular to the tangent, it is generally preferable to transform the bitangent just like the tangent. Let **t** be tangent, **b** be bitangent, **n** be normal, **M** be the linear part of the 3×3 model matrix, and **V** be the linear part of the 3×3 view matrix.

[  
\mathbf{t}' = \mathbf{V}\mathbf{M}\mathbf{t} \  
\mathbf{b}' = \mathbf{V}\mathbf{M}\mathbf{b} \  
\mathbf{n}' = ((\mathbf{V}\mathbf{M})^{-1})^T\mathbf{n} = (\mathbf{M}^{-1}\mathbf{V}^{-1})^T \mathbf{n} = (\mathbf{V}^{-1})^T(\mathbf{M}^{-1})^T \mathbf{n}  
]

---

### Calculation

To calculate the Lambertian (diffuse) lighting of a surface, the unit vector from the shading point to the light source is dotted with the unit vector normal to that surface, and the result is the intensity of the light on that surface. Imagine a polygonal model of a sphere — you can only approximate the shape of the surface. By using a 3‑channel bitmap textured across the model, more detailed normal vector information can be encoded. Each channel in the bitmap corresponds to a spatial dimension (X, Y and Z). These spatial dimensions are relative to a constant coordinate system for object-space normal maps, or to a smoothly varying coordinate system (based on the derivatives of position with respect to texture coordinates) in the case of tangent-space normal maps. This adds much more detail to the surface of a model, especially in conjunction with advanced lighting techniques.

Unit Normal vectors corresponding to the u, v texture coordinate are mapped onto normal maps. Only vectors pointing towards the viewer (z: 0 to –1 for Left Handed Orientation) are present, since the vectors on geometries pointing away from the viewer are never shown. The mapping is as follows:

- X: –1 to +1 : Red: 0 to 255
    
- Y: –1 to +1 : Green: 0 to 255
    
- Z: 0 to –1 : Blue: 128 to 255
    
- A normal pointing directly towards the viewer (0,0,–1) is mapped to (128,128,255). Hence the parts of object directly facing the viewer are light blue. The most common color in a normal map.
    
- A normal pointing to top-right corner of the texture (1,1,0) is mapped to (255,255,128). Hence the top-right corner of an object is usually light yellow. The brightest part of a color map.
    
- A normal pointing to right of the texture (1,0,0) is mapped to (255,128,128). Hence the right edge of an object is usually light red.
    
- A normal pointing to top of the texture (0,1,0) is mapped to (128,255,128). Hence the top edge of an object is usually light green.
    
- A normal pointing to left of the texture (–1,0,0) is mapped to (0,128,128). Hence the left edge of an object is usually dark cyan.
    
- A normal pointing to bottom of the texture (0,–1,0) is mapped to (128,0,128). Hence the bottom edge of an object is usually dark magenta.
    
- A normal pointing to bottom-left corner of the texture (–1,–1,0) is mapped to (0,0,128). Hence the bottom-left corner of an object is usually dark blue. The darkest part of a color map.
    

Since a normal will be used in the dot product calculation for the diffuse lighting computation, we can see that the {0, 0, –1} would be remapped to the {128, 128, 255} values, giving that kind of sky blue color seen in normal maps (blue (z) coordinate is perspective (deepness) coordinate and RG-xy flat coordinates on screen). {0.3, 0.4, –0.866} would be remapped to the ({0.3, 0.4, –0.866}/2 + {0.5, 0.5, 0.5}) * 255 = {0.15 + 0.5, 0.2 + 0.5, –0.433 + 0.5} * 255 = {0.65, 0.7, 0.067} * 255 = {166, 179, 17} values (0.3² + 0.4² + (–0.866)² = 1). The sign of the z-coordinate (blue channel) must be flipped to match the normal map's normal vector with that of the eye (the viewpoint or camera) or the light vector. Since negative z values mean that the vertex is in front of the camera (rather than behind the camera) this convention guarantees that the surface shines with maximum strength precisely when the light vector and normal vector are coincident.

---

### Normal mapping in video games

Interactive normal map rendering was originally only possible on PixelFlow, a parallel rendering machine built at the University of North Carolina at Chapel Hill.[citation needed] It was later possible to perform normal mapping on high-end SGI workstations using multi-pass rendering and framebuffer operations or on low end PC hardware with some tricks using paletted textures. However, with the advent of shaders in personal computers and game consoles, normal mapping became widespread in the early 2000s, with some of the first games to implement it being Evolva (2000), Giants: Citizen Kabuto, and Virtua Fighter 4 (2001). Normal mapping's popularity for real-time rendering is due to its good quality to processing requirements ratio versus other methods of producing similar effects. Much of this efficiency is made possible by distance-indexed detail scaling, a technique which selectively decreases the detail of the normal map of a given texture (cf. mipmapping), meaning that more distant surfaces require less complex lighting simulation. Many authoring pipelines use high resolution models baked into low/medium resolution in-game models augmented with normal maps.

Basic normal mapping can be implemented in any hardware that supports palettized textures. The first game console to have specialized normal mapping hardware was the Sega Dreamcast. However, Microsoft’s Xbox was the first console to widely use the effect in retail games. Out of the sixth generation consoles, only the PlayStation 2’s GPU lacks built‑in normal mapping support, though it can be simulated using the PlayStation 2 hardware’s vector units. Games for the Xbox 360 and the PlayStation 3 rely heavily on normal mapping and were the first game console generation to make use of parallax mapping. The Nintendo 3DS has been shown to support normal mapping, as demonstrated by Resident Evil: Revelations and Metal Gear Solid 3: Snake Eater.

---

## 🇰🇷 한국어 번역 (원문 충실)

노멀 매핑  
텍스처 매핑 기법

3D 컴퓨터 그래픽스에서, 노멀 매핑(normal mapping) 또는 Dot3 범프 매핑(Dot3 bump mapping)은 범프 매핑(bump mapping)의 하나의 구현으로, 범프와 요철(bumps and dents)의 조명을 속이는(faking) 데 사용되는 텍스처 매핑 기술입니다. 더 많은 폴리곤을 사용하지 않고도 디테일을 추가하는 데 사용됩니다. 이 기법의 일반적인 사용 예는 **고폴리곤 모델이나 높이 맵(height map)** 으로부터 노멀 맵을 생성하여, 낮은 폴리곤 모델의 외형과 디테일을 크게 향상시키는 것입니다.

노멀 맵(normal maps)은 일반적으로 RGB 이미지로 저장되며, 그 RGB 성분들은 각각 표면 법선(surface normal)의 X, Y, Z 좌표에 대응합니다.

---

### 역사

1978년 Jim Blinn은 표면의 법선을 변형시켜 기하학적으로 평면인 면이 상세한 외형을 갖도록 만드는 방법을 기술했습니다.  
고폴리곤 모델의 기하학적 디테일을 가져오는 아이디어는 Krishnamurthy와 Levoy의 “Fitting Smooth Surfaces to Dense Polygon Meshes” (Proc.) 논문에서 소개되었습니다.

---

### 탄젠트 공간 계산 (Calculating tangent spaces)

표면 법선(surface normals)은 컴퓨터 그래픽에서 주로 조명(lighting) 목적으로 사용되며, 스페큘러 반사(specular reflection)라는 현상을 모방하는 데 관여합니다. 객체의 보이는 이미지는 표면에서 반사된 빛이므로, 표면의 각 지점에서 얻은 빛 정보는 그 지점의 **탄젠트 공간(tangent space)** 에서 계산될 수 있습니다.  
3차원 공간에서 표면의 각 탄젠트 공간(tangent space)에는, 그 탄젠트 공간의 모든 벡터에 수직인 두 벡터가 존재합니다. 이러한 벡터들을 법선 벡터(normal vectors)라 부르며, 이들 중 하나를 선택하는 것은 해당 지점에서 표면이 어떻게 방향을 갖는지를 표현합니다. 조명 정보는 광선 **r** 와 법선 벡터 **n** 사이의 입사각(angle of incidence)에 의존하며, **r · n > 0** 일 때만 빛이 보입니다. 이 경우, 방향이 **r**인 광선이 법선 벡터 **n**을 따라 반사될 때의 반사 벡터 **s**는 주어진 법선 벡터 **n**에 대해 정의됩니다.  
이러한 변환의 예로는 변환(transform), 회전(rotation), 전단(shearing) 및 스케일링(scaling), 원근 투영(perspective projection), 또는 정밀하게 디테일한 캐릭터의 스켈레탈 애니메이션(skeletal animations)이 있습니다.

컴퓨터 그래픽의 목적상, 표면은 삼각분할(triangulation)로 표현되는 경우가 가장 흔하여, 그 결과 한 지점의 탄젠트 평면(tangent plane)은 그 지점을 지나는 삼각형들을 포함하는 평면들 사이의 보간(interpolating)으로 얻을 수 있습니다. 마찬가지로, 매개변수형(parametric) 표면의 경우 탄젠트 공간이 존재하며, 매개변수화를 통해 부분 도함수(partial derivatives)가 유도되고, 이 도함수들이 각 지점의 탄젠트 공간의 기저(basis)로 사용될 수 있습니다.

법선의 변형(perturbation)을 찾기 위해서는 탄젠트 공간을 정확히 계산해야 합니다. 대개 법선은 모델 및 뷰 행렬(model and view matrices)을 적용한 후 프래그먼트 셰이더(fragment shader)에서 변형됩니다. 일반적으로 기하(geometry)는 법선(normal)과 탄젠트(tangent)를 제공합니다. 탄젠트 벡터는 탄젠트 평면의 일부이며, 행렬의 선형 부분(상위 3×3 부분)만으로 단순히 변환될 수 있습니다. 그러나 법선은 역전치 행렬(inverse transpose)로 변환되어야 합니다. 대부분의 응용에서는 비탄젠트(bitangent)가 변환된 기하 및 연관된 UV와 일치하기를 원하기 때문에, 비탄젠트를 탄젠트와 수직이 되게 강제하기보다는 탄젠트와 같은 방식으로 변환하는 것이 일반적으로 바람직합니다.  
탄젠트 벡터를 **t**, 비탄젠트 벡터를 **b**, 법선을 **n**, 모델 행렬의 선형 부분을 **M**, 뷰 행렬의 선형 부분을 **V**라고 하면:

[  
\mathbf{t}' = \mathbf{V}, \mathbf{M}, \mathbf{t} \  
\mathbf{b}' = \mathbf{V}, \mathbf{M}, \mathbf{b} \  
\mathbf{n}' = \bigl((\mathbf{V},\mathbf{M})^{-1}\bigr)^T \mathbf{n} = (\mathbf{M}^{-1},\mathbf{V}^{-1})^T \mathbf{n} = (\mathbf{V}^{-1})^T,(\mathbf{M}^{-1})^T , \mathbf{n}  
]

---

### 계산 (Calculation)

표면의 램버트(Lambertian, diffuse) 조명을 계산하려면, 셰이딩 지점(shading point)에서 광원(light source)으로 향하는 단위 벡터(unit vector)와 그 표면의 법선 벡터의 단위 벡터 사이의 내적(dot product)을 취하고, 그 결과가 그 표면에 대한 빛의 세기(intensity)가 됩니다. 구형 모델(polygonal model of a sphere)을 가정해 보면, 당신은 표면의 실제 모양을 근사만 할 수 있습니다. 모델 전반에 걸쳐 3채널 비트맵(bitmap)을 텍스처로 사용함으로써 보다 상세한 법선 벡터 정보를 인코딩할 수 있습니다. 이 비트맵의 각 채널은 공간 축(spatial dimension)인 X, Y, Z에 대응합니다. 이러한 공간 축들은 객체 공간(object-space) 노멀 맵인 경우에는 일정한 좌표계(constant coordinate system)에 상대적이며, 탄젠트 공간 노멀 맵(tangent-space normal map)의 경우에는 텍스처 좌표(texture coordinates)에 대한 위치(position)의 도함수(derivatives)에 기반한 매끄럽게 변화하는 좌표계에 상대적입니다. 이는 특히 고급 조명 기법들과 함께 쓰일 때 모델의 표면에 훨씬 더 많은 디테일을 부여합니다.

u, v 텍스처 좌표에 대응하는 단위 법선 벡터(unit normal vectors)가 노멀 맵에 매핑됩니다. 뷰어(viewer) 쪽을 향하는 벡터(z: 0에서 –1, 좌수형(Left Handed) 좌표계의 경우)만 존재하며, 뷰어 쪽을 향하지 않는 벡터는 표시되지 않습니다. 매핑 방식은 다음과 같습니다:

- X: –1 ~ +1 → Red: 0 ~ 255
    
- Y: –1 ~ +1 → Green: 0 ~ 255
    
- Z: 0 ~ –1 → Blue: 128 ~ 255
    
- (0, 0, –1)인 법선 벡터는 (128, 128, 255)로 매핑됩니다. 따라서 카메라 정면을 향한 객체 부분이 연‑하늘색(light blue)으로 나타납니다. 노멀 맵에서 가장 일반적인 색입니다.
    
- 텍스처의 우상단(top-right) 방향 법선 벡터 (1, 1, 0)은 (255, 255, 128)로 매핑됩니다. 따라서 객체의 우상단 코너는 보통 연노랑(light yellow)입니다.
    
- 우쪽 방향 법선 벡터 (1, 0, 0)은 (255, 128, 128)로 매핑됩니다. 따라서 객체의 오른쪽 가장자리는 보통 연적색(light red)입니다.
    
- 위쪽 방향 법선 벡터 (0, 1, 0)은 (128, 255, 128)로 매핑됩니다. 따라서 객체의 윗부분 가장자리는 보통 연녹색(light green)입니다.
    
- 왼쪽 방향 법선 벡터 (–1, 0, 0)은 (0, 128, 128)로 매핑됩니다. 따라서 객체의 왼쪽 가장자리는 보통 다크 시안(dark cyan)입니다.
    
- 아래쪽 방향 법선 벡터 (0, –1, 0)은 (128, 0, 128)로 매핑됩니다. 따라서 객체의 아랫부분 가장자리는 보통 다크 마젠타(dark magenta)입니다.
    
- 텍스처의 좌하단(bottom-left) 방향 법선 벡터 (–1, –1, 0)은 (0, 0, 128)로 매핑됩니다. 따라서 객체의 좌하단 코너는 보통 짙은 파랑(dark blue)입니다. 노멀 맵에서 가장 어두운 부분입니다.
    

노멀이 확산 조명(diffuse lighting) 계산을 위한 내적(dot product) 계산에 사용되므로, {0, 0, –1}은 {128, 128, 255}로 리매핑되어 노멀 맵의 하늘‑파란(sky blue) 색조를 만들어냅니다 (파랑(blue, z) 성분은 원근(perspective, 깊이) 좌표이고, RG‑xy 성분은 화면 상의 평면 좌표입니다). {0.3, 0.4, –0.866}은 ({0.3, 0.4, –0.866}/2 + {0.5, 0.5, 0.5}) × 255 = {0.15+0.5, 0.2+0.5, –0.433+0.5} × 255 = {0.65, 0.7, 0.067} × 255 = {166, 179, 17} 값으로 리매핑됩니다 (0.3² + 0.4² + (–0.866)² = 1). z 성분(파랑 채널)의 부호(sign)는 노멀 맵의 법선 벡터와 뷰어(viewpoint) 또는 광원(light vector)의 법선 벡터를 맞추기 위해 뒤집어야 할 수도 있습니다. 음수 z 값은 정점이 카메라 앞(front of camera)에 있음을 의미하므로, 이 규약은 광선 벡터와 법선 벡터가 일치할 때 표면이 최대 밝기를 갖도록 보장합니다.

---

### 비디오 게임 내 노멀 매핑 (Normal mapping in video games)

인터랙티브한 노멀 맵 렌더링(interactive normal map rendering)은 원래 노스캐롤라이나 대학교 채플힐(University of North Carolina at Chapel Hill)의 병렬 렌더링 기계 PixelFlow 에서만 가능했습니다. 그 후 고급 SGI 워크스테이션(SGI workstations)에서 다중 패스 렌더링(multi-pass rendering) 및 프레임버퍼(framebuffer) 연산을 통해 구현되었고, 저성능 PC 하드웨어에서도 팔레트 텍스처(paletted textures) 등의 트릭을 사용해 구현되었습니다. 하지만 개인용 컴퓨터와 게임 콘솔에 셰이더(shaders)가 도입된 이후, 노멀 매핑은 2000년대 초부터 널리 사용되기 시작했습니다. 최초로 이를 구현한 게임들로는 _Evolva_ (2000), _Giants: Citizen Kabuto_, _Virtua Fighter 4_ (2001) 등이 있습니다. 노멀 매핑이 실시간 렌더링(real-time rendering)에서 널리 쓰이는 이유는, 비슷한 효과를 내는 다른 기법들에 비해 **품질 대비 연산 비용 효율이 좋기 때문**입니다. 이 효율성의 많은 부분은 거리 기반 디테일 축소(distance‑indexed detail scaling)라는 기법 덕분인데, 이는 주어진 텍스처의 노멀 맵 디테일을 선택적으로 감소시키는 방식(밉맵(mipmapping) 참고)으로, 더 멀리 있는 표면은 덜 복잡한 조명 시뮬레이션을 요구하게 합니다. 많은 제작 파이프라인(authoring pipelines)은 고해상도 모델(high resolution models)을 낮거나 중간 해상도의 인게임 모델(low/medium resolution in-game models)에 베이크(bake)한 후, 노멀 맵을 추가하는 방식을 사용합니다.

기본 노멀 매핑(basic normal mapping)은 팔레트 텍스처(palettized textures)를 지원하는 어느 하드웨어에서도 구현할 수 있습니다. 노멀 매핑을 전문적으로 지원하는 첫 콘솔 게임 하드웨어는 Sega Dreamcast였지만, Microsoft의 Xbox가 상업용 게임에서 이 효과를 널리 쓴 첫 콘솔이었습니다. 6세대(6th generation) 콘솔 중에서 단지 PlayStation 2의 GPU만이 노멀 매핑을 내장 지원하지 않지만, PlayStation 2 하드웨어의 벡터 유닛(vector units)을 사용해 시뮬레이션할 수 있습니다. Xbox 360 및 PlayStation 3용 게임들은 노멀 매핑을 많이 활용했으며, 이 콘솔 세대는 또한 파라랙스 매핑(parallax mapping)을 처음 활용한 콘솔 세대이기도 합니다. Nintendo 3DS도 노멀 매핑을 지원하는 것으로 보이며, _Resident Evil: Revelations_ 및 _Metal Gear Solid 3: Snake Eater_ 등의 게임에서 이를 사용한 예가 있습니다.

---

필요하시면 이 번역을 바탕으로 요약 + 해설, 또는 언리얼/셰이더 관점에서의 적용 방식도 같이 설명드릴까요?

