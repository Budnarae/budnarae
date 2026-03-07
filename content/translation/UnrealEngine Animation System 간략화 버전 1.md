---
title: 'UnrealEngine Animation System 간략화 버전 1'
tags:
  - game
  - Unreal_Engine
---

_Unreal에서는 animation을 anim이라고 줄여부른다_

---

# 전체 구조

```
USkeletalMeshComponent
        │
        ▼
   UAnimInstance
        │
        ▼
  FAnimNode_StateMachine ──── (State A: FAnimNode_SequencePlayer)
        │
        └──── (State B: FAnimNode_SequencePlayer)
        │
        ▼
   FAnimNode_SequencePlayer
        │
        ▼
   UAnimSequence
        │
        ▼
     USkeleton
```

# 데이터/제어 흐름 요약

```cpp

게임 로직 → USkeletalMeshComponent.Tick()
        ↓
   UAnimInstance.Update()
        ↓
   FAnimNode_Root.Update()
        ↓
FAnimNode_StateMachine.Update()
        ↓
ActiveState → FAnimNode_SequencePlayer.Update()
        ↓
      UAnimSequence (Pose 샘플링)
        ↓
      USkeleton (Bone 트리 참조)
        ↓
FAnimNode_SequencePlayer.Evaluate()
        ↑
StateMachine → Root → AnimInstance → SkeletalMeshComponent

```

---

[[UAnimInstance]]
[[FAnimNode_Base]]
[[FAnimNode_Root]]
[[FAnimNode_StateMachine]]
[[FAnimNode_SequencePlayer]]
[[FAnimStateTransition]]
[[UAnimSequence]]

