---
tags:
  - translation
  - game
---

_finite state machine_

---

# State (상태)

**Design Patterns Revisited (디자인 패턴 재고찰)**

고백할 시간입니다: 저는 조금 오버해서 이 챕터에 너무 많은 것을 담았습니다. 표면적으로는 [State](http://en.wikipedia.org/wiki/State_pattern) 디자인 패턴에 관한 것이지만, 게임과 관련해서 이것을 이야기하려면 더 근본적인 개념인 유한 상태 머신(finite state machines 또는 "FSM")을 다루지 않을 수 없습니다. 하지만 그렇게 하고 나니, 계층적 상태 머신(hierarchical state machines)과 푸시다운 오토마타(pushdown automata)도 소개하는 게 좋겠다고 생각했습니다.

다룰 내용이 많기 때문에 가능한 한 짧게 유지하기 위해, 여기 있는 코드 샘플들은 여러분이 직접 채워 넣어야 할 몇 가지 세부 사항을 생략했습니다. 그래도 큰 그림을 이해하기에는 충분히 명확하기를 바랍니다.

상태 머신에 대해 들어본 적이 없더라도 슬퍼하지 마세요. AI와 컴파일러 해커들에게는 잘 알려져 있지만, 다른 프로그래밍 분야에서는 그다지 익숙하지 않습니다. 저는 이것이 더 널리 알려져야 한다고 생각하기 때문에, 여기서 다른 종류의 문제에 적용해 보겠습니다.

## We've All Been There (우리 모두 겪어본 일)

우리는 작은 횡스크롤 플랫포머 게임을 만들고 있습니다. 우리의 임무는 게임 세계에서 플레이어의 아바타인 여주인공을 구현하는 것입니다. 이것은 그녀가 사용자 입력에 반응하도록 만드는 것을 의미합니다. B 버튼을 누르면 점프해야 합니다. 충분히 간단합니다:

```cpp
void Heroine::handleInput(Input input)
{
  if (input == PRESS_B)
  {
    yVelocity_ = JUMP_VELOCITY;
    setGraphics(IMAGE_JUMP);
  }
}
```

**버그를 찾으셨나요?**

"공중 점프"를 막는 것이 없습니다 — 공중에 있는 동안 B를 계속 누르면 영원히 떠다닐 것입니다. 간단한 수정 방법은 `Heroine`에 그녀가 점프 중인지 추적하는 `isJumping_` 불리언 필드를 추가하고, 다음과 같이 하는 것입니다:

```cpp
void Heroine::handleInput(Input input)
{
  if (input == PRESS_B)
  {
    if (!isJumping_)
    {
      isJumping_ = true;
      // Jump...
    }
  }
}
```

다음으로, 우리는 플레이어가 땅에 있을 때 아래 버튼을 누르면 여주인공이 웅크리고, 버튼을 놓으면 다시 일어서도록 하고 싶습니다:

```cpp
void Heroine::handleInput(Input input)
{
  if (input == PRESS_B)
  {
    // Jump if not jumping...
  }
  else if (input == PRESS_DOWN)
  {
    if (!isJumping_)
    {
      setGraphics(IMAGE_DUCK);
    }
  }
  else if (input == RELEASE_DOWN)
  {
    setGraphics(IMAGE_STAND);
  }
}
```

**이번엔 버그를 찾으셨나요?**

이 코드로는 플레이어가:

- 아래를 눌러서 웅크릴 수 있습니다.
- 웅크린 자세에서 B를 눌러 점프할 수 있습니다.
- 여전히 공중에 있는 동안 아래 버튼을 놓을 수 있습니다.

여주인공은 점프 도중에 서 있는 그래픽으로 바뀔 것입니다. 또 다른 플래그가 필요한 시간입니다...

```cpp
void Heroine::handleInput(Input input)
{
  if (input == PRESS_B)
  {
    if (!isJumping_ && !isDucking_)
    {
      // Jump...
    }
  }
  else if (input == PRESS_DOWN)
  {
    if (!isJumping_)
    {
      isDucking_ = true;
      setGraphics(IMAGE_DUCK);
    }
  }
  else if (input == RELEASE_DOWN)
  {
    if (isDucking_)
    {
      isDucking_ = false;
      setGraphics(IMAGE_STAND);
    }
  }
}
```

다음으로, 플레이어가 점프 도중에 아래를 누르면 여주인공이 급강하 공격을 하면 멋질 것 같습니다:

```cpp
void Heroine::handleInput(Input input)
{
  if (input == PRESS_B)
  {
    if (!isJumping_ && !isDucking_)
    {
      // Jump...
    }
  }
  else if (input == PRESS_DOWN)
  {
    if (!isJumping_)
    {
      isDucking_ = true;
      setGraphics(IMAGE_DUCK);
    }
    else
    {
      isJumping_ = false;
      setGraphics(IMAGE_DIVE);
    }
  }
  else if (input == RELEASE_DOWN)
  {
    if (isDucking_)
    {
      // Stand...
    }
  }
}
```

**버그 찾기 시간입니다. 찾으셨나요?**

점프 중일 때는 공중 점프를 할 수 없는지 확인하지만, 급강하 중일 때는 확인하지 않습니다. 또 다른 필드가 필요합니다...

우리의 접근 방식에 뭔가 분명히 잘못되었습니다. 이 몇 줄의 코드를 손댈 때마다 뭔가가 망가집니다. 훨씬 더 많은 동작을 추가해야 하는데 — 아직 걷기조차 추가하지 않았습니다 — 하지만 이런 속도라면 완성하기 전에 버그 더미로 무너질 것입니다.

## Finite State Machines to the Rescue (유한 상태 머신이 구원하다)

좌절감에 책상 위의 모든 것을 쓸어버리고 펜과 종이만 남기고는 순서도를 그리기 시작합니다. 여주인공이 할 수 있는 각 행동에 대한 상자를 그립니다: 서 있기, 점프하기, 웅크리기, 급강하하기. 그 상태들 중 하나에서 버튼 누름에 반응할 수 있을 때, 그 상자에서 화살표를 그리고, 그 버튼으로 레이블을 붙이고, 그녀가 전환할 상태에 연결합니다.

축하합니다, 방금 유한 상태 머신을 만들었습니다. 이것들은 오토마타 이론(automata theory)이라고 불리는 컴퓨터 과학의 한 분야에서 나왔으며, 이 데이터 구조 패밀리에는 유명한 튜링 머신(Turing machine)도 포함됩니다. FSM은 그 패밀리의 가장 단순한 멤버입니다.

요점은:

- **머신이 있을 수 있는 고정된 상태 집합이 있습니다.** 우리 예제에서는 서 있기, 점프하기, 웅크리기, 급강하하기입니다.
    
- **머신은 한 번에 한 상태에만 있을 수 있습니다.** 우리 여주인공은 동시에 점프하고 서 있을 수 없습니다. 사실 그것을 막는 것이 우리가 FSM을 사용하는 이유 중 하나입니다.
    
- **입력이나 이벤트의 시퀀스가 머신에 전송됩니다.** 우리 예제에서는 원시 버튼 누름과 놓음입니다.
    
- **각 상태는 전환(transition) 집합을 가지고 있으며, 각각은 입력과 연관되어 있고 상태를 가리킵니다.** 입력이 들어올 때, 현재 상태의 전환과 일치하면, 머신은 그 전환이 가리키는 상태로 변경됩니다.
    

예를 들어, 서 있는 동안 아래를 누르면 웅크리는 상태로 전환됩니다. 점프하는 동안 아래를 누르면 급강하로 전환됩니다. 현재 상태에서 입력에 대한 전환이 정의되지 않았다면, 입력은 무시됩니다.

순수한 형태에서는 그게 전부입니다: 상태, 입력, 전환. 작은 순서도처럼 그릴 수 있습니다. 불행히도, 컴파일러는 우리의 낙서를 인식하지 못하므로, 어떻게 구현할까요? Gang of Four의 State 패턴이 한 가지 방법입니다 — 곧 다룰 것입니다 — 하지만 더 간단하게 시작해 봅시다.

## Enums and Switches (열거형과 스위치)

우리 `Heroine` 클래스가 가진 한 가지 문제는 불리언 필드의 일부 조합이 유효하지 않다는 것입니다: 예를 들어 `isJumping_`과 `isDucking_`은 둘 다 동시에 true여서는 안 됩니다. 한 번에 하나만 true인 플래그들이 여러 개 있다면, 실제로 원하는 것은 `enum`이라는 힌트입니다.

이 경우, 그 `enum`은 정확히 우리 FSM의 상태 집합이므로, 정의해 봅시다:

```cpp
enum State
{
  STATE_STANDING,
  STATE_JUMPING,
  STATE_DUCKING,
  STATE_DIVING
};
```

많은 플래그 대신, `Heroine`은 하나의 `state_` 필드만 가질 것입니다. 또한 분기 순서를 바꿉니다. 이전 코드에서는 입력으로 스위치한 다음 상태로 스위치했습니다. 이것은 한 버튼 누름을 처리하는 코드를 함께 유지했지만, 한 상태의 코드를 여기저기 흩어놓았습니다. 우리는 그것을 함께 유지하고 싶으므로, 먼저 상태로 스위치합니다. 그러면 다음과 같이 됩니다:

```cpp
void Heroine::handleInput(Input input)
{
  switch (state_)
  {
    case STATE_STANDING:
      if (input == PRESS_B)
      {
        state_ = STATE_JUMPING;
        yVelocity_ = JUMP_VELOCITY;
        setGraphics(IMAGE_JUMP);
      }
      else if (input == PRESS_DOWN)
      {
        state_ = STATE_DUCKING;
        setGraphics(IMAGE_DUCK);
      }
      break;

    case STATE_JUMPING:
      if (input == PRESS_DOWN)
      {
        state_ = STATE_DIVING;
        setGraphics(IMAGE_DIVE);
      }
      break;

    case STATE_DUCKING:
      if (input == RELEASE_DOWN)
      {
        state_ = STATE_STANDING;
        setGraphics(IMAGE_STAND);
      }
      break;
  }
}
```

이것은 사소해 보이지만, 이전 코드에 비해 실질적인 개선입니다. 여전히 조건부 분기가 있지만, 변경 가능한 상태를 단일 필드로 단순화했습니다. 하나의 상태를 처리하는 모든 코드가 이제 멋지게 한데 모여 있습니다. 이것은 상태 머신을 구현하는 가장 간단한 방법이며 일부 용도에는 적합합니다.

하지만 여러분의 문제가 이 솔루션을 넘어설 수도 있습니다. 예를 들어, 여주인공이 한동안 웅크려서 충전하고 특수 공격을 발사하는 동작을 추가하고 싶다고 가정해 봅시다. 그녀가 웅크리고 있는 동안, 충전 시간을 추적해야 합니다.

공격이 충전된 시간을 저장하기 위해 `Heroine`에 `chargeTime_` 필드를 추가합니다. 매 프레임마다 호출되는 `update()`가 이미 있다고 가정합니다. 거기에 다음을 추가합니다:

```cpp
void Heroine::update()
{
  if (state_ == STATE_DUCKING)
  {
    chargeTime_++;
    if (chargeTime_ > MAX_CHARGE)
    {
      superBomb();
    }
  }
}
```

그녀가 웅크리기 시작할 때 타이머를 리셋해야 하므로, `handleInput()`을 수정합니다:

```cpp
void Heroine::handleInput(Input input)
{
  switch (state_)
  {
    case STATE_STANDING:
      if (input == PRESS_DOWN)
      {
        state_ = STATE_DUCKING;
        chargeTime_ = 0;
        setGraphics(IMAGE_DUCK);
      }
      // Handle other inputs...
      break;

    // Other states...
  }
}
```

전체적으로, 이 충전 공격을 추가하기 위해, 두 개의 메서드를 수정하고 웅크리는 상태에 있을 때만 의미가 있음에도 불구하고 `Heroine`에 `chargeTime_` 필드를 추가해야 했습니다. 우리가 선호하는 것은 그 모든 코드와 데이터가 한 곳에 깔끔하게 래핑되는 것입니다. Gang of Four가 우리를 도와줍니다.

## The State Pattern (State 패턴)

객체 지향적 사고방식에 깊이 빠진 사람들에게는, 모든 조건부 분기가 동적 디스패치를 사용할 기회입니다 (다시 말해 C++의 가상 메서드 호출). 저는 그 토끼굴을 너무 깊이 들어갈 수 있다고 생각합니다. 때로는 `if`만 있으면 됩니다.

하지만 우리 예제에서는 객체 지향적인 것이 더 적합한 전환점에 도달했습니다. 그것이 우리를 State 패턴으로 이끕니다. Gang of Four의 말로는:

> **객체가 내부 상태가 변경될 때 행동을 변경하도록 허용합니다. 객체가 클래스를 변경하는 것처럼 보일 것입니다.**

그것은 우리에게 많은 것을 말해주지 않습니다. 맙소사, 우리의 `switch`도 그렇게 합니다. 그들이 설명하는 구체적인 패턴은 우리 여주인공에게 적용하면 다음과 같습니다:

### A state interface (상태 인터페이스)

먼저, 상태에 대한 인터페이스를 정의합니다. 상태에 종속적인 모든 행동 — 이전에 `switch`가 있던 모든 곳 — 은 그 인터페이스의 가상 메서드가 됩니다. 우리에게는 `handleInput()`과 `update()`입니다:

```cpp
class HeroineState
{
public:
  virtual ~HeroineState() {}
  virtual void handleInput(Heroine& heroine, Input input) {}
  virtual void update(Heroine& heroine) {}
};
```

### Classes for each state (각 상태에 대한 클래스)

각 상태에 대해 인터페이스를 구현하는 클래스를 정의합니다. 그 메서드들은 그 상태에 있을 때 여주인공의 행동을 정의합니다. 다시 말해, 이전 `switch` 문의 각 case를 가져와서 그 상태의 클래스로 이동시킵니다. 예를 들어:

```cpp
class DuckingState : public HeroineState
{
public:
  DuckingState()
  : chargeTime_(0)
  {}

  virtual void handleInput(Heroine& heroine, Input input) {
    if (input == RELEASE_DOWN)
    {
      // Change to standing state...
      heroine.setGraphics(IMAGE_STAND);
    }
  }

  virtual void update(Heroine& heroine) {
    chargeTime_++;
    if (chargeTime_ > MAX_CHARGE)
    {
      heroine.superBomb();
    }
  }

private:
  int chargeTime_;
};
```

`chargeTime_`도 `Heroine`에서 빼내어 `DuckingState` 클래스로 옮긴 것에 주목하세요. 이것은 훌륭합니다 — 그 데이터는 그 상태에 있을 때만 의미가 있으며, 이제 우리의 객체 모델이 그것을 명시적으로 반영합니다.

### Delegate to the state (상태에 위임하기)

다음으로, `Heroine`에 현재 상태에 대한 포인터를 제공하고, 각 큰 `switch`를 잃어버리고, 대신 상태에 위임합니다:

```cpp
class Heroine
{
public:
  virtual void handleInput(Input input)
  {
    state_->handleInput(*this, input);
  }

  virtual void update()
  {
    state_->update(*this);
  }

  // Other methods...
private:
  HeroineState* state_;
};
```

"상태를 변경"하려면, `state_`를 다른 `HeroineState` 객체를 가리키도록 할당하기만 하면 됩니다. 그것이 State 패턴의 전체입니다.

## Where Are the State Objects? (상태 객체들은 어디에 있나요?)

여기서 한 가지를 얼버무렸습니다. 상태를 변경하려면 `state_`를 새로운 것을 가리키도록 할당해야 하는데, 그 객체는 어디서 오나요? `enum` 구현에서는 쉬웠습니다 — `enum` 값은 숫자와 같은 원시 타입입니다. 하지만 이제 우리의 상태는 클래스이며, 이는 가리킬 실제 인스턴스가 필요하다는 것을 의미합니다. 이에 대한 두 가지 일반적인 답이 있습니다:

### Static states (정적 상태)

상태 객체가 다른 필드를 가지고 있지 않다면, 저장하는 유일한 데이터는 메서드를 호출할 수 있도록 내부 가상 메서드 테이블에 대한 포인터뿐입니다. 그 경우, 하나 이상의 인스턴스를 가질 이유가 없습니다. 어차피 모든 인스턴스가 동일할 것입니다.

그 경우, 단일 정적 인스턴스를 만들 수 있습니다. 동시에 같은 상태에 있는 FSM이 여러 개 있더라도, 그것에 대해 머신 특정적인 것이 없기 때문에 모두 같은 인스턴스를 가리킬 수 있습니다.

그 정적 인스턴스를 어디에 둘지는 여러분에게 달려 있습니다. 말이 되는 곳을 찾으세요. 특별한 이유 없이, 우리는 기본 상태 클래스 안에 두겠습니다:

```cpp
class HeroineState
{
public:
  static StandingState standing;
  static DuckingState ducking;
  static JumpingState jumping;
  static DivingState diving;

  // Other code...
};
```

각 정적 필드는 게임이 사용하는 그 상태의 하나의 인스턴스입니다. 여주인공을 점프시키려면, 서 있는 상태는 다음과 같이 할 것입니다:

```cpp
if (input == PRESS_B)
{
  heroine.state_ = &HeroineState::jumping;
  heroine.setGraphics(IMAGE_JUMP);
}
```

### Instantiated states (인스턴스화된 상태)

그러나 때로는 이것이 작동하지 않습니다. 정적 상태는 웅크리는 상태에 작동하지 않습니다. 그것은 `chargeTime_` 필드를 가지고 있으며, 그것은 웅크리고 있는 여주인공에게 특정적입니다. 이것은 게임에 여주인공이 하나만 있다면 우연히 작동할 수도 있지만, 2인 협동을 추가하고 화면에 두 명의 여주인공을 동시에 두려고 하면 문제가 생길 것입니다.

그 경우, 상태로 전환할 때 상태 객체를 생성해야 합니다. 이것은 각 FSM이 상태의 자체 인스턴스를 가질 수 있게 합니다. 물론, 새로운 상태를 할당한다면, 현재 상태를 해제해야 한다는 것을 의미합니다. 여기서 조심해야 합니다. 변경을 트리거하는 코드가 현재 상태의 메서드에 있기 때문입니다. 우리 발밑에서 `this`를 삭제하고 싶지 않습니다.

대신, `HeroineState`의 `handleInput()`이 선택적으로 새 상태를 반환하도록 허용할 것입니다. 그렇게 하면, `Heroine`은 이전 상태를 삭제하고 새 상태로 교체할 것입니다. 다음과 같이:

```cpp
void Heroine::handleInput(Input input)
{
  HeroineState* state = state_->handleInput(*this, input);
  if (state != NULL)
  {
    delete state_;
    state_ = state;
  }
}
```

이렇게 하면, 메서드에서 반환할 때까지 이전 상태를 삭제하지 않습니다. 이제 서 있는 상태는 새 인스턴스를 생성하여 웅크리기로 전환할 수 있습니다:

```cpp
HeroineState* StandingState::handleInput(Heroine& heroine,
                                          Input input)
{
  if (input == PRESS_DOWN)
  {
    // Other code...
    return new DuckingState();
  }

  // Stay in this state.
  return NULL;
}
```

할 수 있을 때는 정적 상태를 사용하는 것을 선호합니다. 상태 변경마다 객체를 할당하는 메모리와 CPU 사이클을 낭비하지 않기 때문입니다. 하지만 더 상태적인(stateful) 상태의 경우, 이것이 가야 할 길입니다.

## Enter and Exit Actions (진입 및 종료 액션)

State 패턴의 목표는 한 상태의 모든 행동과 데이터를 단일 클래스에 캡슐화하는 것입니다. 우리는 중간쯤 왔지만, 여전히 몇 가지 미해결 문제가 있습니다.

여주인공이 상태를 변경할 때, 그녀의 스프라이트도 전환합니다. 지금은 그 코드가 그녀가 전환하는 상태가 소유하고 있습니다. 웅크리기에서 서기로 갈 때, 웅크리기 상태가 그녀의 이미지를 설정합니다:

```cpp
HeroineState* DuckingState::handleInput(Heroine& heroine,
                                         Input input)
{
  if (input == RELEASE_DOWN)
  {
    heroine.setGraphics(IMAGE_STAND);
    return new StandingState();
  }

  // Other code...
}
```

우리가 정말로 원하는 것은 각 상태가 자신의 그래픽을 제어하는 것입니다. 상태에 진입 액션을 주어서 처리할 수 있습니다:

```cpp
class StandingState : public HeroineState
{
public:
  virtual void enter(Heroine& heroine)
  {
    heroine.setGraphics(IMAGE_STAND);
  }

  // Other code...
};
```

`Heroine`으로 돌아가서, 상태 변경을 처리하는 코드를 수정하여 새 상태에서 그것을 호출합니다:

```cpp
void Heroine::handleInput(Input input)
{
  HeroineState* state = state_->handleInput(*this, input);
  if (state != NULL)
  {
    delete state_;
    state_ = state;

    // Call the enter action on the new state.
    state_->enter(*this);
  }
}
```

이것은 웅크리기 코드를 단순화할 수 있게 해줍니다:

```cpp
HeroineState* DuckingState::handleInput(Heroine& heroine,
                                         Input input)
{
  if (input == RELEASE_DOWN)
  {
    return new StandingState();
  }

  // Other code...
}
```

그것이 하는 일은 서기로 전환하는 것뿐이며, 서기 상태가 그래픽을 처리합니다. 이제 우리의 상태들은 정말로 캡슐화되어 있습니다. 진입 액션에 대해 특히 좋은 점은 어느 상태에서 오든 상관없이 상태에 진입할 때 실행된다는 것입니다.

대부분의 실제 상태 그래프는 같은 상태로의 여러 전환이 있습니다. 예를 들어, 우리 여주인공은 점프나 급강하를 착지한 후에도 서 있게 될 것입니다. 즉, 그 전환이 발생하는 모든 곳에서 일부 코드를 복제해야 한다는 것을 의미합니다. 진입 액션은 그것을 통합할 장소를 제공합니다.

물론, 이것을 확장하여 종료 액션도 지원할 수 있습니다. 이것은 새 상태로 전환하기 직전에 떠나는 상태에서 호출하는 메서드일 뿐입니다.

## What's the Catch? (함정은 무엇인가요?)

FSM을 홍보하는 데 이 모든 시간을 보냈는데, 이제 깔개를 빼버리려고 합니다. 지금까지 말한 모든 것이 사실이며, FSM은 일부 문제에 적합합니다. 하지만 그들의 가장 큰 장점이 또한 가장 큰 결점입니다.

상태 머신은 매우 제한된 구조를 강제함으로써 복잡한 코드를 풀어주는 데 도움을 줍니다. 가진 것은 고정된 상태 집합, 단일 현재 상태, 일부 하드코딩된 전환뿐입니다.

게임 AI와 같이 더 복잡한 것에 상태 머신을 사용하려고 하면, 그 모델의 한계에 정면으로 부딪히게 될 것입니다. 감사하게도, 우리 선조들은 그런 장벽 중 일부를 피하는 방법을 찾았습니다. 이 챕터를 마무리하면서 그 중 몇 가지를 안내하겠습니다.

## Concurrent State Machines (동시 상태 머신)

우리는 여주인공에게 총을 들 수 있는 능력을 주기로 결정했습니다. 열을 담고 있을 때, 그녀는 여전히 이전에 할 수 있던 모든 것을 할 수 있습니다: 달리기, 점프, 웅크리기 등. 하지만 그녀는 그것을 하면서 무기를 발사할 수도 있어야 합니다.

FSM의 경계를 고수하고 싶다면, 가진 상태의 수를 두 배로 늘려야 합니다. 각 기존 상태에 대해, 무장한 채 같은 일을 하는 또 다른 상태가 필요합니다: 서 있기, 총을 들고 서 있기, 점프하기, 총을 들고 점프하기, 이해하시겠죠.

몇 가지 무기를 더 추가하면 상태의 수가 조합적으로 폭발합니다. 엄청난 수의 상태일 뿐만 아니라, 엄청난 양의 중복입니다: 비무장 상태와 무장 상태는 발사를 처리하는 작은 코드를 제외하고는 거의 동일합니다.

문제는 두 개의 상태 — 그녀가 하고 있는 것과 그녀가 들고 있는 것 — 를 단일 머신에 집어넣었다는 것입니다. 모든 가능한 조합을 모델링하려면, 각 쌍에 대한 상태가 필요할 것입니다. 수정은 명백합니다: 두 개의 별도 상태 머신을 가지는 것입니다.

그녀가 하고 있는 것에 대한 원래 상태 머신을 유지하고 그대로 둡니다. 그런 다음 그녀가 들고 있는 것에 대한 별도의 상태 머신을 정의합니다. `Heroine`은 각각에 대해 하나씩 두 개의 "상태" 참조를 가질 것입니다:

```cpp
class Heroine
{
  // Other code...
private:
  HeroineState* state_;
  HeroineState* equipment_;
};
```

여주인공이 상태에 입력을 위임할 때, 둘 다에게 전달합니다:

```cpp
void Heroine::handleInput(Input input)
{
  state_->handleInput(*this, input);
  equipment_->handleInput(*this, input);
}
```

그러면 각 상태 머신은 독립적으로 입력에 반응하고, 행동을 생성하고, 상태를 변경할 수 있습니다. 두 상태 집합이 대부분 관련이 없을 때, 이것은 잘 작동합니다.

실제로는, 상태가 상호작용하는 몇 가지 경우를 찾을 것입니다. 예를 들어, 점프하는 동안 발사할 수 없거나, 무장하고 있으면 급강하 공격을 할 수 없을 수도 있습니다. 그것을 처리하기 위해, 한 상태의 코드에서, 다른 머신의 상태에 대한 몇 가지 조잡한 `if` 테스트를 해서 조정할 것입니다. 가장 우아한 솔루션은 아니지만, 일을 처리합니다.

## Hierarchical State Machines (계층적 상태 머신)

여주인공의 행동을 더 구체화한 후, 그녀는 아마도 유사한 상태를 많이 가질 것입니다. 예를 들어, 서 있기, 걷기, 달리기, 미끄러지기 상태를 가질 수 있습니다. 그 중 어느 것에서든, B를 누르면 점프하고 아래를 누르면 웅크립니다.

간단한 상태 머신 구현으로는, 각 상태에서 그 코드를 복제해야 합니다. 한 번 구현하고 모든 상태에서 재사용할 수 있다면 더 좋을 것입니다.

이것이 상태 머신 대신 객체 지향 코드였다면, 그 상태들 간에 코드를 공유하는 한 가지 방법은 상속을 사용하는 것입니다. 점프와 웅크리기를 처리하는 "땅 위에 있는" 상태에 대한 클래스를 정의할 수 있습니다. 그러면 서 있기, 걷기, 달리기, 미끄러지기가 그것을 상속하고 자신의 추가 행동을 추가할 것입니다.

밝혀진 바로는, 이것은 계층적 상태 머신이라고 불리는 일반적인 구조입니다. 상태는 상위 상태(superstate)를 가질 수 있습니다 (그 자체를 하위 상태(substate)로 만듭니다). 이벤트가 들어올 때, 하위 상태가 처리하지 않으면, 상위 상태 체인을 따라 올라갑니다. 다시 말해, 상속된 메서드를 오버라이드하는 것처럼 작동합니다.

사실, State 패턴을 사용하여 FSM을 구현한다면, 클래스 상속을 사용하여 계층을 구현할 수 있습니다. 상위 상태에 대한 기본 클래스를 정의합니다:

```cpp
class OnGroundState : public HeroineState
{
public:
  virtual void handleInput(Heroine& heroine, Input input)
  {
    if (input == PRESS_B)
    {
      // Jump...
    }
    else if (input == PRESS_DOWN)
    {
      // Duck...
    }
  }
};
```

그런 다음 각 하위 상태가 그것을 상속합니다:

```cpp
class DuckingState : public OnGroundState
{
public:
  virtual void handleInput(Heroine& heroine, Input input)
  {
    if (input == RELEASE_DOWN)
    {
      // Stand up...
    }
    else
    {
      // Didn't handle input, so walk up hierarchy.
      OnGroundState::handleInput(heroine, input);
    }
  }
};
```

물론 이것이 계층을 구현하는 유일한 방법은 아닙니다. Gang of Four의 State 패턴을 사용하지 않는다면, 이것은 작동하지 않습니다. 대신, 메인 클래스의 단일 상태 대신 상태 스택을 사용하여 현재 상태의 상위 상태 체인을 명시적으로 모델링할 수 있습니다.

현재 상태는 스택의 맨 위에 있는 것이고, 그 아래에는 직접 상위 상태가 있고, 그 다음에 그 상태의 상위 상태 등이 있습니다. 일부 상태별 행동을 내놓을 때, 스택의 맨 위에서 시작하여 상태 중 하나가 처리할 때까지 아래로 내려갑니다. (아무도 하지 않으면, 무시합니다.)

## Pushdown Automata (푸시다운 오토마타)

상태 스택도 사용하는 유한 상태 머신의 또 다른 일반적인 확장이 있습니다. 혼란스럽게도, 스택은 완전히 다른 것을 나타내며, 다른 문제를 해결하는 데 사용됩니다.

문제는 유한 상태 머신에 역사 개념이 없다는 것입니다. 어떤 상태에 있는지 알지만, 어떤 상태에 있었는지 기억이 없습니다. 이전 상태로 돌아갈 쉬운 방법이 없습니다.

예를 들어: 앞서 우리는 두려움 없는 여주인공을 이빨까지 무장시켰습니다. 그녀가 총을 발사할 때, 발사 애니메이션을 재생하고 총알과 시각 효과를 생성하는 새로운 상태가 필요합니다. 그래서 `FiringState`를 급조하고, 그녀가 발사할 수 있는 모든 상태가 발사 버튼을 눌렀을 때 그것으로 전환하도록 만듭니다.

까다로운 부분은 발사 후 그녀가 전환할 상태입니다. 서 있는 동안, 달리는 동안, 점프하는 동안, 웅크린 동안 발사할 수 있습니다. 발사 시퀀스가 완료되면, 그녀는 발사 전에 하던 것으로 다시 전환해야 합니다.

바닐라 FSM을 고수한다면, 우리는 이미 그녀가 어떤 상태에 있었는지 잊어버렸습니다. 그것을 추적하려면, 거의 동일한 상태 — 서 있는 동안 발사, 달리는 동안 발사, 점프하는 동안 발사 등 — 를 여러 개 정의해야 합니다. 그래야 각각이 완료되었을 때 올바른 상태로 돌아가는 하드코딩된 전환을 가질 수 있습니다.

우리가 정말로 원하는 것은 발사 전에 있던 상태를 저장하고 나중에 다시 호출하는 방법입니다. 다시, 오토마타 이론이 도와줍니다. 관련 데이터 구조는 [푸시다운 오토마타(pushdown automaton)](http://en.wikipedia.org/wiki/Pushdown_automaton)라고 불립니다.

유한 상태 머신이 상태에 대한 단일 포인터를 가지고 있는 반면, 푸시다운 오토마타는 그것들의 스택을 가지고 있습니다. FSM에서는, 새로운 상태로 전환하면 이전 상태가 교체됩니다. 푸시다운 오토마타는 그렇게 할 수 있지만, 두 가지 추가 작업도 제공합니다:

- **새로운 상태를 스택에 푸시할 수 있습니다.** "현재" 상태는 항상 스택의 맨 위에 있는 것이므로, 이것은 새로운 상태로 전환합니다. 하지만 이전 상태를 버리는 대신 스택의 바로 아래에 둡니다.
    
- **스택에서 맨 위 상태를 팝할 수 있습니다.** 그 상태는 버려지고, 그 아래의 상태가 새로운 현재 상태가 됩니다.
    

이것이 발사를 위해 필요한 것입니다. 단일 발사 상태를 만듭니다. 다른 상태에 있는 동안 발사 버튼을 누르면, 발사 상태를 스택에 푸시합니다. 발사 애니메이션이 완료되면, 그 상태를 팝하고, 푸시다운 오토마타는 자동으로 우리가 이전에 있던 상태로 다시 전환합니다.

## So How Useful Are They? (그래서 얼마나 유용한가요?)

상태 머신에 대한 그런 일반적인 확장들조차도, 여전히 꽤 제한적입니다. 요즘 게임 AI의 트렌드는 [behavior trees](http://web.archive.org/web/20140402204854/http://www.altdevblogaday.com/2011/02/24/introduction-to-behavior-trees/)와 [planning systems](http://web.media.mit.edu/~jorkin/goap.html) 같은 흥미로운 것들을 더 선호하는 쪽입니다. 복잡한 AI에 관심이 있다면, 이 챕터가 한 일은 여러분의 식욕을 돋운 것뿐입니다. 그것을 만족시키려면 다른 책을 읽어야 할 것입니다.

이것이 유한 상태 머신, 푸시다운 오토마타, 그리고 다른 간단한 시스템들이 유용하지 않다는 것을 의미하지는 않습니다. 그것들은 특정 종류의 문제에 대한 좋은 모델링 도구입니다. 유한 상태 머신이 유용한 경우는:

- **내부 상태에 따라 행동이 변하는 엔티티가 있습니다.**
    
- **그 상태가 비교적 적은 수의 별개 옵션 중 하나로 엄격하게 나눌 수 있습니다.**
    
- **엔티티가 시간이 지남에 따라 일련의 입력이나 이벤트에 반응합니다.**
    

게임에서, 그것들은 AI에 사용되는 것으로 가장 잘 알려져 있지만, 사용자 입력 처리, 메뉴 화면 탐색, 텍스트 파싱, 네트워크 프로토콜, 그리고 다른 비동기 행동의 구현에서도 일반적입니다.

---

