---
title: 'GPU Gem 3 Cascade Shadow 문서 번역'
tags:
  - graphics
  - translation
---

__

---
# Chapter 10. 프로그래머블 GPU에서의 병렬 분할 섀도우 맵

**Fan Zhang**  
홍콩 중문대학교

**Hanqiu Sun**  
홍콩 중문대학교

**Oskari Nyman**  
헬싱키 공과대학교

### **서두**

섀도우 매핑(Williams 1978)은 3D 게임과 애플리케이션에서 섀도잉 효과를 만들어내기 위해 광범위하게 사용되어 왔습니다. 그러나 섀도우 매핑은 고유한 앨리어싱 문제를 가지고 있으므로, 표준 섀도우 매핑을 사용하는 것만으로는 복잡하고 대규모 장면에서 고품질 섀도우 렌더링을 생성하기에 충분하지 않습니다. 이 장에서 우리는 대규모 환경을 위해 안티앨리어스되고 실시간 섀도우를 생성하는 고급 섀도우 매핑 기법을 제시합니다. 또한 현대 프로그래머블 GPU에서 우리 기법의 구현 세부사항을 보여줍니다.

우리가 제시하는 기법은 병렬 분할 섀도우 맵(Parallel-Split Shadow Maps, PSSMs)(Zhang et al. 2007 및 Zhang et al. 2006)이라고 불립니다. 이 기법에서 뷰 프러스텀은 뷰 평면에 평행한 클립 평면을 사용하여 여러 깊이 레이어로 분할되며, 각 레이어에 대해 독립적인 섀도우 맵이 렌더링됩니다(Figure 10-1 참조).

**Figure 10-1 병렬 분할 섀도우 맵**

분할 방식은 뷰어로부터 다른 거리에 있는 점들이 다른 섀도우 맵 샘플링 밀도를 필요로 한다는 관찰에서 동기를 얻습니다. 뷰 프러스텀을 여러 부분으로 분할함으로써, 각 섀도우 맵이 더 작은 영역을 샘플링할 수 있도록 하여 텍스처 공간에서 샘플링 주파수가 증가하게 됩니다. 뷰 공간과 텍스처 공간에서 샘플링 주파수를 더 잘 일치시킴으로써, 섀도우 앨리어싱 오류가 크게 감소합니다.

원근 섀도우 맵(Perspective Shadow Maps, PSMs)(Stamminger and Drettakis 2002), 광원 공간 원근 섀도우 맵(Light-Space Perspective Shadow Maps, LiSPSMs)(Wimmer et al. 2004), 사다리꼴 섀도우 맵(Trapezoidal Shadow Maps, TSMs)(Martin and Tan 2004)과 같은 다른 인기 있는 섀도우 매핑 기법들과 비교하여, PSSMs는 섀도우 맵 텍셀의 왜곡된 분포를 이산적으로 근사하는 직관적인 방법을 제공하지만, 매핑 특이점과 특별한 처리는 없습니다.

여러 개의 섀도우 맵을 사용하는 아이디어는 Tadamura et al. 2001에서 소개되었습니다. 이는 Lloyd et al. 2006에서 더욱 연구되었고, Futuremark의 벤치마크 애플리케이션 3DMark 2006에서 캐스케이드 섀도우 매핑으로 구현되었습니다.

PSSMs를 포함한 이러한 모든 알고리즘의 두 가지 주요 문제는 다음과 같습니다:

- **뷰 프러스텀을 분할하는 방법.** 다시 말해, 분할 평면 위치를 결정하는 방법.
- **렌더링 성능.** 여러 섀도우 맵을 생성하고 여러 섀도우 맵을 샘플링하는 것은 단일 섀도우 맵 방법보다 비용이 더 많이 듭니다.

이 두 가지 문제는 PSSMs에서 잘 처리됩니다. 우리는 빠르고 견고한 장면 독립적 분할 전략을 사용하여 뷰 기반 해상도 요구사항에 적응하며, DirectX 9 레벨 및 DirectX 10 레벨 하드웨어를 활용하여 성능을 향상시키는 방법을 보여줍니다.

이 장에서는 명확성을 위해 방향성 광원을 사용하여 PSSMs 기법을 설명하지만, 구현 세부사항은 포인트 라이트에도 유효합니다. PSSM(m, res) 표기법은 뷰 프러스텀을 m개의 부분으로 분할하는 분할 방식을 나타냅니다. res는 각 섀도우 맵의 해상도입니다. Figure 10-2는 오버헤드 광원을 사용한 분할 방식의 일반적인 구성을 보여주며, 여기서 뷰 프러스텀 V는 z축을 따라 ${C_i \mid 0 \leq i \leq m}$에 있는 클립 평면을 사용하여 ${V_i \mid 0 \leq i \leq m - 1}$로 분할됩니다. 특히, $C_0 = n$(근평면 위치)이고 $C_m = f$(원평면 위치)입니다.

**Figure 10-2 오버헤드 광원을 사용한 분할 방식의 구성**

우리는 다음 단계로 분할 방식 PSSM(m, res)을 적용합니다:

1. 뷰 프러스텀을 m개의 부분 ${V_i}$로 분할합니다.
2. 각 $V_i$에 대해 광원의 뷰 및 투영 행렬을 계산합니다.
3. 각 부분 $V_i$에 대해 섀도우 맵 $T_i$를 생성합니다.
4. 장면을 렌더링하고 각 픽셀에 대해 적절한 섀도우 맵 $T_i$를 샘플링하여 섀도우를 합성합니다.

---

### **10.1 깊이 레이어에 대한 분할 평면 위치 선택**

1단계의 주요 문제는 분할 평면이 어디에 배치되는지를 결정하는 것입니다. 사용자는 애플리케이션별 요구사항에 따라 분할 위치를 조정할 수 있지만, 우리의 구현은 Zhang et al. 2006에서 제안된 실용적 분할 방식(practical split scheme)을 사용합니다.

이 분할 방식을 소개하기 전에, 섀도우 매핑의 앨리어싱 문제를 간략하게 검토하겠습니다. 이는 Stamminger and Drettakis 2002, Wimmer et al. 2004, Lloyd et al. 2006에서 광범위하게 논의되었습니다.

Figure 10-3에서, 텍셀(크기 $d_s$)을 통과하는 광선들은 월드 공간에서 길이 $d_z$를 가진 물체의 표면에 떨어집니다.

Direct3D의 표준 투영 행렬로부터, 우리는 표면에서 투영된 뷰 빔의 크기 $d_p$(정규화된 스크린에서)가 $dy(z \tan \theta)^{-1}$임을 알고 있습니다.

여기서 $\theta = \alpha/2$는 뷰 프러스텀의 시야각입니다.

Figure 10-3의 표면 로컬 뷰로부터, 우리는 근사식 $dy \approx d_z \cos \phi/\cos \theta$를 얻습니다. 여기서 $\phi$와 $\theta$는 각각 표면 법선과 스크린으로의 벡터, 그리고 섀도우 맵 평면 사이의 각도를 나타냅니다.

**Figure 10-3 섀도우 맵 앨리어싱**

작은 표면에 대한 앨리어싱 오류는 다음과 같이 정의됩니다:

$$\frac{d_p}{d_s} = n \cdot \frac{d_z}{zd_s} \cdot \frac{\cos \phi}{\cos \theta}$$

우리는 일반적으로 이 앨리어싱 표현 $d_p/d_s$를 두 부분으로 분해합니다: 원근 앨리어싱(perspective aliasing) $d_z/zd_s$와 투영 앨리어싱(projection aliasing) $\cos \phi/\cos \theta$(주어진 뷰 행렬에 대해 $n$은 상수입니다). 섀도우 맵 언더샘플링은 원근 앨리어싱 또는 투영 앨리어싱이 커질 때 발생할 수 있습니다.

투영 앨리어싱은 로컬 기하학적 세부사항에 의존하므로, 이러한 종류의 앨리어싱을 줄이려면 각 프레임마다 비용이 많이 드는 장면 분석이 필요합니다. 반면에, 원근 앨리어싱은 원근 단축(perspective foreshortening) 효과에서 비롯되며, 원근 투영 변환을 사용하여 섀도우 평면을 왜곡함으로써 줄일 수 있습니다. 더 중요한 것은, 원근 앨리어싱은 장면 독립적이므로, 원근 앨리어싱을 줄이는 것은 복잡한 장면 분석을 필요로 하지 않습니다.

실용적 분할 방식은 원근 앨리어싱 분석에 기반합니다.

실용적 분할 방식에서, 분할 위치는 다음 방정식으로 결정됩니다:

$$C_i = \lambda C_i^{\text{log}} + (1 - \lambda) C_i^{\text{uniform}}$$

여기서 ${C_i^{\text{log}}}$와 ${C_i^{\text{uniform}}}$은 각각 로그 분할 방식과 균등 분할 방식입니다. 매개변수 $\lambda \in [0, 1]$은 두 방식 사이의 가중치입니다.

**Figure 10-4 섀도우 맵 공간에서 실용적 분할 방식의 시각화**

---

#### **10.1.1 로그 분할 방식**

이론적으로 최적의 원근 앨리어싱 분포는 전체 깊이 범위에 걸쳐 $d_z/zd_s$를 일정하게 만듭니다. Wimmer et al. 2004에 나타난 바와 같이, 다음의 간단한 유도는 최적의 섀도우 맵 매개변수화 $s(z)$를 제공합니다:

$$\frac{d_z}{zd_s} = \rho \quad \text{(여기서 } \rho \text{는 상수)}$$

이를 적분하면:

$$s(z) = \frac{\ln(z)}{\rho} + C$$

여기서 $\rho$는 상수입니다. $s(f) = 1$로부터, 우리는 $\rho = \ln(f/n)$을 얻습니다.

현재 하드웨어에서 지원하는 유일한 비선형 변환은 원근 투영 변환$(s = A/z + B)$이므로, 이전의 로그 매핑을 $z$에서 $s$로 근사하기 위해, 로그 분할 방식은 $z = C_i^{\text{log}}$에서 여러 깊이 레이어로 이를 이산화합니다:

$$s_i = \frac{i}{m} = \frac{\ln(z_i)}{\ln(f/n)}$$

로그 분할 방식은 이론적으로 균등한 원근 앨리어싱 분포를 생성하도록 설계되었기 때문에, 각 분할에 할당되는 해상도는 전체 텍스처 해상도의 $1/m$이어야 합니다. $s_i = i/m$을 앞의 방정식에 대입하면 다음을 얻습니다:

$$C_i^{\text{log}} = n\left(\frac{f}{n}\right)^{i/m}$$

로그 분할 방식의 주요 단점은 실제로 뷰어 근처의 분할 부분 길이가 너무 작아서 이러한 분할 부분에 포함될 수 있는 물체가 거의 없다는 것입니다. 분할 방식 PSSM(3)의 상황을 상상해 보십시오. 즉, 뷰 프러스텀이 세 부분으로 분할됩니다. $f = 1000$이고 $n = 1$인 경우, 첫 번째 분할 $V_0$와 두 번째 분할 $V_1$은 뷰 거리의 1%와 10%만을 차지합니다. 일반적으로 뷰어 근처의 부분에 대해서는 오버샘플링이 발생하고, 뷰어로부터 먼 부분에 대해서는 언더샘플링이 발생합니다. 결과적으로, 실제로 로그 분할 방식은 직접 사용하기 어렵습니다.

---

#### **10.1.2 균등 분할 방식**

균등 분할 방식은 단순히 분할 평면을 뷰 방향을 따라 균등하게 배치합니다:

$$C_i^{\text{uniform}} = n + \frac{(f - n) \cdot i}{m}$$

균등 분할 방식의 앨리어싱 분포는 표준 섀도우 맵의 분포와 동일합니다. 표준 섀도우 맵에서 $s = (z - n)/(f - n)$이기 때문에, 투영 앨리어싱을 무시하면 다음을 얻습니다:

$$\frac{d_z}{zd_s} \approx \frac{f - n}{n + s(f - n)} = \frac{1}{\frac{n}{f - n} + s}$$

이것은 표준 섀도우 맵의 앨리어싱 오류가 물체가 뷰 평면 근처로 이동함에 따라 쌍곡선적으로 증가한다는 것을 의미합니다. 표준 섀도우 매핑과 마찬가지로, 균등 분할 방식은 뷰어 근처의 물체에 대해서는 언더샘플링을, 먼 물체에 대해서는 오버샘플링을 초래합니다.

---

로그 및 균등 분할 방식이 근거리 및 원거리 깊이 레이어에 대해 동시에 적절한 샘플링 밀도를 생성할 수 없기 때문에, 실용적 분할 방식은 로그 및 균등 방식을 통합하여 전체 깊이 범위에 걸쳐 적절한 샘플링 밀도를 생성합니다. 가중치 $\lambda$는 애플리케이션의 실용적 요구사항에 따라 분할 위치를 조정합니다. $\lambda = 0.5$는 우리의 현재 구현에서 기본 설정입니다. Figure 10-4에서, 실용적 분할 방식은 근거리 및 원거리 분할 부분에 대해 적절한 샘플링 밀도를 생성합니다. Figure 10-4에 대한 중요한 참고사항: 각 분할 방식에서 색상화된 샘플링 주파수는 개략적인 설명을 위한 것일 뿐이며, 이론적으로 앨리어싱 분포를 정확하게 시각화하는 것은 아닙니다. 여러 깊이 레이어의 (원근) 앨리어싱 분포에 관심이 있는 독자는 Lloyd et al. 2006을 참조할 수 있습니다.

뷰 프러스텀을 분할하기 전에, 뷰 프러스텀이 가시 물체를 가능한 한 밀접하게 포함하도록 카메라의 근평면과 원평면을 조정할 수 있습니다. 이렇게 하면 뷰 프러스텀의 빈 공간 양이 최소화되어 사용 가능한 섀도우 맵 해상도가 증가합니다.

### **10.2 광원의 뷰 및 투영 행렬 계산**

표준 섀도우 매핑과 마찬가지로, 섀도우 맵을 생성할 때 광원의 뷰 및 투영 행렬을 알아야 합니다. 광원의 프러스텀 W를 여러 서브프러스텀 ${W_i}$로 분할함에 따라, 각 $W_i$에 대해 독립적인 투영 행렬을 별도로 구성해야 합니다.

이러한 행렬을 계산하는 두 가지 방법을 제시합니다:

- **장면 독립적 투영(Scene-independent projection)** - 뷰 프러스텀의 기하학적 구조만 사용
- **장면 종속적 투영(Scene-dependent projection)** - 장면 객체의 바운딩 박스도 사용

#### **10.2.1 장면 독립적 투영**

**Figure 10-5 분할 부분 $V_i$에 대한 광원의 투영 행렬 계산**

**Figure 10-6 투영 방법 비교**

서브프러스텀 $W_i$에 대한 투영 행렬을 계산하기 전에, 광원의 좌표 프레임에 대한 분할 프러스텀 $V_i$의 축 정렬 바운딩 박스(axis-aligned bounding box, AABB)를 찾아야 합니다. BoundingBox 클래스는 Figure 10-5에 표현되어 있으며, 두 개의 벡터 - 최소 벡터와 최대 벡터 - 를 사용하여 각각 가장 작은 좌표와 가장 큰 좌표를 저장합니다.

계산을 단순화하기 위해, 우리는 CreateAABB() 함수를 사용하여 광원의 클립 공간에서 분할 프러스텀의 축 정렬 바운딩 박스를 결정합니다. 바운딩 박스의 최소 z 값을 0으로 설정하는데, 이는 근평면 위치를 변경하지 않고 유지하고 싶기 때문입니다. 이 위치를 변경하지 않고 유지하려는 이유는 분할의 바운딩 박스의 근평면과 광원의 근평면 사이에 섀도우 캐스터가 있을 수 있기 때문입니다. 이 경우는 Figure 10-5의 "caster" 객체로 설명됩니다.

이후, 우리는 광원의 프러스텀 $W_i$를 CreateAABB()로 계산된 바운딩 박스로 효과적으로 "줌인"하기 위해 크롭 행렬(crop matrix)을 구축합니다. 크롭 행렬은 오프센터 직교 투영 행렬이며, Listing 10-1에 표시된 대로 계산됩니다.

**Listing 10-1. 광원의 투영을 크롭하기 위한 행렬 구축**

```cpp
// Build a matrix for cropping light's projection
// Given vectors are in light's clip space Matrix
Light::CalculateCropMatrix(Frustum splitFrustum)
{
    Matrix lightViewProjMatrix = viewMatrix * projMatrix;
    
    // Find boundaries in light's clip space
    BoundingBox cropBB = CreateAABB(splitFrustum.AABB, lightViewProjMatrix);
    
    // Use default near-plane value
    cropBB.min.z = 0.0f;
    
    // Create the crop matrix
    float scaleX, scaleY, scaleZ;
    float offsetX, offsetY, offsetZ;
    
    scaleX = 2.0f / (cropBB.max.x - cropBB.min.x);
    scaleY = 2.0f / (cropBB.max.y - cropBB.min.y);
    offsetX = -0.5f * (cropBB.max.x + cropBB.min.x) * scaleX;
    offsetY = -0.5f * (cropBB.max.y + cropBB.min.y) * scaleY;
    scaleZ = 1.0f / (cropBB.max.z - cropBB.min.z);
    offsetZ = -cropBB.min.z * scaleZ;
    
    return Matrix(scaleX, 0.0f, 0.0f, 0.0f, 
                  0.0f, scaleY, 0.0f, 0.0f, 
                  0.0f, 0.0f, scaleZ, 0.0f, 
                  offsetX, offsetY, offsetZ, 1.0f);
}
```

마지막으로, 섀도우 맵 텍스처 $T_i$를 생성할 때 광원의 뷰-투영 변환 lightViewMatrix * lightProjMatrix * cropMatrix를 사용합니다.

광원의 클립 공간에서 크롭 행렬을 계산하는 대신, 광원의 뷰 공간과 같은 다른 공간에서 분할별 투영 행렬을 계산할 수도 있습니다. 그러나 포인트 라이트와 방향성 광원 모두 광원의 클립 공간에서 방향성 광원으로 변환되기 때문에, 우리의 방법은 방향성 광원과 포인트 라이트에 대해 동일한 방식으로 작동합니다. 더욱이, 광원의 클립 공간에서 바운딩 박스를 계산하는 것이 더 직관적입니다.

#### **10.2.2 장면 종속적 투영**

장면 독립적 투영을 사용하는 것이 대부분의 경우 잘 작동하지만, 장면 기하학을 고려함으로써 텍스처 해상도 사용을 더욱 최적화할 수 있습니다.

Figure 10-6에서 볼 수 있듯이, 장면 독립적 $W_i$는 많은 양의 빈 공간을 포함할 수 있습니다. 각 $W_i$는 $V_i$에 섀도우를 드리울 가능성이 있는 객체들만 포함하면 되는데, 이를 섀도우 캐스터(shadow casters)라고 하며, $B_C$로 예시됩니다. 객체의 보이지 않는 부분은 최종 이미지로 렌더링될 필요가 없기 때문에, $V_i$ 내부(또는 부분적으로 내부)에 있는 섀도우 관련 객체를 섀도우 리시버(shadow receivers)로 별도로 저장하며, $B_R$로 예시됩니다. 전체 장면의 섀도우된 이미지를 합성할 때, 렌더링 성능을 향상시키기 위해 섀도우 리시버만 렌더링합니다. 섀도우를 절대 드리우지 않는 객체(예: 지형)는 리시버에만 포함되어야 한다는 점에 유의하십시오.

장면 종속적 방법에서, $W_i$의 근평면은 $V_i$ 또는 임의의 섀도우 캐스터를 둘러싸도록 이동되며, $W_i$의 원평면은 $V_i$ 또는 임의의 섀도우 리시버에 닿도록 이동됩니다. 최적화된 근평면과 원평면은 이산 깊이 양자화의 정밀도를 향상시킵니다. 더욱이, 섀도우 리시버만 섀도우 결정 중에 깊이 비교를 수행하면 되므로, $W_i$의 x 및 y 경계를 조정하여 $V_i$ 또는 임의의 섀도우 리시버를 둘러싸도록 합니다. 장면 종속적 방법의 의사 코드는 Listing 10-2에 나와 있습니다. 깊이 경계(min.z 및 max.z)가 어떻게 선택되는지 특히 주의를 기울이십시오.

현재 분할에 대한 최종 광원의 뷰-투영 변환 행렬은 여전히 lightViewMatrix * lightProjMatrix * cropMatrix입니다.

**Listing 10-2. 장면 종속적 크롭 행렬 계산**

```cpp
Matrix Light::CalculateCropMatrix(ObjectList casters, ObjectList receivers,
                                   Frustum frustum)
{
    // Bounding boxes
    BoundingBox receiverBB, casterBB, splitBB;
    Matrix lightViewProjMatrix = viewMatrix * projMatrix;
    
    // Merge all bounding boxes of casters into a bigger "casterBB".
    for (int i = 0; i < casters.size(); i++)
    {
        BoundingBox bb = CreateAABB(casters[i]->AABB, lightViewProjMatrix);
        casterBB.Union(bb);
    }
    
    // Merge all bounding boxes of receivers into a bigger "receiverBB".
    for (int i = 0; i < receivers.size(); i++)
    {
        bb = CreateAABB(receivers[i]->AABB, lightViewProjMatrix);
        receiverBB.Union(bb);
    }
    
    // Find the bounding box of the current split
    // in the light's clip space.
    splitBB = CreateAABB(splitFrustum.AABB, lightViewProjMatrix);
    
    // Scene-dependent bounding volume
    BoundingBox cropBB;
    cropBB.min.x = Max(Max(casterBB.min.x, receiverBB.min.x), splitBB.min.x);
    cropBB.max.x = Min(Min(casterBB.max.x, receiverBB.max.x), splitBB.max.x);
    cropBB.min.y = Max(Max(casterBB.min.y, receiverBB.min.y), splitBB.min.y);
    cropBB.max.y = Min(Min(casterBB.max.y, receiverBB.max.y), splitBB.max.y);
    cropBB.min.z = Min(casterBB.min.z, splitBB.min.z);
    cropBB.max.z = Min(receiverBB.max.z, splitBB.max.z);
    
    // Create the crop matrix.
    float scaleX, scaleY, scaleZ;
    float offsetX, offsetY, offsetZ;
    
    scaleX = 2.0f / (cropBB.max.x - cropBB.min.x);
    scaleY = 2.0f / (cropBB.max.y - cropBB.min.y);
    offsetX = -0.5f * (cropBB.max.x + cropBB.min.x) * scaleX;
    offsetY = -0.5f * (cropBB.max.y + cropBB.min.y) * scaleY;
    scaleZ = 1.0f / (cropBB.max.z – cropBB.min.z);
    offsetZ = -cropBB.min.z * scaleZ;
    
    return Matrix(scaleX, 0.0f, 0.0f, 0.0f, 
                  0.0f, scaleY, 0.0f, 0.0f, 
                  0.0f, 0.0f, scaleZ, 0.0f, 
                  offsetX, offsetY, offsetZ, 1.0f);
}
```

---

### **10.3 구현**

3단계와 4단계는 시스템 하드웨어에 따라 다르게 구현될 수 있습니다. PSSMs에서 여러 섀도우 맵을 사용하기 때문에, 섀도우 맵을 생성하고 여러 섀도우 맵을 샘플링할 때 추가 렌더링 패스가 필요할 수 있습니다.

렌더링 성능에 대한 이러한 부담을 줄이기 위해, 하드웨어별 접근 방식을 사용할 수 있습니다. 다음 섹션에서는 PSSMs를 생성하고 섀도우를 합성하기 위한 세 가지 하드웨어별 방법을 제시합니다:

- **멀티패스 방법** - 추가 하드웨어 기능 없이 순차적으로 각 섀도우 맵과 섀도우를 렌더링합니다.
- **DirectX 9 레벨 하드웨어 가속** - 프로그래머블 셰이더를 사용하여 장면 섀도우를 단일 패스로 렌더링합니다.
- **DirectX 10 레벨 하드웨어 가속** - 지오메트리 셰이더를 사용하여 섀도우 맵과 장면 섀도우를 모두 가속화합니다.

세 가지 방법 모두에서, 뷰 프러스텀을 분할하고 광원의 변환 행렬을 계산하는 구현은 앞서 설명한 것과 동일합니다.

세 가지 하드웨어별 구현을 이해하기 쉽게 하기 위해, Figure 10-7과 같이 다른 구현의 렌더링 파이프라인을 시각화합니다.

**Figure 10-7 렌더링 파이프라인의 시각화**

#### **10.3.1 멀티패스 방법**

PSSMs의 첫 번째 구현에서, 우리는 단순히 각 분할 부분의 섀도우와 함께 각 섀도우 맵을 순차적으로 렌더링합니다.

**섀도우 맵 생성**

현재 분할 부분에 대한 광원의 뷰-투영 변환 행렬 lightViewMatrix * lightProjMatrix * cropMatrix를 얻으면, 연관된 섀도우 맵 텍스처를 렌더링할 수 있습니다. 절차는 표준 섀도우 매핑과 동일합니다: 모든 섀도우 캐스터를 깊이 버퍼로 렌더링합니다. 우리의 구현은 32비트 부동소수점(R32F) 텍스처 형식을 사용합니다.

멀티패스 구현에서, PSSMs를 여러 독립적인 섀도우 맵 텍스처에 저장하는 대신, Listing 10-3에 표시된 것처럼 각 렌더링 패스에서 단일 섀도우 맵 텍스처를 재사용합니다.

**Listing 10-3. 멀티패스 PSSMs**

```cpp
for (int i = 0; i < numSplits; i++)
{
    // Compute frustum of current split part.
    splitFrustum = camera->CalculateFrustum(splitPos[i], splitPos[i + 1]);
    casters = light->FindCasters(splitFrustum);
    
    // Compute light's transformation matrix for current split part.
    cropMatrix = light->CalculateCropMatrix(receivers, casters, splitFrustum);
    splitViewProjMatrix = light->viewMatrix * light->projMatrix * cropMatrix;
    
    // Texture matrix for current split part
    textureMatrix = splitViewProjMatrix * texScaleBiasMatrix;
    
    // Render current shadow map.
    ActivateShadowMap();
    RenderObjects(casters, splitViewProjMatrix);
    DeactivateShadowMap();
    
    // Render shadows for current split part.
    SetDepthRange(splitPos[i], splitPos[i + 1]);
    SetShaderParam(textureMatrix);
    RenderObjects(receivers, camera->viewMatrix * camera->projMatrix);
}
```

**장면 섀도우 렌더링**

이전 단계에서 생성된 PSSMs로, 이제 섀도우를 장면에 합성할 수 있습니다. 멀티패스 방법에서는 섀도우 맵을 렌더링한 직후 즉시 섀도우를 합성해야 합니다.

최적의 성능을 위해, 분할을 앞에서 뒤로 렌더링해야 합니다. 그러나 몇 가지 특별한 고려사항이 필요합니다. 한 분할의 객체가 다른 분할과도 겹칠 수 있기 때문에 클리핑을 제공하기 위해 카메라의 근평면과 원평면을 각각의 분할 위치로 조정해야 합니다. 그러나 근평면과 원평면을 수정하면 깊이 버퍼에 쓰여지는 값의 범위도 변경됩니다. 이는 깊이 테스트가 잘못 작동하게 만들지만, 뷰포트에서 다른 깊이 범위를 사용하여 이 문제를 피할 수 있습니다. 단순히 분할 평면 위치를 뷰 공간에서 클립 공간으로 변환하고 이를 새로운 깊이 최소값과 최대값으로 사용합니다.

이후 표준 방식으로 섀도우 맵을 샘플링하면서 장면의 섀도우 리시버를 렌더링할 수 있습니다. 이는 멀티패스 방법을 구현하는 데 셰이더 사용이 필요하지 않음을 의미합니다.

Figure 10-8은 SSM(2K×2K)과 멀티패스 PSSM(3; 1K×1K)를 비교합니다. 그러나 방법의 이름이 암시하듯이, 섀도우 맵을 생성하고 장면 섀도우를 렌더링하는 데 항상 여러 렌더링 패스가 수행됩니다.

**Figure 10-8 SSM과 멀티패스 PSSM 비교**

#### **10.3.2 DirectX 9 레벨 하드웨어 가속**

제시된 간단한 멀티패스 방법을 구현할 때, 장면에서 섀도우를 합성하기 위해 여러 렌더링 패스를 사용해야 합니다. 그러나 프로그래머블 GPU를 사용하면 이 단계를 단일 렌더링 패스로 수행할 수 있습니다.

각 프래그먼트에 대해 올바른 섀도우 맵을 찾아 샘플링하는 픽셀 셰이더를 만들 수 있습니다. 분할 평면이 뷰 평면에 평행하기 때문에 프래그먼트가 어느 분할에 포함되는지 결정하는 작업은 간단합니다. 우리는 단순히 깊이 값을 사용하거나, 우리 구현에서처럼 프래그먼트의 뷰 공간 z 좌표를 사용하여 올바른 섀도우 맵을 결정할 수 있습니다.

장면 섀도우를 단일 패스로 렌더링하기 때문에, 모든 섀도우 맵에 동시에 접근할 수 있어야 합니다. 이전 구현과 달리, 이 방법은 섀도우 맵을 별도로 저장해야 하므로 각 섀도우 맵에 대해 독립적인 텍스처를 생성합니다.

하드웨어에서 지원하는 텍스처 샘플러 수가 사용할 수 있는 섀도우 맵 수를 제한한다는 점에 유의하십시오. 또는 여러 섀도우 맵을 단일 텍스처에 팩킹할 수도 있습니다. 그러나 대부분의 DirectX 9 레벨 하드웨어는 8개의 텍스처 샘플러를 지원하므로 충분히 많아야 합니다.

또한 장면 종속적 투영을 사용할 때 광원의 서브프러스텀 $W_i$가 모든 리시버를 반드시 커버하는 것은 아니기 때문에 섀도우 맵이 텍스처 좌표 범위 밖에서 샘플링되는 경우가 있으므로 "border color" 텍스처 주소 모드를 사용해야 합니다.

장면 섀도우를 렌더링할 때, Listing 10-4에 표시된 것처럼 커스텀 버텍스 및 픽셀 셰이더를 사용합니다. 버텍스 셰이더에서 각 버텍스를 평소와 같이 변환합니다. 그러나 또한 (1) 버텍스의 뷰 공간 위치를 계산하는데, 이는 프래그먼트와 연관된 섀도우 맵을 결정하는 데 사용할 것이기 때문입니다; (2) 각 섀도우 맵의 텍스처 공간에서 버텍스의 위치를 계산합니다. 버텍스에 textureMatrix를 곱하여 버텍스의 위치를 결정합니다. 이는 표준 섀도우 매핑에 사용하는 것과 동일한 접근 방식이며, 이제 모든 섀도우 맵에 대해 사용합니다. 모든 변환된 좌표를 픽셀 셰이더가 사용할 수 있도록 텍스처 좌표 레지스터로 출력합니다.

픽셀 셰이더에서, 모든 분할을 순회하며 프래그먼트의 뷰 공간 거리가 분할의 종료 위치보다 작은지 테스트합니다. 분할 인덱스를 결정한 후, 연관된 텍스처 좌표로 연관된 섀도우 맵을 샘플링하고 표준 섀도우 맵 깊이 테스트를 수행합니다.

**Listing 10-4. DirectX 9 레벨 가속을 위한 셰이더**

```hlsl
sampler2D shadowMapSampler[numSplits];

void VS_RenderShadows(in float4 pos : POSITION,          // Object-space coordinates
                      out float4 posOut : POSITION,       // Clip-space coordinates
                      out float4 texCoord[numSplits + 1] : TEXCOORD) // Texture coordinates
{
    // Calculate world position.
    float4 posWorld = mul(pos, worldMatrix);
    
    // Transform vertex.
    posOut = mul(posWorld, viewProjMatrix);
    
    // Store view-space position in the first texture
    // coordinate register.
    texCoord[0] = mul(posWorld, viewMatrix);
    
    // Store shadow-map coordinates in the remaining
    // texture coordinate registers.
    for (int i = 0; i < numSplits; i++)
    {
        texCoord[i + 1] = mul(posWorld, textureMatrix[i]);
    }
}

float4 PS_RenderShadows(float4 texCoord[numSplits + 1] : TEXCOORD) : COLOR
{
    float light = 1.0f;
    
    // Fetch view-space distance from first texture coordinate register.
    float distance = texCoord[0].z;
    
    for (int i = 0; i < numSplits; i++)
    {
        if (distance < splitPlane[i])
        {
            float depth = texCoord[i + 1].z / texCoord[i + 1].w;
            float depthSM = tex2Dproj(shadowMapSampler[i], texCoord[i + 1]);
            
            // Standard depth comparison
            light = (depth < depthSM) ? 1.0f : 0.0f;
            break;
        }
    }
    
    return light;
}
```

우리는 이 부분 가속 방법을 DirectX 9과 OpenGL 모두에서 구현했습니다. DirectX 9에서는 픽셀 셰이더에서 PCF(Percentage-Closer Filtering)(Reeves et al. 1987)를 구현했고(약 25개 명령어), OpenGL에서는 하드웨어 가속 PCF를 사용했습니다(1개 명령어). 장면의 객체 수를 증가시키면서 멀티패스 방법과 성능을 비교했습니다. 모든 테스트에서 분할 수는 4개였습니다.

Figure 10-9에 표시된 결과에서, DirectX 9 레벨 가속이 성능을 향상시킨다는 것을 알 수 있습니다. 그러나 PCF가 픽셀 셰이더에서 구현되면 셰이더가 더 복잡해집니다. 셰이더 복잡도의 이러한 증가는 성능을 감소시키지만, 장면 복잡도가 증가함에 따라 덜 중요해집니다.

**Figure 10-9 GeForce 6800 Ultra와 GeForce 8800 GTS에서의 성능 결과**

#### **10.3.3 DirectX 10 레벨 하드웨어 가속**

DirectX 9 레벨 하드웨어에서는 장면 섀도우 렌더링이 가속화되지만, PSSMs를 생성하기 위해서는 여전히 여러 렌더링 패스가 필요합니다. 다시 말해, DirectX 9는 PSSMs의 부분 가속을 제공합니다. 반면, DirectX 10 레벨 하드웨어에서는 PSSMs 생성과 장면 섀도우 렌더링을 모두 가속화할 수 있습니다.

Direct3D 10 파이프라인은 지오메트리 셰이더(GS)를 버텍스 셰이더와 픽셀 셰이더 사이의 새로운 셰이더 단계로 도입합니다. 지오메트리 셰이더는 각 프리미티브에 대해 한 번씩 실행되며, 프리미티브의 버텍스를 입력으로 받고 여러 새로운 프리미티브를 출력합니다. 또한 프리미티브 인접성 정보에 대한 접근을 제공하며 버텍스 셰이더와 유사한 명령어 세트를 가집니다(텍스처 샘플링 지원 포함).

Direct3D 10의 또 다른 새로운 기능은 렌더 타겟 배열(render target array)인데, 이는 Direct3D 9의 다중 렌더 타겟(MRTs)과 유사합니다. 그러나 MRT는 각 렌더 타겟에 대해 별도의 픽셀 셰이더 출력만 가능하지만, 렌더 타겟 배열은 (지오메트리 셰이더의 도움으로) 각 렌더 타겟에 완전히 다른 지오메트리를 출력할 수 있습니다. 이는 GS 출력에서 수행되며, 여기서 각 프리미티브에 대해 별도로 렌더 타겟 인덱스를 지정할 수 있습니다.

이러한 기능들은 지오메트리를 다른 변환으로 다른 렌더 타겟에 동적으로 "복제"할 수 있게 합니다. 각 섀도우 캐스터를 한 번만 제출하면 되므로 PSSMs 생성의 성능을 향상시킬 수 있습니다.

**섀도우 맵을 위한 텍스처 배열 생성**

먼저 섀도우 맵을 위한 텍스처 배열을 생성해야 합니다. Listing 10-5에 표시된 것처럼, 평소와 같이 32비트 부동소수점 텍셀 형식을 사용하지만, 깊이 버퍼와 텍스처 모두로 작동해야 하므로 "typeless"로 정의합니다. ArraySize 매개변수는 분할 수로 설정되므로 각각에 대해 하나의 텍스처가 있습니다. 또한 텍스처 배열을 깊이-스텐실 뷰와 셰이더 리소스 뷰 모두에 바인딩할 수 있도록 BindFlags를 설정해야 합니다.

Direct3D 10의 또 다른 새로운 기능인 리소스 뷰를 사용하면 단일 리소스를 다른 방식으로 해석할 수 있습니다. 우리의 경우, 텍스처 배열에 렌더링 가능한 깊이-스텐실 표면과 셰이더 접근 가능 텍스처 모두로 접근해야 하므로 두 가지에 대한 뷰를 생성해야 합니다.

Listing 10-6에 표시된 것처럼, 셰이더 리소스 뷰를 생성하는 것은 간단합니다. 뷰 차원을 텍스처 2D 배열로 설정하고 텍셀 형식을 단일 채널 부동소수점 색상으로 설정합니다. 그렇지 않으면 텍스처 배열을 생성할 때와 동일한 설정을 사용합니다.

깊이-스텐실 뷰는 유사한 방식으로 생성되지만, Listing 10-7에 표시된 것처럼 텍셀 형식을 깊이 버퍼 호환 형식으로 설정해야 합니다.

이제 깊이-스텐실 타겟으로 설정하고 샘플링 가능한 텍스처로 바인딩할 수 있는 섀도우 맵 배열이 있습니다. 깊이 값만 렌더링하는 데 관심이 있고 색상 정보는 아니므로 렌더 타겟을 생성할 필요가 없습니다.

다음 두 하위 섹션에서 설명될 필요한 셰이더를 여전히 생성해야 합니다.

**Listing 10-5. 섀도우 맵을 위한 텍스처 배열 생성**

```cpp
D3D10_TEXTURE2D_DESC DescTex = {};
DescTex.Width = shadowMapSize;
DescTex.Height = shadowMapSize;
DescTex.ArraySize = numSplits;
DescTex.Format = DXGI_FORMAT_R32_TYPELESS;
DescTex.Usage = D3D10_USAGE_DEFAULT;
DescTex.BindFlags = D3D10_BIND_DEPTH_STENCIL | D3D10_BIND_SHADER_RESOURCE;
DescTex.MipLevels = 1;
DescTex.SampleDesc.Count = 1;
device->CreateTexture2D(...)
```

**Listing 10-6. 셰이더 리소스 뷰 생성**

```cpp
D3D10_SHADER_RESOURCE_VIEW_DESC DescSRV = {};
DescSRV.Format = DXGI_FORMAT_R32_FLOAT;
DescSRV.ViewDimension = D3D10_SRV_DIMENSION_TEXTURE2DARRAY;
DescSRV.Texture2DArray.ArraySize = numSplits;
DescSRV.Texture2DArray.MipLevels = 1;
device->CreateShaderResourceView(...)
```

**Listing 10-7. 깊이-스텐실 뷰 생성**

```cpp
D3D10_DEPTH_STENCIL_VIEW_DESC DescDSV = {};
DescDSV.Format = DXGI_FORMAT_D32_FLOAT;
DescDSV.ViewDimension = D3D10_DSV_DIMENSION_TEXTURE2DARRAY;
DescDSV.Texture2DArray.ArraySize = numSplits;
device->CreateDepthStencilView(...);
```

**섀도우 맵 렌더링**

렌더링 파이프라인은 DirectX 9 버전과 유사해 보입니다. 주요 차이점은 섀도우 맵을 한 번만 렌더링한다는 것입니다. 또한 지오메트리 셰이더에서 모두 필요하므로 각 분할의 크롭 행렬을 배열에 저장해야 합니다.

더 중요한 것은, 분할에 대한 잠재적 섀도우 캐스터를 찾은 후, 각 캐스터가 두 변수를 추적해야 한다는 것입니다: firstSplit과 lastSplit. 이러한 변수는 Figure 10-10에 표시된 것처럼 섀도우 캐스터가 렌더링되어야 하는 분할 인덱스의 범위를 결정합니다. 연속적인 바운딩 형상은 항상 연속적인 분할 부분 범위와 겹치기 때문에 첫 번째와 마지막 인덱스만 저장하면 됩니다.

**Figure 10-10 섀도우 캐스터가 분할 부분 $V_i$에서 $V_j$까지 걸쳐 있음**

섀도우 맵 렌더링을 시작하면, Listing 10-8에 표시된 것처럼 새로운 뷰포트를 설정하고 렌더 타겟을 변경해야 합니다. 여기서 변수 pDSV는 이전에 생성된 깊이-스텐실 뷰를 가리킵니다. 깊이 정보만 렌더링할 것이므로 렌더 타겟 수를 0으로, 렌더 타겟 포인터를 NULL로 설정해야 합니다.

**Listing 10-8. 섀도우 맵 렌더링을 위한 뷰포트 및 렌더 타겟 설정**

```cpp
D3D10_VIEWPORT vp;
vp.Width = shadowMapSize;
vp.Height = shadowMapSize;
vp.MinDepth = 0;
vp.MaxDepth = 1;
vp.TopLeftX = 0;
vp.TopLeftY = 0;
device->RSSetViewports(1, &vp);
device->OMSetRenderTargets(0, NULL, pDSV);
```

그런 다음 각 섀도우 캐스터를 한 번 그리지만, 특별한 렌더링 루프에서 그립니다. 이 루프에서 섀도우 캐스터의 해당 값으로 셰이더 상수 firstSplit과 lastSplit을 업데이트해야 합니다. 이러한 변수는 "인스턴스별" 데이터이므로 예를 들어 객체의 월드 행렬처럼 처리되어야 합니다.

다음에서, 서로 다른 분할을 위해 지오메트리를 동적으로 복제하는 두 가지 다른 접근 방식을 제시합니다.

**지오메트리 셰이더 복제 방법**

이 첫 번째 방법에서, 지오메트리 셰이더를 사용하여 제출된 삼각형을 다른 렌더 타겟으로 복제합니다. 이 기법은 Microsoft DirectX SDK에 제시된 단일 패스 큐브 맵 기법과 유사합니다. 먼저 여기서 세부사항을 설명한 다음 성능 이점을 논의하겠습니다.

이 기법을 사용하면, 버텍스 셰이더는 단순히 각 버텍스를 월드 행렬, 광원의 뷰 행렬, 광원의 투영 행렬로 변환합니다. 이 변환은 어떤 섀도우 맵에 렌더링되어야 하는지에 관계없이 모든 섀도우 캐스터에 공통입니다. 분할별 변환은 Figure 10-11에 시각화된 것처럼 대신 지오메트리 셰이더에서 적용됩니다.

**Figure 10-11 지오메트리 셰이더 복제 방법의 GPU 렌더링 파이프라인**

다시 말해, 이제 지오메트리 셰이더를 사용하여 삼각형을 분할별 렌더 타겟으로 복제한 다음 해당 크롭 행렬로도 이러한 삼각형을 변환합니다.

지오메트리 셰이더 코드는 Listing 10-9에 표시되어 있으며, 여기서 렌더링될 각 분할을 순회합니다. 즉, firstSplit에서 lastSplit까지입니다. 이 루프 내에서, 각 버텍스를 분할의 해당 크롭 행렬로 변환합니다. 또한 렌더 타겟 인덱스를 설정한 다음 마지막으로 변환된 버텍스를 새로운 삼각형으로 출력합니다. 렌더 타겟 인덱스는 실제로 버텍스별로 지정되지만, 선두(첫 번째) 버텍스의 값만 관련이 있다는 점에 유의하십시오.

**Listing 10-9. 지오메트리 셰이더**

```hlsl
// Geometry shader output structure
struct GS_OUT
{
    float4 pos : SV_POSITION;
    uint RTIndex : SV_RenderTargetArrayIndex;
};

// Geometry shader
[maxvertexcount(NUMSPLITS * 3)]
void GS_RenderShadowMap(triangle VS_OUT In[3],
                        inout TriangleStream<GS_OUT> triStream)
{
    // For each split to render
    for(int split = firstSplit; split <= lastSplit; split++)
    {
        GS_OUT Out;
        
        // Set render target index.
        Out.RTIndex = split;
        
        // For each vertex of triangle
        for(int vertex = 0; vertex < 3; vertex++)
        {
            // Transform vertex with split-specific crop matrix.
            Out.pos = mul(In[vertex].pos, cropMatrix[split]);
            
            // Append vertex to stream
            triStream.Append(Out);
        }
        
        // Mark end of triangle
        triStream.RestartStrip();
    }
}
```

이 단계에서는 색상 정보를 그리는 데 관심이 없으므로 픽셀 셰이더가 필요하지 않습니다. 따라서 단순히 NULL로 설정할 수 있습니다.

명확성을 위해, 우리가 제시한 구현은 모든 행렬에 대해 별도의 변환을 사용합니다. 뷰/투영/크롭 행렬을 함께 사전 곱셈하면, 이 방법을 사용하여 분할 방식 PSSM(m)을 구현할 수 있으며, 버텍스당 변환 수는 $(1 + m)$입니다. 즉, 모든 버텍스는 월드 행렬로 한 번 변환된 다음 뷰/투영/크롭 행렬로 m번 변환됩니다. 유사한 설정의 표준 섀도우 맵 렌더링은 $(m + m)$ 변환을 사용합니다. 그러나 월드 행렬도 사전 곱셈하면, 두 방법 모두에 대해 변환 수는 동일합니다(m). 지오메트리 셰이더 복제 방법의 장점은 API 오버헤드를 줄인다는 것입니다. 추가 드로우 콜, 렌더 타겟 전환 등의 오버헤드가 제거되는데, 각 섀도우 캐스터를 한 번만 제출하기 때문입니다.

**인스턴싱 방법**

섀도우 맵을 생성하기 위한 두 번째 접근 방식은 Direct3D 10의 향상된 인스턴싱 지원으로 가능합니다. 버텍스 셰이더는 이제 시맨틱 SV_InstanceID를 통해 렌더링되는 인스턴스의 인덱스를 획득할 수 있습니다.

이는 인스턴싱을 사용하여 각 분할에 대해 지오메트리를 복제할 수 있고, 인스턴스 인덱스에서 분할 인덱스를 결정할 수 있음을 의미합니다. 그런 다음 버텍스 셰이더에서 크롭 행렬 변환을 수행할 수 있으므로, Listing 10-10에 표시되고 Figure 10-12에 시각화된 것처럼 지오메트리 셰이더에 남은 유일한 작업은 렌더 타겟 인덱스를 설정하는 것입니다.

**Figure 10-12 인스턴싱 방법의 GPU 렌더링 파이프라인**

인스턴싱으로 렌더링하려면, 인스턴스 수를 lastSplit - firstSplit + 1로 설정하여 DrawIndexedInstanced() 함수를 호출해야 합니다. 이것이 CPU 측에서 필요한 유일한 변경 사항입니다. 추가 버텍스 스트림을 설정할 필요가 없습니다.

**Listing 10-10. 인스턴싱을 사용한 섀도우 맵 렌더링**

```hlsl
struct VS_IN
{
    float4 pos : POSITION;
    uint instance : SV_InstanceID;
};

struct VS_OUT
{
    float4 pos : POSITION;
    uint split : TEXTURE0;
};

VS_OUT VS_RenderShadowMap(VS_IN In)
{
    VS_OUT Out;
    
    // Transform with world/view/projection.
    Out.pos = mul(In.pos, ...);
    
    // Determine split index from instance ID.
    Out.split = firstSplit + In.instance;
    
    // Transform with split-specific crop matrix.
    Out.pos = mul(Out.pos, cropMatrix[Out.split]);
    
    return Out;
}

[maxvertexcount(3)]
void GS_RenderShadowMap(triangle VS_OUT In[3],
                        inout TriangleStream<GS_OUT> triStream)
{
    GS_OUT Out;
    
    // Set render target index.
    Out.RTIndex = In[0].split;
    
    // Pass triangle through.
    Out.pos = In[0].pos;
    triStream.Append(Out);
    Out.pos = In[1].pos;
    triStream.Append(Out);
    Out.pos = In[2].pos;
    triStream.Append(Out);
    triStream.RestartStrip();
}
```

이 방법을 사용하면, 추가 API 오버헤드를 다시 제거합니다. 그러나 변환 수는 표준 섀도우 맵 렌더링과 동일합니다. 그래도 지오메트리 셰이더로 대량의 데이터를 확장하는 것이 비용이 많이 들 수 있기 때문에 인스턴싱 방법이 지오메트리 셰이더 복제를 사용하는 것보다 빠를 수 있습니다.

또한 복제 및 인스턴싱 방법을 함께 사용하여 둘 다 분할의 일부에 대한 지오메트리를 생성하는 데 사용할 수도 있습니다. 예를 들어, 분할 방식 PSSM(4)에서 인스턴싱은 두 개의 분할에 사용될 수 있고 지오메트리 셰이더 복제는 다른 두 개의 분할에 사용될 수 있습니다.

**장면 섀도우 렌더링**

섀도우를 렌더링하는 프로세스는 DirectX 9와 거의 동일합니다. 주요 차이점은 텍스처 배열의 샘플링입니다. 전통적인 방식으로 작업하려면, SampleLevel() 함수를 사용하여 배열의 주어진 텍스처에서 샘플링할 수 있습니다.

이 함수를 사용하는 것은 간단하지만, 두 번째 매개변수는 float3이며, 처음 두 float는 UV 좌표용이고 세 번째 float는 텍스처 인덱스용입니다. 밉맵 레벨은 함수의 세 번째 매개변수에서 정의됩니다.

이 함수로 올바른 텍스처를 샘플링한 후, 평소와 같이 깊이 비교를 수행합니다. 그러나 이것은 최적의 방법이 아니며, 특히 PCF를 사용하려는 경우 그렇습니다. 다음에 큐브 맵을 사용하는 더 나은 접근 방식을 제시합니다.

HLSL 4는 샘플링과 비교를 동시에 수행하는 새로운 함수 SampleCmpLevelZero()를 도입합니다. 선형 비교 필터와 함께 사용하여 PCF를 얻을 수도 있습니다. 이는 함수가 4개의 샘플을 취하고, 각각을 별도로 비교한 다음, 결과를 이중선형 필터링한다는 것을 의미합니다.

안타깝게도, SampleCmpLevelZero()는 현재 Texture2DArray와 함께 사용할 수 없습니다. 그러나 TextureCube와 함께 사용할 수 있습니다. TextureCube는 일반적으로 큐브 맵에 사용되지만, 본질적으로 6개의 텍스처를 가진 텍스처 배열이며, 큐브의 각 면에 하나씩입니다.

이는 최대 6개의 분할에 TextureCube를 사용할 수 있음을 의미합니다. TextureCube를 사용하려면 Listing 10-11에 표시된 것처럼 설정에서 몇 가지 변경만 필요합니다. 섀도우 맵 렌더링은 이전과 동일하게 작동합니다.

**Listing 10-11. TextureCube 사용**

```cpp
// When creating the texture array
DescTex.ArraySize = 6;
DescTex.MiscFlags = D3D10_RESOURCE_MISC_TEXTURECUBE;
...
// When creating the shader resource view
DescSRV.ViewDimension = D3D10_SRV_DIMENSION_TEXTURECUBE;
DescSRV.TextureCube.MipLevels = 1;
```

샘플링은 큐브 맵이 표준 텍스처 좌표로 접근되는 것이 아니라 큐브의 면을 가리키는 벡터로 접근된다는 사실로 인해 약간 복잡합니다. 이 큐브는 단위 큐브이며 원점을 중심으로 합니다. 면은 배열 인덱스 0에서 5까지 +x, -x, +y, -y, +z, -z에 각각 위치하도록 정렬됩니다. 이로부터 Listing 10-12에 표시된 것처럼 각 면에 접근하기 위한 올바른 방향 벡터를 결정할 수 있습니다.

**Listing 10-12. 큐브 좌표 계산 (비최적화)**

```hlsl
float3 cubeCoord;
if (split == 0)
    cubeCoord = float3(0.5, 0.5 - pos.y, 0.5 - pos.x);
else if (split == 1)
    cubeCoord = float3(-0.5, 0.5 - pos.y, pos.x - 0.5);
else if (split == 2)
    cubeCoord = float3(pos.x - 0.5, 0.5, pos.y - 0.5);
else if (split == 3)
    cubeCoord = float3(pos.x - 0.5, -0.5, 0.5 - pos.y);
else if (split == 4)
    cubeCoord = float3(pos.x - 0.5, 0.5 - pos.y, 0.5);
else if (split == 5)
    cubeCoord = float3(0.5 - pos.x, 0.5 - pos.y, -0.5);
```

그러나 Listing 10-12에 표시된 접근 방식은 필요하지 않습니다. Listing 10-13에 표시된 것처럼 다른 경우를 세 개의 룩업 배열로 분리할 수 있으며, 이는 픽셀 셰이더의 성능을 약간 향상시킵니다.

또 다른 문제는 테두리가 단순히 큐브 맵의 다른 면으로 매핑되기 때문에 border color 주소 모드를 사용할 수 없다는 것입니다. 그러나 좌표가 유효한 텍스처 좌표 범위 밖에 있는 경우 샘플링을 완전히 피함으로써 border color 주소 모드를 시뮬레이션할 수 있습니다. 이것도 Listing 10-13에 표시되어 있습니다.

**Listing 10-13. 큐브 맵을 사용한 섀도우 렌더링**

```hlsl
static const float3 offset[6] = {
    float3(0.5, 0.5, 0.5), float3(-0.5, 0.5, -0.5),
    float3(-0.5, 0.5, -0.5), float3(-0.5, -0.5, 0.5),
    float3(-0.5, 0.5, 0.5), float3(0.5, 0.5, -0.5)};

static const float3 mulX[6] = {
    float3(0, 0, -1), float3(0, 0, 1), float3(1, 0, 0),
    float3(1, 0, 0), float3(1, 0, 0), float3(-1, 0, 0)};

static const float3 mulY[6] = {
    float3(0, -1, 0), float3(0, -1, 0), float3(0, 0, 1),
    float3(0, 0, -1), float3(0, -1, 0), float3(0, -1, 0)};

SamplerComparisonState shadowMapSampler
{
    ComparisonFunc = Less;
    Filter = COMPARISON_MIN_MAG_LINEAR_MIP_POINT;
};

float4 PS_RenderShadows(PS_INPUT In) : SV_Target
{
    float light = 1.0f;
    
    for(int split = 0; split < numSplits; split++)
    {
        if(In.distance > splitEnd[split])
        {
            float4 texpos = In.texturePos[split];
            texpos.xyz /= texpos.w;
            
            // Cube map vector lookup
            float3 cubeCoord = offset[split] +
                               mulX[split] * texpos.x +
                               mulY[split] * texpos.y;
            
            // Don't sample outside the border.
            if(min(pos.x, pos.y) > 0 && max(pos.x, pos.y) < 1)
            {
                light = shadowMapCube.SampleCmpLevelZero(shadowMapSampler,
                                                         cubeCoord, texpos.z);
            }
            break;
        }
    }
    
    return light;
}
```

우리의 테스트에서, TextureCube와 함께 SampleCmpLevelZero()를 사용하는 것이 픽셀 셰이더에서 구현된 4-탭 PCF(약 25개 명령어)를 사용하는 Texture2DArray를 사용하는 것에 비해 성능을 약간 향상시켰습니다. 그러나 TextureCube를 사용하면, 더 적은 수가 필요하더라도 항상 6개의 텍스처가 할당되어 종종 메모리가 낭비됩니다.

---

### **10.4 결과**

PSSMs로 섀도우 품질을 향상시키려면 다음 최적화를 사용하십시오:

- **분할 수를 조정합니다.** 더 많은 분할을 사용하면 섀도우 품질이 향상되지만, 렌더링 비용도 증가합니다.
- **$\lambda$ 값을 조정합니다.** 장면에 따라, 다른 $\lambda$ 값(실용적 분할 방식에서)이 다른 분할 분포를 생성하며 다른 결과를 낳습니다.
- **장면 종속적 투영을 사용합니다.** 추가 장면 분석이 필요하지만, 섀도우 맵 해상도를 더 효율적으로 사용합니다.
- **가능한 경우 하드웨어 가속을 사용합니다.** 특히 DirectX 10 레벨 하드웨어는 PSSMs의 렌더링 비용을 크게 줄입니다.

이 장의 나머지 부분에 걸쳐 표시된 Dawnspire: Prelude의 스크린샷(Figure 10-13부터 10-16까지)은 1280×1024의 이미지 크기에서 PSSM(3; 1K×1K) 방식(멀티패스 방법)을 사용하여 렌더링되었습니다. 성능은 AMD Athlon64 X2 3800 CPU, 1GB DDR RAM, GeForce 7800 GTX GPU로 구성된 PC에서 측정되었습니다. 이러한 그림에서 처리된 가시 삼각형의 수는 165K에서 319K 범위입니다. 우리의 실험에서, PSSM(3)과 PSSM(4) 모두 성능과 시각적 품질 사이에서 좋은 절충안을 달성합니다(두 방식에서 각각 초당 31프레임 이상 및 27프레임 이상).

**Figure 10-13 Dawnspire: Prelude의 스크린샷**

**Figure 10-14 Dawnspire: Prelude의 스크린샷**

**Figure 10-15 Dawnspire: Prelude의 스크린샷**

**Figure 10-16 Dawnspire: Prelude의 스크린샷**

---

### **10.5 결론**

많은 애플리케이션, 특히 복잡하고 대규모 장면에서, 고품질 섀도우를 렌더링하는 것은 사용자의 사실감 인식에 중요합니다. 하드웨어 가속 없이도, 섀도우 품질을 극적으로 향상시키기 위해 멀티패스 렌더링의 비용을 감수할 가치가 있습니다.

병렬 분할 섀도우 맵의 기본 아이디어는 우리의 멀티패스 방법처럼 직관적이고 구현하기 쉽습니다. 복잡한 장면 분석 없이 실용적 분할 방식을 사용하여 빠르게 분할 위치를 결정할 수 있습니다. 그러나 하드웨어 가속을 사용하지 않으면, 여러 렌더링 패스로 인한 성능 저하로 인해 이 기법이 대중 시장 애플리케이션에서 광범위하게 사용되는 것을 방해합니다.

이 장에서, 우리는 두 가지 하드웨어 가속 방법을 제시합니다: DirectX 9 레벨 GPU의 부분 가속 구현과 DirectX 10 레벨 GPU의 완전 가속 구현. 부분 가속 구현에서는 섀도우를 합성하는 데 필요한 추가 렌더링 패스가 회피됩니다. DirectX 10 렌더링 파이프라인에서, 우리의 완전 가속 구현은 섀도우 맵과 장면 섀도우를 모두 렌더링하기 위한 추가 렌더링 패스의 비용을 줄입니다.

PSSMs 기법의 성능과 섀도우 품질을 향상시키는 다른 많은 방법이 있지만, 한 가지는 확실합니다: GPU의 빠른 진화와 함께, PSSMs는 고품질 섀도우 렌더링을 위한 유망한 접근 방식입니다.

---

### **10.6 데모**

전체 소스 코드가 포함된 데모는 책의 함께 제공되는 DVD에서 찾을 수 있습니다. 이 장에서 제시된 세 가지 구현 방법이 모두 포함되어 있습니다.

---

### **참고문헌**

Brabec, Stefan, Thomas Annen, and Hans-Peter Seidel. 2002. "Practical Shadow Mapping." Journal of Graphical Tools 7(4), pp. 9–18.

Donnelly, William, and Andrew Lauritzen. 2006. "Variance Shadow Maps." In Proceedings of the Symposium on Interactive 3D Graphics and Games 2006, pp. 161–165.

Lloyd, Brandon, David Tuft, Sung-Eui Yoon, and Dinesh Manocha. 2006. "Warping and Partitioning for Low Error Shadow Maps." In Proceedings of the Eurographics Symposium on Rendering 2006, pp. 215–226.

Martin, Tobias, and Tiow-Seng Tan. 2004. "Anti-aliasing and Continuity with Trapezoidal Shadow Maps." In Proceedings of the Eurographics Symposium on Rendering 2004, pp. 153–160.

Reeves, William, David Salesin, and Robert Cook. 1987. "Rendering Antialiased Shadows with Depth Maps." In Computer Graphics (Proceedings of SIGGRAPH 1987) 21(3), pp. 283–291.

Stamminger, Marc, and George Drettakis. 2002. "Perspective Shadow Maps." In ACM Transactions on Graphics (Proceedings of SIGGRAPH 2002) 21(3), pp. 557–562.

Tadamura, Katsumi, Xueying Qin, Guofang Jiao, and Eihachiro Nakamae. 2001. "Rendering Optimal Solar Shadows with Plural Sunlight Depth Buffers." The Visual Computer 17(2), pp. 76–90.

Williams, Lance. 1978. "Casting Curved Shadows on Curved Surfaces." In Computer Graphics (Proceedings of SIGGRAPH 1978) 12(3), pp. 270–274.

Wimmer, Michael, Daniel Scherzer, and Werner Purgathofer. 2004. "Light Space Perspective Shadow Maps." In Proceedings of the Eurographics Symposium on Rendering 2004, pp. 143–152.

Zhang, Fan, Hanqiu Sun, Leilei Xu, and Kit-Lun Lee. 2006. "Parallel-Split Shadow Maps for Large-Scale Virtual Environments." In Proceedings of ACM International Conference on Virtual Reality Continuum and Its Applications 2006, pp. 311–318.

Zhang, Fan, Hanqiu Sun, Leilei Xu, and Kit-Lun Lee. 2007. "Hardware-Accelerated Parallel-Split Shadow Maps." International Journal of Image and Graphics. In press.

---

**감사의 말**

모든 스크린샷은 Silent Grove Studios의 허가를 받아 Dawnspire: Prelude (http://www.dawnspire.com)에서 가져왔습니다. 이미지 준비를 도와준 Anders Hammervald (anders@hammervald.com)의 진심 어린 도움에 감사드립니다. 설명 그림에 사용된 모델은 http://www.planetquake.com에서 다운로드했습니다.

