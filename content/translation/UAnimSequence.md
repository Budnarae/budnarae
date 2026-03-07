---
tags:
  - game
  - Unreal_Engine
---

_애니메이션의 데이터를 저장_

---

# 📘 **UAnimSequence — Cheat Sheet**

---

# 🟦 1. 헤더 파일 의사 코드 (핵심 멤버 + 주요 메서드만 정제)

```cpp
// ============================================================================
// UAnimSequence (의사 코드)
// Skeletal Animation 의 "실제 데이터"를 보관하는 애셋 클래스
// - 본의 위치/회전/스케일 키프레임
// - 커브(Morph, Material, AnimationCurve)
// - NotifyTrack (AnimNotifies)
// ============================================================================

class UAnimSequence : public UAnimationAsset
{
public:

    // -------------------------------
    // 1. Pose Sampling (핵심)
    // -------------------------------

    // void GetBonePose(FCompactPose& OutPose, float Time, bool bLooping) const
    // → 특정 시간(Time)의 본 Transform 을 OutPose에 채운다.
    void GetBonePose(FCompactPose& OutPose, float Time, bool bLooping) const;

    // void GetCurveData(FCurveElement& OutCurve, float Time) const
    // → 커브(모프/커스텀 커브 등) 값을 Sample 한다.
    void GetCurveData(FBlendedCurve& OutCurve, float Time) const;


    // -------------------------------
    // 2. Notify 처리 및 조회
    // -------------------------------

    // void GetAnimNotifies(float StartTime, float EndTime, TArray<FAnimNotifyEventReference>& OutNotifies) const
    // → Start~End 구간에 발동해야 하는 Notify 찾아줌
    void GetAnimNotifies(float StartTime, float EndTime, TArray<FAnimNotifyEventReference>& OutNotifies) const;

    // float GetSequenceLength() const
    float GetSequenceLength() const;


    // -------------------------------
    // 3. 내부 데이터
    // -------------------------------

protected:

    // 본별 Raw KeyFrame Data (시간 + 트랜스폼)
    FRawAnimSequenceTrack* RawAnimationData;

    // 전체 시퀀스 길이 (초)
    float SequenceLength;

    // Notify Event 정보
    TArray<FAnimNotifyEvent> Notifies;

    // 커브 데이터 (Morph Target, Property Curve 등)
    FSmartNameMapping CurveNames;
};
```

---

# 🟦 2. 클래스 핵심 역할 요약

|역할|설명|
|---|---|
|**로우 애니메이션 데이터 저장소**|본 트랜스폼 키프레임(Translation/Rotation/Scale)|
|**Pose Sampling 기능 제공**|특정 시간의 Bone Pose를 계산하는 기능|
|**Curve Sampling**|MorphTarget / Material Parameter 등 커브 추출|
|**Notify 관리**|시퀀스 내 AnimNotify Track 보관 및 조회|
|**에디터에서 Bake/Compress된 결과물**|SequencePlayer가 재생하는 최종 데이터 원천|

UAnimSequence는 “애니메이션을 저장한 데이터 파일”이고  
FAnimNode_SequencePlayer는 “이 데이터를 재생하는 플레이어”라 보면 정확함.

---

# 🟦 3. 기능별 상세 설명 (메서드 + 반환형)

---

# 🔷 A. Pose Sampling

## ✔ **`void GetBonePose(FCompactPose& OutPose, float Time, bool bLooping) const`**

**반환형:** void  
**역할:**

- 특정 시간의 Bone Transform을 키프레임에서 보간(interpolation)하여 OutPose에 저장
    
- SequencePlayer가 Evaluate 단계에서 호출함
    
- Looping 시 Time이 Length를 넘어가면 Wrap 처리
    

내부적으로는 이런 식(의사 코드):

```
for each bone:
    pos = Interpolate(PositionKeys, Time)
    rot = Interpolate(RotationKeys, Time)
    scale = Interpolate(ScaleKeys, Time)
    OutPose[bone] = (pos, rot, scale)
```

---

## ✔ **`void GetCurveData(FBlendedCurve& OutCurve, float Time) const`**

**반환형:** void  
**역할:**

- 해당 시간의 Animation Curve 값을 Sample
    
- MorphTarget, Cloth Parameter, EyeBlink 등 다양한 커브 대상 포함
    
- UE5에선 _RichCurve_ 구조 기반
    

---

# 🔷 B. Notify 처리

## ✔ **`void GetAnimNotifies(float StartTime, float EndTime, TArray<FAnimNotifyEventReference>& OutNotifies) const`**

**반환형:** void  
**역할:**

- DeltaTime 동안 재생되는 구간에서 발동해야 할 Notify를 찾아 반환
    
- SequencePlayer의 Update 단계에서 사용
    

내부 동작 예:

```
StartTime = OldTime
EndTime = NewTime
→ Notifies 배열에서 TimeRange에 걸리는 Notify 전부 수집
```

---

# 🔷 C. 기본 정보 조회

## ✔ **`float GetSequenceLength() const`**

**반환형:** float  
**역할:**

- Sequence의 전체 재생 길이(초)
    
- Loop 처리, End 이벤트 등에서 사용됨
    

---

# 🟦 4. 내부 처리 흐름 요약

```
UAnimSequence
 ├─ Raw KeyFrame Data 보관
 │      └─ Bone별 Position/Rotation/Scale Keys
 │
 ├─ GetBonePose() 
 │      → Time 기반으로 키프레임 보간하여 Pose 생성
 │
 ├─ GetCurveData()
 │      → Morph/Curve 값 추출
 │
 └─ GetAnimNotifies()
        → 특정 시간 범위의 Notify 조회
```

---

# 🟦 5. 엔진 구현 시 필요한 “최소 핵심 기능”

너가 직접 엔진을 구현한다면  
UAnimSequence에서 꼭 구현해야 할 필수 기능은 다음 네 가지다:

1. **Raw KeyFrame Data 구조**
    
    - Bone별 Vector/Quaternion 키 목록
        
2. **Time 기반 보간(Interpolation)**
    
    - Linear (pos), SLERP (rot), Linear (scale)
        
3. **SequenceLength 저장**
    
4. **Notify Track 조회 함수**
    

이 네 가지면 SequencePlayer가 완벽히 작동한다.

---

# 🟦 6. 5줄 요약

- UAnimSequence는 **애니메이션 데이터 그 자체**(본 키프레임, 커브, 노티파이)를 저장한다.
    
- SequencePlayer는 이를 재생할 뿐이고, 데이터는 모두 UAnimSequence에 있다.
    
- GetBonePose()로 시간 기반 Pose 샘플링을 제공한다.
    
- GetCurveData()는 커브(모프 등)를 추출하는 API다.
    
- NotifyTrack 조회 기능도 함께 제공한다.
    

---

다음 치트시트도 만들어줄 수 있어:

- **UAnimMontage**
    
- **FAnimNode_BlendSpacePlayer**
    
- **FAnimNode_Root**
    
- **USkeletalMeshComponent**
    

