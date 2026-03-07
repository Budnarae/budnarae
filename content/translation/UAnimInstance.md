---
tags:
  - game
  - Unreal_Engine
---

_Animation System 실행의 총체_

---

# 📘 **UAnimInstance — Cheat Sheet**

---

# 🟦 1. 헤더 파일 의사 코드 (멤버 변수 + 멤버 함수 선언만)

```cpp
// =====================================================================================
// UAnimInstance (의사 코드 버전)
// 애니메이션 그래프 실행, 파라미터 업데이트, 노티파이 처리, 루트 운영 등
// =====================================================================================

class UAnimInstance : public UObject
{
public:

    // -------------------------
    // 1) Animation Update Phase
    // -------------------------

    // void NativeBeginPlay()
    // - AnimInstance 초기화 시 호출됨
    virtual void NativeBeginPlay();

    // void NativeUpdateAnimation(float DeltaSeconds)
    // - 게임 로직 기준 Update (Tick) 단계
    // - 파라미터 업데이트, Transition 조건에 필요한 변수 갱신
    virtual void NativeUpdateAnimation(float DeltaSeconds);

    // void UpdateAnimationNode(float DeltaSeconds)
    // - AnimGraph Update 전체 실행
    void UpdateAnimationNode(float DeltaSeconds);


    // -------------------------
    // 2) Animation Evaluate Phase
    // -------------------------

    // void EvaluateAnimation()
    // - AnimGraph Evaluate 단계 수행
    // - 최종 Pose 계산
    void EvaluateAnimation();


    // -------------------------
    // 3) Animation Montage / Notify 처리
    // -------------------------

    // void Montage_Play(UAnimMontage* Montage)
    // - 몽타주 재생 시작
    float Montage_Play(class UAnimMontage* Montage, float InPlayRate = 1.f);

    // void Montage_Stop(float BlendOutTime)
    // - 몽타주 재생 정지
    void Montage_Stop(float BlendOutTime, UAnimMontage* Montage);

    // void HandleAnimNotify(const FAnimNotifyEvent& Event)
    // - Notify 이벤트 처리
    void HandleAnimNotify(const struct FAnimNotifyEvent& Event);

    // void TriggerAnimNotifies()
    // - Evaluate 이후 발생해야 할 Notify 처리
    void TriggerAnimNotifies(float DeltaSeconds);


    // -------------------------
    // 4) Player Input 기반 파라미터 세팅 함수 (BlueprintAssignable)
    // -------------------------

    // void SetFloatParameter(FName ParamName, float Value)
    void SetFloatParameter(FName ParamName, float Value);

    // void SetBoolParameter(FName ParamName, bool Value)
    void SetBoolParameter(FName ParamName, bool Value);


protected:

    // -------------------------
    // Internal Data
    // -------------------------

    // AnimGraph 실행을 위한 내부 루트 노드
    FAnimNode_Root AnimGraphRootNode;

    // Evaluate 시 계산된 최종 Pose 캐시
    FCompactPose CurrentPose;

    // Notify 발생 버퍼
    TArray<FAnimNotifyEvent> NotifyQueue;

    // delta seconds 저장
    float DeltaSeconds;

    // AnimInstance 활성 여부
    bool bIsActive;
};
```

---

# 🟦 2. 클래스 역할 요약

|기능|설명|
|---|---|
|**AnimGraph 실행의 중심 컨트롤러**|모든 FAnimNode 업데이트 및 평가를 호출하는 “상위 엔진” 역할|
|**Update 단계 관리**|변수 갱신, Transition 조건 평가 준비|
|**Evaluate 단계 실행**|최종 Skeletal Pose 계산|
|**Animation Notify 처리**|Sequence/State 변화로 발생한 Notify 수집 & Dispatch|
|**Montage 관리**|Montage 재생/정지/블렌딩 처리|
|**파라미터 관리**|Blueprint에서 쓰이는 애니메이션 변수 업데이트|

---

# 🟦 3. 기능별 상세 설명 + 관련 메서드

---

# 🔷 **A. Update Phase 처리 (게임 로직과 동기화)**

애니메이션은 두 단계로 나뉘는데,  
Update는 “논리 처리”, Evaluate는 “Pose 생성”이다.

---

## ✔ **`virtual void NativeUpdateAnimation(float DeltaSeconds)`**

**반환형:** void  
**역할:**

- 사용자가 구현하여 파라미터를 갱신하는 함수
    
- 캐릭터 속도, 이동 상태, 점프 여부 등 StateMachine 입력 값을 설정하는 위치
    
- AnimGraph Update를 직접 수행하지는 않음 (UpdateAnimationNode에서 수행)
    

---

## ✔ **`void UpdateAnimationNode(float DeltaSeconds)`**

**반환형:** void  
**역할:**

- AnimGraph의 모든 FAnimNode Update 호출
    
- SequencePlayer / BlendSpace / StateMachine 전부 갱신
    
- Transition 조건 평가 준비 (StateMachine.Update())
    

---

# 🔷 **B. Evaluate Phase 처리 (최종 Pose 생성)**

## ✔ **`void EvaluateAnimation()`**

**반환형:** void  
**역할:**

- AnimGraph Evaluate 수행
    
- StateMachine.Evaluate() 호출 → Active State Pose 계산
    
- 모든 Blend 노드 Evaluate → 최종 Pose 생성
    
- CurrentPose에 최종 결과 저장
    

---

# 🔷 **C. Notify 처리**

## ✔ **`void HandleAnimNotify(const FAnimNotifyEvent& Event)`**

**반환형:** void  
**역할:**

- 특정 프레임에서 발생한 AnimNotify 이벤트 처리
    
- AnimNotify_XXX C++ 함수 또는 Blueprint 이벤트 호출
    

---

## ✔ **`void TriggerAnimNotifies(float DeltaSeconds)`**

**반환형:** void  
**역할:**

- Evaluate 이후 “이번 프레임에 발생해야 하는 Notify”들을 큐에서 실행
    
- StateMachine Begin/End Notify도 이 과정에서 처리됨
    

---

# 🔷 **D. Montage 관리**

## ✔ **`float Montage_Play(UAnimMontage* Montage, float InPlayRate = 1.f)`**

**반환형:** float (실제 재생된 Play Rate 반환)  
**역할:**

- 지정한 몽타주를 재생
    
- 트랙, 슬롯, 블렌드 인/아웃 설정 자동 처리
    

---

## ✔ **`void Montage_Stop(float BlendOutTime, UAnimMontage* Montage)`**

**반환형:** void  
**역할:**

- 몽타주 재생 중단
    
- BlendOutTime 동안 부드럽게 종료
    

---

# 🔷 **E. 애니메이션 파라미터 설정**

## ✔ **`void SetFloatParameter(FName ParamName, float Value)`**

**반환형:** void  
**역할:**

- AnimBlueprint의 float 변수 설정
    

---

## ✔ **`void SetBoolParameter(FName ParamName, bool Value)`**

**반환형:** void  
**역할:**

- AnimBlueprint의 bool 변수 설정
    
- Transition Rule에서 활용됨
    

---

# 🟦 4. 그림으로 보는 UAnimInstance 흐름

```
             +-------------------------+
Game Tick →  | NativeUpdateAnimation() |
             +-------------------------+
                       ↓
             +-------------------------+
             | UpdateAnimationNode()   |
             | (AnimGraph Update)      |
             +-------------------------+
                       ↓
             +-------------------------+
             | EvaluateAnimation()     |
             | (AnimGraph Evaluate)    |
             +-------------------------+
                       ↓
             +-------------------------+
             | TriggerAnimNotifies()   |
             +-------------------------+
```

---

# 🟦 5. 요약 정리 (가장 중요한 5줄)

- **UAnimInstance는 모든 애니메이션 그래프 실행을 총괄하는 컨트롤러다.**
    
- Update 단계에서는 캐릭터 상태를 분석해 **애니메이션 변수 갱신**을 한다.
    
- 실제 포즈는 Evaluate 단계에서 **AnimGraph 노드들이 만들어낸다.**
    
- Notify, Montage 등 모든 상위 애니메이션 기능도 여기서 관리된다.
    
- FAnimNode_* 계열 노드는 UAnimInstance에 의해 호출되어 동작한다.
    
