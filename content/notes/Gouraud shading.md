---
tags:
  - graphics
  - translation
---

_Let There Be Light_
_빛이 있으라_

---

[원문](https://en.wikipedia.org/wiki/Gouraud_shading)

___

Gouraud shading ( /ɡuːˈroʊ/ goo‑ROH ), named after Henri Gouraud, is an interpolation method used in computer graphics to produce continuous shading of surfaces represented by polygon meshes. In practice, Gouraud shading is most often used to achieve continuous lighting on triangle meshes by computing the lighting at the corners of each triangle and linearly interpolating the resulting colours for each pixel covered by the triangle.

구로우 쉐이딩(Gouraud shading, /ɡuːˈroʊ/ “구‑로우”라고 발음함)은 헨리 구로우(Henri Gouraud)의 이름을 딴 보간 기법으로, 다각형 메쉬(polygon mesh)로 표현된 표면에 연속적인 셰이딩을 생성하는 데 사용됩니다. 실제로 구로우 셰이딩은 삼각형 메쉬(triangle mesh)에 주로 적용되며, 각 삼각형의 꼭짓점(corner)들에서 조명을 계산하고, 그 결과 얻은 색상을 삼각형에 덮이는 각 픽셀(pixel)에 대해 선형 보간(linear interpolation)하는 방식으로 연속적인 조명을 구현합니다.

Gouraud first published the technique in 1971. However, enhanced hardware support for superior shading models has yielded Gouraud shading largely obsolete in modern rendering.  

구로우는 이 기법을 1971년에 처음 발표했습니다. 그러나 향상된 하드웨어 지원 덕분에 더 우수한 셰이딩 모델이 가능해지면서, 구로우 셰이딩은 현대 렌더링에서는 대체로 구식이 되었습니다.

---

## Description

Gouraud shading works as follows: An estimate to the surface normal of each vertex in a polygonal 3D model is either specified for each vertex or found by averaging the surface normals of the polygons that meet at each vertex. Using these estimates, lighting computations based on a reflection model, e.g. the Phong reflection model, are then performed to produce colour intensities at the vertices.  

구로우 셰이딩은 다음과 같이 작동합니다. 다각형 3D 모델의 각 정점(vertex)에 대한 표면 법선(surface normal)의 추정값이 정점별로 지정되거나, 정점에 모이는 다각형들의 표면 법선의 평균을 통해 구해집니다. 이 추정된 법선 값을 이용하여 반사 모델(reflection model), 예컨대 퐁 반사 모델(Phong reflection model) 등을 기반으로 조명 계산을 수행하고, 그 결과 정점에서의 색상 강도(color intensity)를 산출합니다.

For each screen pixel that is covered by the polygonal mesh, colour intensities can then be interpolated from the colour values calculated at the vertices.  

다각형 메쉬가 덮는 각 화면 픽셀(screen pixel)마다, 정점에서 계산된 색상 값들로부터 그 픽셀의 색상 강도를 보간(interpolate)해서 결정할 수 있습니다.

---

## Comparison with other shading techniques

Gouraud shading is considered superior to flat shading and requires significantly less processing than Phong shading, but usually results in a faceted look.  

**다른 셰이딩 기법과의 비교**  

구로우 셰이딩은 플랫 셰이딩(flat shading)보다 우수하다고 여겨지며, 퐁 셰이딩(Phong shading)보다 훨씬 적은 연산이 필요합니다. 그러나 보통 면이 드러나는 듯한(faceted) 외관을 초래하는 경향이 있습니다.

In comparison to Phong shading, Gouraud shading's strength and weakness lies in its interpolation. If a mesh covers more pixels in screen space than it has vertices, interpolating colour values from samples of expensive lighting calculations at vertices is less processor intensive than performing the lighting calculation for each pixel as in Phong shading. However, highly localized lighting effects (such as specular highlights, e.g. the glint of reflected light on the surface of an apple) will not be rendered correctly, and if a highlight lies in the middle of a polygon, but does not spread to the polygon's vertex, it will not be apparent in a Gouraud rendering; conversely, if a highlight occurs at the vertex of a polygon, it will be rendered correctly at this vertex (as this is where the lighting model is applied), but will be spread unnaturally across all neighboring polygons via the interpolation method.  

퐁 셰이딩과 비교할 때, 구로우 셰이딩의 장점과 단점은 보간(interpolation)에 있습니다. 화면 공간(screen space)상에서 메쉬가 많은 픽셀을 덮고 있지만 정점의 수는 적을 경우, 정점에서 수행한 비용이 큰 조명 계산 결과를 픽셀마다 보간하는 방식이 퐁 셰이딩처럼 각 픽셀마다 조명 계산을 수행하는 것보다 연산 부담이 덜합니다. 그러나 매우 국지적인 조명 효과들(예: 반짝임(specular highlights), 예컨대 사과 표면에 반사된 빛의 반짝임)은 올바르게 렌더링되지 못하며, 만약 하이라이트(highlight)가 다각형의 중간(midpoint)에 위치해 있지만 정점까지 퍼지지 않는다면 구로우 렌더링에서는 보이지 않을 수 있습니다. 반대로 하이라이트가 다각형의 정점(vertex)에서 발생한다면, 이 정점에서는 조명 모델이 적용되므로 올바르게 렌더링되지만, 보간 방식에 의해 인접한 모든 다각형에 걸쳐 부자연스럽게 퍼질 수 있습니다.

The problem is easily spotted in a rendering which ought to have a specular highlight moving smoothly across the surface of a model as it rotates. Gouraud shading will instead produce a highlight continuously fading in and out across neighboring portions of the model, peaking in intensity when the intended specular highlight aligns with a vertex of the model.  

이 문제는, 모델이 회전하면서 표면을 따라 부드럽게 이동해야 할 반짝임이 있을 때 쉽게 확인됩니다. 구로우 셰이딩에서는 대신 하이라이트가 모델의 인접 부분들 사이를 연속적으로 사라졌다 나타났다 하며, 본래의 반짝임이 정점에 정렬될 때 그 정점에서 강하게 나타나게 됩니다.

While this problem can be fixed by increasing the density of vertices in the object, at some point the diminishing returns of this approach will favour switching to a more detailed shading model.  

이 문제는 객체의 정점 밀도를 높이는 방식으로 어느 정도 해결할 수 있지만, 어느 정도 이상 증가시키면 수익 감소(diminishing returns)가 발생하여 더 정밀한 셰이딩 모델로 전환하는 것이 유리해집니다.

---

## Linear vs. hyperbolic interpolation

Gouraud's original paper described linear color interpolation. In 1992, Blinn published an efficient algorithm for hyperbolic interpolation that is used in GPUs as a perspective correct alternative to linear interpolation. Both the linear and hyperbolic variants of interpolation of colors from vertices to pixels are commonly called "Gouraud shading".  

**선형 대 쌍곡선 보간**

구로우의 원 논문에서는 선형 색상 보간(linear color interpolation)을 설명했습니다. 1992년에 블린(Blinn)은 쌍곡선 보간(hyperbolic interpolation)에 대한 효율적인 알고리즘을 발표했으며, 이 방식은 GPU에서 선형 보간을 대체하는 원근 비례 보정(perspective correct) 방식으로 사용됩니다. 정점에서 픽셀로의 색상 보간 방식인 선형 보간 및 쌍곡선 보간 변형 모두가 일반적으로 “구로우 셰이딩”이라 불립니다.

---

## Mach bands

Any linear interpolation of intensity causes derivative discontinuities which triggers Mach bands, a common visual artifact of Gouraud shading.  

**마하 밴드(Mach bands)**  

강도(intensity)를 선형 보간할 경우, 도함수의 불연속성(discontinuities in derivative)이 발생하여 마하 밴드(Mach bands)를 유발합니다. 이는 구로우 셰이딩에서 흔한 시각적 인공 효과(artifact)입니다.

---

