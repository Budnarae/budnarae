---
title: 'Blinn-Phong reflection model'
tags:
  - graphics
  - translation
---

_Let There Be Light_
_빛이 있으라_

---

[원문](https://en.wikipedia.org/wiki/Blinn%E2%80%93Phong_reflection_model)

---

## ✅ 영어 원문

The Blinn–Phong reflection model, also called the modified Phong reflection model, is a modification developed by Jim Blinn to the Phong reflection model in 1977.

Blinn–Phong is a shading model used in OpenGL and Direct3D's fixed-function pipeline (before Direct3D 10 and OpenGL 3.1), and is carried out on each vertex as it passes down the graphics pipeline; pixel values between vertices are interpolated by Gouraud shading by default, rather than the more computationally‑expensive Phong shading.

### Description

In Phong shading, one must continually recalculate the dot product **R · V** between a viewer (V) and the beam from a light-source (L) reflected (R) on a surface.

If, instead, one calculates a halfway vector between the viewer and light‑source vectors,

[  
H = \frac{L + V}{| L + V |}  
]

**R · V** can be replaced with **N · H**, where **N** is the normalized surface normal. In the above equation, **L** and **V** are both normalized vectors, and **H** is a solution to the equation **V = P_H(−L)**, where **P_H** is the Householder matrix that reflects a point in the hyperplane that contains the origin and has the normal **H**.

This dot product represents the cosine of an angle that is half of the angle represented by Phong's dot product if **V**, **L**, **N** and **R** all lie in the same plane. This relation between the angles remains approximately true when the vectors don't lie in the same plane, especially when the angles are small. The angle between **N** and **H** is therefore sometimes called the halfway angle.

Considering that the angle between the halfway vector and the surface normal is likely to be smaller than the angle between **R** and **V** used in Phong’s model (unless the surface is viewed from a very steep angle for which it is likely to be larger), and since Phong is using ((R · V)^{\alpha}), an exponent can be set (\alpha' > \alpha) such that ((N · H)^{\alpha'}) is closer to the former expression.

For front‑lit surfaces (specular reflections on surfaces facing the viewer), (\alpha' = 4,\alpha) will result in specular highlights that very closely match the corresponding Phong reflections. However, while the Phong reflections are always round for a flat surface, the Blinn–Phong reflections become elliptical when the surface is viewed from a steep angle. This can be compared to the case where the sun is reflected in the sea close to the horizon, or where a far away street light is reflected in wet pavement, where the reflection will always be much more extended vertically than horizontally.

Additionally, while it can be seen as an approximation to the Phong model, it produces more accurate models of empirically determined bidirectional reflectance distribution functions than Phong for many types of surfaces.

### Efficiency

Blinn‑Phong will be faster than Phong in the case where the viewer and light are treated to be very remote, such as approaching or at infinity. This is the case for directional lights and orthographic/isometric cameras. In this case, the halfway vector is independent of position and surface curvature simply because the halfway vector is dependent on the direction to viewer's position and the direction to the light's position, which individually converge at this remote distance, hence the halfway vector can be thought of as constant in this case. **H** therefore can be computed once for each light and then used for the entire frame, or indeed while light and viewpoint remain in the same relative position. The same is not true with Phong's method of using the reflection vector which depends on the surface curvature and must be recalculated for each pixel of the image (or for each vertex of the model in the case of vertex lighting). In 3D scenes with perspective cameras, this optimization is not possible.

---

## 🇰🇷 한국어 번역

Blinn–Phong 반사 모델(Blinn–Phong reflection model, 또는 수정된 Phong 반사 모델이라고도 함)은 1977년에 Jim Blinn이 Phong 반사 모델을 개량하여 개발한 모델입니다.

Blinn–Phong은 OpenGL 및 Direct3D의 고정 함수 파이프라인(fixed-function pipeline) (Direct3D 10 이전 및 OpenGL 3.1 이전 버전)에서 사용되는 셰이딩 모델이며, 그래픽 파이프라인을 통과할 때 **각 정점(vertex)** 에 대해 수행됩니다. 정점 사이의 픽셀 값은 기본적으로 Gouraud 셰이딩으로 보간(interpolation)되며, 더 계산 비용이 높은 Phong 셰이딩 방식은 사용되지 않습니다.

---

### 설명

Phong 셰이딩에서, 관찰자 벡터 **V**와 광원으로부터 반사된 광선 **R** 간의 내적 **R · V**를 계속해서 다시 계산해야 합니다.

하지만 대신에, 관찰자 벡터와 광원 벡터 사이의 중간 벡터(halfway vector)를 계산한다면:

[  
H = \frac{L + V}{| L + V |}  
]

**R · V**는 **N · H**로 대체할 수 있습니다. 여기서 **N**은 정규화된 표면 법선(normal)입니다. 위 식에서 **L**과 **V**는 정규화된 벡터이며, **H**는 **V = P_H(−L)** 을 만족하는 해로, **P_H**는 원점을 포함하고 법선 **H**를 가지는 초평면(hyperplane)에 대한 하우스홀더 행렬(Householder matrix)입니다.

이 내적 **N · H**는 만약 **V**, **L**, **N**, **R**이 모두 동일한 평면에 놓일 경우, Phong 모델의 내적이 나타내는 각도의 절반에 해당하는 각도의 코사인을 나타냅니다. 벡터들이 동일 평면상에 있지 않더라도, 특히 각도가 작을 경우 이 관계는 근사적으로 유지됩니다. 따라서 **N**과 **H** 사이의 각도를 “halfway angle(중간 각도)”이라고 부르기도 합니다.

광원과 관찰자가 멀리 떨어져 있을 경우 (무한대에 가깝게 여길 경우)에는 중간 벡터와 표면 법선 사이의 각도가 **R**과 **V** 사이의 각도보다 작을 가능성이 높습니다 (물론 매우 가파른 각도에서 보면 반대가 될 수도 있겠죠). Phong 모델은 ((R · V)^{\alpha})를 사용하므로, ((N · H)^{\alpha'}) 꼴의 표현을 사용하면서 (\alpha' > \alpha)로 설정하면 이전 식과 더 유사하게 맞출 수 있습니다.

정면 조명(front-lit) 표면 (즉, 관찰자를 향한 표면)의 경우, (\alpha' = 4\alpha)로 설정하면 대응하는 Phong 반사와 매우 유사한 specular 하이라이트가 생성됩니다. 다만, Phong 반사는 평면 상에서는 항상 원형의 하이라이트를 만드는 반면, Blinn–Phong 반사는 표면을 가파른 각도에서 볼 때 타원형 하이라이트가 됩니다. 이는 해 질 무렵 바다에 반사된 태양, 또는 젖은 도로 위에 멀리 있는 가로등 반사 같은 경우를 생각해 보면, 반사가 수직 방향보다 수평 방향으로 더 길게 늘어나는 현상을 설명합니다.

또한, Blinn–Phong은 Phong 모델의 근사 버전으로 볼 수 있지만, 여러 종류의 표면에 대해 실험적으로 측정된 쌍방향 반사 분포 함수(BRDF)를 모델링할 때 Phong보다 더 정확한 결과를 내기도 합니다.

---

### 효율성 (Performance 관점)

광원과 관찰자가 매우 멀리 떨어져 있다고 가정하는 경우 (예: 방향성 조명, 직교 또는 등축 카메라)에는 Blinn–Phong이 Phong보다 빠릅니다. 이 경우 중간 벡터 **H**는 위치나 표면 곡률(curvature)에 무관하게, 관찰자 방향 벡터와 광원 방향 벡터가 거의 일정하므로 상수처럼 취급할 수 있습니다. 따라서 **H**는 **광원마다 한 번만 계산**해 놓고 **프레임 전체 또는 조명/관찰자 위치가 변하지 않는 동안 재사용**할 수 있습니다. 반면 Phong의 반사 벡터 방식은 표면 곡률에 따라 달라지므로 매 픽셀마다(또는 정점마다) 다시 계산해야 합니다. 다만 **투영 카메라**가 적용된 3D 장면에서는 이 최적화가 불가능해집니다.


