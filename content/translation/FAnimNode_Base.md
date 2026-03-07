---
tags:
  - game
  - Unreal_Engine
---

_들어가는 말_

---

# 📘 **FAnimNode_Base — Cheat Sheet**

---

# 🟦 1. 헤더 파일 의사 코드 (핵심 멤버 + 주요 메서드만 정제)

```cpp
// ============================================================================
// FAnimNode_Base (의사 코드)
// 모든 AnimGraph 노드의 공통 기반 클래스
// Update(Evaluate) 호출 규약, 트래킹, 블렌딩 등 노드 공통 기능 포함
// ============================================================================

struct FAnimNode_Base
{
public:

    // ------------------------------------------------------------------------
    // 1. Initialize
    // void Initialize(const FAnimationInitializeContext& Context)
    // → 노드가 처음 생성되거나 AnimInstance가 시작될 때 1회 호출
    // ------------------------------------------------------------------------
    virtual void Initialize(const FAnimationInitializeContext& Context);

    // ------------------------------------------------------------------------
    // 2. CacheBones
    // void CacheBones(const FAnimationCacheBonesContext& Context)
    // → BoneIndex 매핑 등 본 구조 정보 캐싱
    // ------------------------------------------------------------------------
    virtual void CacheBones(const FAnimationCacheBonesContext& Context);

    // ------------------------------------------------------------------------
    // 3. Update
    // void Update(const FAnimationUpdateContext& Context)
    // → DeltaTime 기반 내부 상태 업데이트
    //   (StateMachine 전이, 시퀀스 재생 시간 증가 등)
    // ------------------------------------------------------------------------
    virtual void Update(const FAnimationUpdateContext& Context);

    // ------------------------------------------------------------------------
    // 4. Evaluate
    // void Evaluate(FPoseContext& Output)
    // → 이 노드가 생성하는 최종 Pose 계산
    //   (모든 애니메이션 노드는 반드시 이 함수를 통해 Pose를 출력)
    // ------------------------------------------------------------------------
    virtual void Evaluate(FPoseContext& Output);

    // ------------------------------------------------------------------------
    // 5. GatherDebugData
    // void GatherDebugData(FNodeDebugData& DebugData)
    // → 애니메이션 디버그(AnimGraph 시각화) 정보 수집
    // ------------------------------------------------------------------------
    virtual void GatherDebugData(FNodeDebugData& DebugData);

protected:

    // 이 노드의 Weight (부모 Blend 노드 등에서 입력)
    float ActualBlendWeight = 1.0f;

    // 노드가 처음 실행되었는지 여부
    bool bHasBeenInitialized = false;

    // 디버그 이름 / Trace 용 태그
    FName NodeName;
};
```

---

# 🟦 2. 클래스 핵심 역할 요약

|기능|설명|
|---|---|
|**AnimGraph의 모든 노드의 기반(Base Class)**|모든 플레이어, 블렌드, 스테이트머신 노드들은 FAnimNode_Base에서 시작|
|**Update / Evaluate 루프 정의**|애니메이션 실행 규약을 통일|
|**본 캐싱(CacheBones) 제공**|본 인덱스를 미리 최적화하여 Evaluate 시간 단축|
|**스레드 안전 구조**|AnimInstanceProxy와 함께 Animation Thread에서 실행|
|**Debug 기능 제공**|Anim Blueprint 디버그 시 트리 표시용 정보|

---

# 🟦 3. 기능별 상세 설명 (메서드 + 반환형 + 역할)

---

# 🔷 A. Initialize

### ✔ **`virtual void Initialize(const FAnimationInitializeContext& Context)`**

**반환형:** void  
**역할:**

- 애니메이션 실행 시작 시 최초 1회 호출
    
- SequencePlayer라면 여기서 “재생 시작 시간 = 0”으로 초기화
    
- StateMachine이라면 “초기 상태 진입” 처리
    
- 하위 노드의 Initialize도 호출해야 함
    

---

# 🔷 B. CacheBones

### ✔ **`virtual void CacheBones(const FAnimationCacheBonesContext& Context)`**

**반환형:** void  
**역할:**

- 본 인덱스 빠른 Lookup을 위해 CompactBoneIndex, LODBoneIndex 등 캐싱
    
- 성능 최적화의 핵심
    
- Evaluate()보다 먼저 반드시 호출됨
    

예:

```
BoneToRootIndex[MyBoneIndex] = Skeleton->GetParentIndex(MyBoneIndex)
```

---

# 🔷 C. Update

### ✔ **`virtual void Update(const FAnimationUpdateContext& Context)`**

**반환형:** void  
**역할:**

- DeltaTime 기반으로 노드 내부 상태 업데이트
    
- 예)
    
    - SequencePlayer: “재생 시간 += DeltaTime”
        
    - StateMachine: “조건 검사 후 상태 전환”
        
- 페이로드:
    
    - DeltaTime
        
    - BlendWeight
        
    - AnimInstance 관련 Context
        

---

# 🔷 D. Evaluate

### ✔ **`virtual void Evaluate(FPoseContext& Output)`**

**반환형:** void  
**역할:**

- 최종 Pose(본 Transform) + Curve 값을 이 함수로 출력
    
- AnimGraph는 Evaluate를 “트리 전체 하향식” 호출
    
- 반드시 Output.Pose / Output.Curve 를 채워야 정상 동작
    
- SequencePlayer → UAnimSequence에서 Pose Sample
    
- Blend 노드 → 자식 Pose blend 계산
    
- StateMachine → Active State의 Pose 반환
    

모든 애니메이션 해결의 핵심 처리 루틴임.

---

# 🔷 E. GatherDebugData

### ✔ **`virtual void GatherDebugData(FNodeDebugData& DebugData)`**

**반환형:** void  
**역할:**

- AnimGraph 디버그 트리 표시용 정보 전달
    
- 게임플레이에는 영향 없음
    
- 애니메이션 시각적 디버깅(PIE에서 Graph Overlay)에 쓰임
    

---

# 🟦 4. 애니메이션 파이프라인 흐름 안에서의 위치

```
Initialize()
    ↓
CacheBones()
    ↓
Update(DeltaTime)
    ↓
Evaluate(Pose)
```

StateMachine / SequencePlayer 등 모든 노드는  
이 순서대로 실행됨.

---

# 🟦 5. 엔진 구현 시 반드시 필요한 이유

### ✔ Animation State Machine 자체가 FAnimNode_Base를 상속해야 함

StateMachine은 Evaluate, Update를 구현해야 한다.

### ✔ AnimGraph 전체가 FAnimNode_Base 기반의 트리 구조

Root → StateMachine → State → SequencePlayer → …

### ✔ Evaluate/Update 규약 없이는 AnimGraph 호출이 불가능

-> 엔진이 자동 호출할 수 있는 구조가 필요함.

---

# 🟦 6. 완전 요약 (5줄)

- FAnimNode_Base는 **모든 AnimGraph 노드의 공통 부모**이다.
    
- Update/Evaluate/Initialize/CacheBones 구조를 정의해 애니메이션 실행 규약을 제공한다.
    
- 모든 애니메이션 노드는 Evaluate에서 Pose를 생성해야 한다.
    
- StateMachine/SequencePlayer도 반드시 이 규약을 따른다.
    
- AnimGraph 동작의 뼈대이므로, ASM 구현 시 필수적으로 이해해야 한다.
    

