---
title: 'FAnimNode_StateMachine'
tags:
  - game
  - Unreal_Engine
---

_Animation State Machine의 실질적 구현체_

---

# 📘 **FAnimNode_StateMachine — Cheat Sheet**

---

# 🟦 1. 헤더 파일 의사 코드 (멤버 함수 + 멤버 변수 선언)

```cpp
// =====================================================================================
// FAnimNode_StateMachine (의사 코드 버전)
// AnimGraph 내에서 Animation State Machine을 구현하는 핵심 노드
// 상태 전환(Update) + 포즈 평가(Evaluate) + Notify 처리 수행
// =====================================================================================

struct FAnimNode_StateMachine : public FAnimNode_Base
{
public:

    // ----------------------------------------------------------------------
    // 1) Update Phase (Transition 조건 평가, State 변경)
    // ----------------------------------------------------------------------

    // void Update_AnyThread(const FAnimationUpdateContext& Context)
    // - 현재 상태 Update
    // - Transition Rule 체크
    // - 필요 시 상태 전환(Change State)
    virtual void Update_AnyThread(const FAnimationUpdateContext& Context) override;

    // bool EvaluateTransition(int32 TransitionIndex, const FAnimationUpdateContext& Context)
    // - Transition Rule 노드 실행
    bool EvaluateTransition(int32 TransitionIndex, const FAnimationUpdateContext& Context);

    // bool CanEnterTransition(int32 TransitionIndex)
    // - Transition 활성 조건 체크
    bool CanEnterTransition(int32 TransitionIndex) const;

    // bool ChangeState(int32 NewStateIndex, const FAnimationUpdateContext& Context)
    // - State 종료, 시작 처리
    bool ChangeState(int32 NewStateIndex, const FAnimationUpdateContext& Context);

    // void OnStateEntered(int32 StateIndex, const FAnimationUpdateContext& Context)
    // - State Begin Notify 처리
    void OnStateEntered(int32 StateIndex, const FAnimationUpdateContext& Context);

    // void OnStateExited(int32 StateIndex, const FAnimationUpdateContext& Context)
    // - State End Notify 처리
    void OnStateExited(int32 StateIndex, const FAnimationUpdateContext& Context);


    // ----------------------------------------------------------------------
    // 2) Evaluate Phase (현재 State Pose 생성)
    // ----------------------------------------------------------------------

    // void Evaluate_AnyThread(FPoseContext& Output)
    // - 현재 Active State의 AnimNode Evaluate 호출
    virtual void Evaluate_AnyThread(FPoseContext& Output) override;

    // void EvaluateTransitionPose(FPoseContext& Output)
    // - Transition 중일 때 Pose 블렌딩 처리
    void EvaluateTransitionPose(FPoseContext& Output);


    // ----------------------------------------------------------------------
    // 3) StateMachine 정보 조회
    // ----------------------------------------------------------------------

    // int32 GetCurrentState() const
    // - 현재 활성 상태 index 반환
    int32 GetCurrentState() const;

    // float GetCurrentStateElapsedTime() const
    // - 현재 State에 머문 시간 반환
    float GetCurrentStateElapsedTime() const;


protected:

    // ========================
    // Internal State Data
    // ========================

    // 현재 활성화된 State index
    int32 CurrentStateIndex;

    // 이전 State index (Transition 중 사용할 수 있음)
    int32 PreviousStateIndex;

    // State 체류 시간
    float StateElapsedTime;

    // Transition 중인지 여부
    bool bIsInTransition;

    // State 리스트 (각 State는 내부에 AnimNode 포함)
    TArray<FAnimationState> States;

    // Transition 리스트
    TArray<FAnimationTransitionRule> Transitions;
};
```

---

# 🟦 2. 클래스 핵심 역할 요약

|역할|설명|
|---|---|
|**Animation StateMachine 로직의 실제 구현체**|Blueprint StateMachine을 런타임에서 실행하는 노드|
|**Update 단계에서 Transition 규칙 평가**|Transition Rule 실행 → 상태 변경 여부 결정|
|**Evaluate 단계에서 현재 State의 Pose 생성**|Active State의 AnimNode를 Evaluate|
|**Transition Blend 처리**|이전 State와 새 State의 Pose를 부드럽게 혼합|
|**State Begin/End Notify 처리**|상태 입장/퇴장 시 이벤트 발생|

---

# 🟦 3. 기능별 상세 설명 (메서드 + 반환형)

---

# 🔷 A. Update Phase (Transition 조건 평가)

StateMachine의 핵심은 Update 단계에서 이루어진다.

---

## ✔ **`void Update_AnyThread(const FAnimationUpdateContext& Context)`**

**반환형:** void  
**역할:**

- 현재 State의 Update 노드 실행
    
- 모든 Transition Rule 평가
    
- 조건 충족 시 ChangeState() 호출
    
- StateElapsedTime 증가
    

---

## ✔ **`bool EvaluateTransition(int32 TransitionIndex, const FAnimationUpdateContext& Context)`**

**반환형:** bool  
**역할:**

- Transition Rule 노드 실행
    
- 결과로 “해당 Transition을 사용할 수 있는지” 반환
    
- 블루프린트의 Transition Graph 실행이 여기서 이루어짐
    

---

## ✔ **`bool CanEnterTransition(int32 TransitionIndex) const`**

**반환형:** bool  
**역할:**

- Transition에 설정된 고정 조건 체크
    
    - e.g., 현재 State가 AllowExclusive인지
        
    - Transition이 Enabled인지
        
- Rule 실행 없이 초기 조건만 확인
    

---

## ✔ **`bool ChangeState(int32 NewStateIndex, const FAnimationUpdateContext& Context)`**

**반환형:** bool  
**역할:**

- State 종료 처리 (`OnStateExited`)
    
- CurrentStateIndex 변경
    
- StateElapsedTime = 0 초기화
    
- State 시작 처리 (`OnStateEntered`)
    

---

## ✔ **`void OnStateEntered(int32 StateIndex, const FAnimationUpdateContext& Context)`**

**반환형:** void  
**역할:**

- 애니메이션 그래프의 State Begin Notify 발생
    
- SequencePlayer 초기화
    

---

## ✔ **`void OnStateExited(int32 StateIndex, const FAnimationUpdateContext& Context)`**

**반환형:** void  
**역할:**

- State End Notify 발생
    
- Cleanup 이벤트 호출
    

---

# 🔷 B. Evaluate Phase (현재 State Pose 생성)

Update는 상태 변경, Evaluate는 포즈 생성.

---

## ✔ **`void Evaluate_AnyThread(FPoseContext& Output)`**

**반환형:** void  
**역할:**

- 현재 상태의 Root AnimNode Evaluate 호출
    
- Transition 중이면 EvaluateTransitionPose() 호출
    
- 최종 Pose를 Output에 저장
    

---

## ✔ **`void EvaluateTransitionPose(FPoseContext& Output)`**

**반환형:** void  
**역할:**

- Transition 중일 때
    
    - 이전 State Pose Evaluate
        
    - 새로운 State Pose Evaluate
        
    - BlendAlpha 기반으로 Pose 혼합
        
- 이 기능이 “부드러운 애니메이션 전환”의 핵심
    

---

# 🔷 C. StateMachine 정보 조회

## ✔ **`int32 GetCurrentState() const`**

**반환형:** int32  
**역할:** 현재 활성 상태 index 반환

---

## ✔ **`float GetCurrentStateElapsedTime() const`**

**반환형:** float  
**역할:** 현재 상태에 머문 시간 반환  
Transition Rule에서 많이 사용됨  
(e.g. 들어온지 0.1초 이상 지났을 때만 전환하기 등)

---

# 🟦 4. FAnimNode_StateMachine 전체 동작 흐름

```
-------------------------
Update Phase (논리)
-------------------------
Update_AnyThread()
 → Active State Update()
 → Transition Rule 평가
 → ChangeState() (필요 시)
 → StateElapsedTime 증가

-------------------------
Evaluate Phase (Pose)
-------------------------
Evaluate_AnyThread()
 → If Transition: EvaluateTransitionPose()
 → Else: ActiveState.Evaluate()
 → Output = 최종 Pose
```

---

# 🟦 5. 과제 구현 시 "꼭 넣어야 하는" 최소 구성 요소

필수 요소만 뽑으면 아래 5가지는 반드시 있어야 한다.

1. **CurrentStateIndex**
    
2. **States[] (State마다 Root AnimNode 하나)**
    
3. **Transitions[] (조건(Expression) 포함)**
    
4. **Update()에서 Transition Rule 평가 및 ChangeState()**
    
5. **Evaluate()에서 Active State의 Evaluate 호출**
    

이 5개만 구현해도  
언리얼의 기본 Animation State Machine 구조와 매우 유사한 형태가 된다.

---

# 🟦 6. 요약 (가장 중요한 5줄)

- **FAnimNode_StateMachine은 Animation State Machine의 실질적 구현체다.**
    
- Update 단계에서 Transition을 평가하고 State 변경을 결정한다.
    
- Evaluate 단계에서 활성 State의 애니메이션 Pose를 생성한다.
    
- Transition 중이면 두 State Pose를 Evaluate 후 Blend하여 부드럽게 전환한다.
    
- OnStateEntered/OnStateExited를 통해 Notify 이벤트를 처리한다.
    

---

원하면 **다음 클래스**도 같은 포맷으로 만들어줄 수 있어:

- FAnimNode_SequencePlayer
    
- FAnimNode_Root
    
- USkeletalMeshComponent
    
- FAnimNode_Base (모든 노드의 기반 클래스)
    

어떤 걸 다음으로 정리해줄까?

