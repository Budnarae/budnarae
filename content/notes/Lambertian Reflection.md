---
tags:
  - graphics
  - translation
---
_Let There Be Light_
_빛이 있으라_

---

[원문](https://en.wikipedia.org/wiki/Lambertian_reflectance)

---

**영문 원문**  
Lambertian reflectance is the property that defines an ideal "matte" or diffusely reflecting surface. The apparent brightness of a Lambertian surface to an observer is the same regardless of the observer's angle of view. More precisely, the reflected radiant intensity obeys Lambert's cosine law, which makes the reflected radiance the same in all directions.  
Lambertian reflectance is named after Johann Heinrich Lambert, who introduced the concept of perfect diffusion in his 1760 book Photometria.

**번역**  
람베르트 반사(Lambertian reflectance)는 이상적인 “무광(matte)” 또는 난반사(diffusely reflecting) 표면을 정의하는 특성입니다. 관찰자에게 보이는 람베르트 표면의 겉보기 밝기(apparent brightness)는 관찰자의 시점 각도에 관계없이 동일합니다. 보다 정확히 말하면, 반사된 복사 강도(reflected radiant intensity)가 람베르트의 코사인 법칙(Lambert's cosine law)을 따르며, 이로 인해 반사 복사휘도(reflected radiance)는 모든 방향에서 동일해집니다.  
람베르트 반사는 요한 하인리히 람베르트(Johann Heinrich Lambert)의 이름을 땄으며, 그는 1760년 저서 _Photometria_에서 완전 확산(perfect diffusion)의 개념을 도입했습니다.

---

**영문 원문**

### Examples

Unfinished wood exhibits roughly Lambertian reflectance, but wood finished with a glossy coat of polyurethane does not, since the glossy coating creates specular highlights. Though not all rough surfaces are Lambertian, this is often a good approximation, and is frequently used when the characteristics of the surface are unknown.  
Spectralon is a material which is designed to exhibit an almost perfect Lambertian reflectance.

**번역**

### 예시

마감 처리가 되지 않은 나무(unfinished wood)는 대략적으로 람베르트 반사를 보이지만, 폴리우레탄 광택 코팅(polyurethane glossy coat)으로 마감된 나무는 그렇지 않습니다. 이는 광택 코팅이 정반사 하이라이트(specular highlights)를 생성하기 때문입니다. 모든 거친 표면이 람베르트 특성을 갖는 것은 아니지만, 이 모델은 종종 좋은 근사치가 되며, 표면의 특성이 알려져 있지 않을 때 자주 사용됩니다.  
스펙트랄론(Spectralon)은 거의 완전한 람베르트 반사를 보이도록 설계된 재료입니다.

---

**영문 원문**

### Use in computer graphics

In computer graphics, Lambertian reflection is often used as a model for diffuse reflection. This technique causes all closed polygons (such as a triangle within a 3D mesh) to reflect light equally in all directions when rendered. The reflection decreases when the surface is tilted away from being perpendicular to the light source, however, because the area is illuminated by a smaller fraction of the incident radiation.  
The reflection is calculated by taking the dot product of the surface's unit normal vector, **N**, and a normalized light‑direction vector, **L**, pointing from the surface to the light source. This number is then multiplied by the color of the surface and the intensity of the light hitting the surface:

  **Bₑ = L · N · C · Iₗ**

where **Bₑ** is the brightness of the diffusely reflected light, **C** is the color and **Iₗ** is the intensity of the incoming light. Because **L · N = |N| |L| cos α = cos α**, where **α** is the angle between the directions of the two vectors, the brightness will be highest if the surface is perpendicular to the light vector, and lowest if the light vector intersects the surface at a grazing angle.  
Lambertian reflection from polished surfaces is typically accompanied by specular reflection (gloss), where the surface luminance is highest when the observer is situated at the perfect reflection direction (i.e. where the direction of the reflected light is a reflection of the direction of the incident light in the surface), and falls off sharply.

**번역**

### 컴퓨터 그래픽스에서의 활용

컴퓨터 그래픽스에서는 람베르트 반사를 난반사(diffuse reflection)의 모델로 자주 사용합니다. 이 방식은 렌더링 시 모든 폐곡선 다각형(closed polygon, 예: 3D 메쉬 내의 삼각형)이 모든 방향으로 빛을 동일하게 반사하는 것처럼 작동하게 합니다. 그러나 표면이 광원(light source)에 수직이 아닌 각도로 기울어져 있을 경우 반사는 줄어드는데, 이는 표면이 입사 복사의 일부만을 받기 때문입니다.  
반사는 표면의 단위 법선 벡터(unit normal vector) **N**과, 표면에서 광원 방향을 가리키는 정규화된 조명 방향 벡터(normalized light‑direction vector) **L**의 내적(dot product)을 계산해서 구합니다. 이 값을 표면의 색상(color) 및 표면에 도달하는 빛의 세기(intensity)와 곱합니다:

  **Bₑ = L · N · C · Iₗ**

여기서 **Bₑ**는 난반사된 빛의 밝기(brightness), **C**는 표면의 색상, **Iₗ**은 입사 광의 세기(intensity)입니다. 왜냐하면 **L · N = |N| |L| cos α = cos α** 이고, 여기서 **α**는 두 벡터 방향 사이의 각도이기 때문에, 표면이 광원 벡터에 수직일 때 밝기는 가장 크고, 광원 벡터가 표면을 비스듬히 비출 때는 가장 작아집니다.  
광택이 있는(polished) 표면에서의 람베르트 반사에는 일반적으로 정반사(specular reflection, 광택 효과(gloss))가 동반됩니다. 이때 표면의 휘도(luminance)는 관찰자가 완벽한 반사 방향(perfect reflection direction, 즉 입사 광선 방향이 표면에서 반사된 방향이 되는 지점)에 있을 때 가장 높고, 그 외 방향에서는 급격히 감소합니다.

---

**영문 원문**

### Other waves

While Lambertian reflectance usually refers to the reflection of light by an object, it can be used to refer to the reflection of any wave. For example, in ultrasound imaging, "rough" tissues are said to exhibit Lambertian reflectance.

**번역**

### 다른 파동

람베르트 반사는 보통 물체에 의한 빛의 반사를 가리키지만, 임의의 파동(wave)의 반사에도 적용될 수 있습니다. 예를 들어 초음파 영상(ultrasound imaging)에서는 “거친(rough)” 조직이 람베르트 반사를 보인다고 말하기도 합니다.

---

