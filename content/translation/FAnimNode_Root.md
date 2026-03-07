---
tags:
  - game
  - Unreal_Engine
---

_Anim Graph 시작점_

---

# 📘 **FAnimNode_Root — Cheat Sheet**

---

# 🟦 1. 헤더 파일 의사 코드 (핵심 멤버 + 주요 메서드만 정제)

```cpp
// ============================================================================
// FAnimNode_Root (의사 코드)
// AnimGraph의 "루트 노드" 역할.
// AnimInstance → AnimGraph Evaluate 경로의 시작점이며,
// 내부에 보유한 하나의 Child 노드의 Pose를 최종 포즈로 반환한다.
// ============================================================================

struct FAnimNode_Root : public FAnimNode_Base
{
public:

    // ------------------------------------------------------------------------
    // 1. Initialize
    // void Initialize(const FAnimationInitializeContext& Context)
    // → Child 노드를 포함해 전체 그래프 초기화
    // ------------------------------------------------------------------------
    virtual void Initialize(const FAnimationInitializeContext& Context) override;

    // ------------------------------------------------------------------------
    // 2. CacheBones
    // void CacheBones(const FAnimationCacheBonesContext& Context)
    // → Child의 BoneIndex 캐시 처리
    // ------------------------------------------------------------------------
    virtual void CacheBones(const FAnimationCacheBonesContext& Context) override;

    // ------------------------------------------------------------------------
    // 3. Update
    // void Update(const FAnimationUpdateContext& Context)
    // → Child Update 호출 (루트 자체는 별도 상태 없음)
    // ------------------------------------------------------------------------
    virtual void Update(const FAnimationUpdateContext& Context) override;

    // ------------------------------------------------------------------------
    // 4. Evaluate
    // void Evaluate(FPoseContext& Output)
    // → Root = Child Pose
    //   Child Evaluate 결과를 그대로 Output에 넘긴다.
    // ------------------------------------------------------------------------
    virtual void Evaluate(FPoseContext& Output) override;

    // ------------------------------------------------------------------------
    // 5. GatherDebugData
    // void GatherDebugData(FNodeDebugData& DebugData)
    // → 디버그 트리에 Child의 디버그 정보 추가
    // ------------------------------------------------------------------------
    virtual void GatherDebugData(FNodeDebugData& DebugData) override;

public:

    // Child 노드 – AnimGraph 전체의 출력 노드 (보통 StateMachine 또는 Blend)
    FPoseLink Result;
};
```

---

# 🟦 2. 핵심 역할 요약

|역할|설명|
|---|---|
|**AnimGraph의 Entry Point 노드**|AnimInstance는 Evaluate 시 Root 노드를 시작점으로 삼는다|
|**Child 노드의 Pose를 최종 결과로 반환**|StateMachine/Blend/SequencePlayer 등 최종 Pose가 여기로 흘러들어옴|
|**전체 AnimGraph 트리를 하향식으로 실행**|Root → Child → Grandchild 순으로 Evaluate 호출|
|**Update, CacheBones 호출 체인 시작점**|애니메이션 파이프라인 전체 실행을 담당|
|**AnimBlueprint의 최종 출력과 동일**|AnimGraph(AnimBP)의 Output Pose 노드와 1:1 대응|

---

# 🟦 3. 기능별 상세 설명 (메서드 + 반환형 + 역할)

---

# 🔷 A. Initialize

### ✔ **`virtual void Initialize(const FAnimationInitializeContext& Context)`**

**반환형:** void  
**역할:**

- Root 자체는 상태 없음
    
- 주요 동작 = `Result.Initialize(Context)`
    
- 즉, **AnimGraph 트리 전체의 Initialize를 시작하는 첫 단계**
    

---

# 🔷 B. CacheBones

### ✔ **`virtual void CacheBones(const FAnimationCacheBonesContext& Context)`**

**반환형:** void  
**역할:**

- Child 노드의 본 캐싱 실행
    
- Root 자체는 본 구조가 없음
    
- 단순히 Child에게 CacheBones 위임
    

---

# 🔷 C. Update

### ✔ **`virtual void Update(const FAnimationUpdateContext& Context)`**

**반환형:** void  
**역할:**

- Child Update 호출
    
- BlendWeight 계산 (AnimGraph 전체 Weight = 1.0f)
    
- StateMachine의 상태 업데이트도 여기서 시작됨
    

---

# 🔷 D. Evaluate

### ✔ **`virtual void Evaluate(FPoseContext& Output)`**

**반환형:** void  
**역할:**

- Root의 존재 이유
    
- Child 노드의 Evaluate 결과를 그대로 Output에 복사
    
- 이 Output이 SkeletalMeshComponent로 전달됨
    

즉:

```
ChildPose = Result.Evaluate()
Output = ChildPose
```

---

# 🔷 E. GatherDebugData

### ✔ **`virtual void GatherDebugData(FNodeDebugData& DebugData)`**

**반환형:** void  
**역할:**

- 디버그 렌더링 시 “Root” 노드 표시
    
- Child 노드의 디버그 데이터를 트리에 추가
    

---

# 🟦 4. AnimGraph 실행 흐름에서의 위치

```
UAnimInstance
   ↓
Root (FAnimNode_Root)
   ↓
StateMachine / Blend / SequencePlayer
   ↓
UAnimSequence
```

Root는 단 하나 존재하는 "애니메이션 트리의 Entry Point"이다.

---

# 🟦 5. 다른 노드와의 관계

- **FAnimNode_Base**의 직접 파생 클래스
    
- **FAnimNode_StateMachine**, **FAnimNode_BlendList**, **FAnimNode_SequencePlayer** 등  
    모든 노드가 Root로부터 Evaluate 호출을 시작
    
- AnimGraph 전체의 최종 Pose는 반드시 Root로 귀결된다.
    

---

# 🟦 6. 엔진 구현 시 왜 필요한가?

StateMachine을 구현하더라도  
**Root가 없으면 Evaluate를 시작할 지점을 엔진이 알 수 없다.**

그래서 최소 AnimGraph 구성은 다음을 포함해야 한다:

```
FAnimNode_Root
    └─ FAnimNode_StateMachine
           └─ Active State Node
                 └─ SequencePlayer
                       └─ UAnimSequence
```

Root 없으면 엔진은 StateMachine을 재생할 수 없음.

---

# 🟦 7. 5줄 요약

- FAnimNode_Root는 AnimGraph의 시작점이다.
    
- Update/Evaluate 호출 체인의 최초 노드이다.
    
- 내부 Child(Result)의 Evaluate 결과를 최종 Pose로 반환한다.
    
- AnimInstance는 항상 Root Evaluate부터 시작한다.
    
- AnimGraph를 직접 구현하려면 Root는 필수 구성 요소이다.
    

