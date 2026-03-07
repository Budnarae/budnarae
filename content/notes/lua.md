---
title: 'lua'
tags:
  - language/lua
  - just-in-time
  - translation
---

_lua_

---

_링크_
[lua와 c++ 연동 방법 튜토리얼](https://lucasklassmann.com/blog/2019-02-02-embedding-lua-in-c/)
[sol2 tutorial](https://sol2.readthedocs.io/en/latest/tutorial/tutorial-top.html)

_문서_
[[sol2 | sol2 벼락치기]]
[[sol2 Documentation 번역]]

---
---

### 9.1 – 코루틴 기본 (Coroutine Basics)

이 초판은 Lua 5.0을 위해 작성되었습니다. 이후 버전에서도 여전히 대부분 관련이 있지만, 일부 차이점이 있습니다.  
네 번째 판은 Lua 5.3을 대상으로 하며 Amazon 및 기타 서점에서 구할 수 있습니다.  
책을 구입하면 Lua 프로젝트를 지원하는 데에도 도움이 됩니다.

---

Lua는 모든 코루틴 관련 함수를 `coroutine` 테이블 안에 모아 제공합니다.  
`create` 함수는 새로운 코루틴을 만듭니다.  
이 함수는 하나의 인자를 가지며, 그 인자는 코루틴이 실행할 코드가 들어 있는 함수입니다.  
이 함수는 새로운 코루틴을 나타내는 **thread 타입의 값**을 반환합니다.  
대부분의 경우 `create`의 인자로는 익명 함수가 사용됩니다. 예를 들어 다음과 같습니다:

`co = coroutine.create(function ()        print("hi")      end)  print(co)   --> thread: 0x8071d98`

코루틴은 세 가지 상태 중 하나에 있을 수 있습니다: **suspended(일시 정지됨)**, **running(실행 중)**, **dead(종료됨)**.  
코루틴을 생성하면, 처음에는 **일시 정지(suspended)** 상태로 시작합니다.  
즉, 코루틴은 생성될 때 그 본문을 자동으로 실행하지 않습니다.  
코루틴의 상태는 `status` 함수로 확인할 수 있습니다:

`print(coroutine.status(co))   --> suspended`

`coroutine.resume` 함수는 코루틴의 실행을 (재)시작하며, 상태를 **일시 정지 → 실행 중**으로 변경합니다:

`coroutine.resume(co)   --> hi`

이 예시에서, 코루틴의 본문은 단순히 `"hi"`를 출력하고 종료합니다.  
이때 코루틴은 더 이상 돌아올 수 없는 **dead** 상태가 됩니다:

`print(coroutine.status(co))   --> dead`

지금까지 보면 코루틴은 단지 복잡한 함수 호출 방식처럼 보입니다.  
코루틴의 진정한 힘은 `yield` 함수에서 옵니다.  
이 함수는 실행 중인 코루틴이 자신의 실행을 **일시 중단(suspend)** 하고 나중에 다시 **재개(resume)** 할 수 있게 해줍니다.  
간단한 예시를 봅시다:

`co = coroutine.create(function ()        for i=1,10 do          print("co", i)          coroutine.yield()        end      end)`

이제 이 코루틴을 재개(resume)하면, 실행이 시작되고 첫 번째 `yield`에서 멈춥니다:

`coroutine.resume(co)    --> co   1`

상태를 확인해보면, 코루틴이 **일시 정지(suspended)** 상태이며 다시 재개할 수 있음을 알 수 있습니다:

`print(coroutine.status(co))   --> suspended`

코루틴의 관점에서 보면, 일시 정지되어 있는 동안 발생하는 모든 활동은 `yield` 호출 내부에서 일어나는 것처럼 보입니다.  
다시 코루틴을 재개하면, 그 `yield` 호출이 반환되고 코루틴은 다음 `yield`나 끝에 도달할 때까지 계속 실행됩니다:

`coroutine.resume(co)    --> co   2 coroutine.resume(co)    --> co   3 ... coroutine.resume(co)    --> co   10 coroutine.resume(co)    -- 출력 없음`

마지막 `resume` 호출 시점에, 코루틴의 본문은 루프를 마치고 반환(return)하므로 코루틴은 **dead** 상태가 됩니다.  
만약 이를 다시 재개하려고 하면, `resume`은 `false`와 오류 메시지를 반환합니다:

`print(coroutine.resume(co)) --> false   cannot resume dead coroutine`

`resume`은 **보호 모드(protected mode)** 로 실행된다는 점에 주의하세요.  
따라서 코루틴 내부에서 오류가 발생하더라도 Lua는 오류 메시지를 즉시 표시하지 않고,  
대신 그 오류를 `resume` 호출의 반환값으로 돌려줍니다.

---

Lua에서는 `resume`과 `yield` 쌍이 서로 데이터를 주고받을 수도 있습니다.  
첫 번째 `resume`은, 아직 그에 해당하는 `yield`가 없으므로,  
자신의 추가 인자들을 코루틴의 메인 함수의 인자로 전달합니다:

`co = coroutine.create(function (a,b,c)        print("co", a,b,c)      end) coroutine.resume(co, 1, 2, 3)    --> co  1  2  3`

`resume` 호출은, 오류가 없음을 나타내는 `true` 뒤에,  
해당 `yield`로 전달된 모든 인자들을 반환합니다:

`co = coroutine.create(function (a,b)        coroutine.yield(a + b, a - b)      end) print(coroutine.resume(co, 20, 10))  --> true  30  10`

대칭적으로, `yield`는 자신과 대응하는 `resume` 호출에 전달된 추가 인자들을 반환합니다:

`co = coroutine.create (function ()        print("co", coroutine.yield())      end) coroutine.resume(co) coroutine.resume(co, 4, 5)     --> co  4  5`

마지막으로, 코루틴이 종료될 때, 그 메인 함수에서 반환된 값들은  
해당하는 `resume` 호출로 전달됩니다:

`co = coroutine.create(function ()        return 6, 7      end) print(coroutine.resume(co))   --> true  6  7`

우리는 이런 기능들을 한 코루틴 안에서 모두 동시에 사용하는 경우는 드물지만,  
각각은 모두 유용한 상황이 있습니다.

---

코루틴에 대해 이미 어느 정도 알고 있는 사람들을 위해,  
계속 나아가기 전에 몇 가지 개념을 명확히 할 필요가 있습니다.

Lua가 제공하는 것은 제가 **비대칭 코루틴(asymmetric coroutine)** 이라고 부르는 형태입니다.  
즉, 코루틴의 실행을 **일시 중단하는 함수(yield)** 와,  
일시 중단된 코루틴을 **재개하는 함수(resume)** 가 서로 다릅니다.

반면, 일부 언어에서는 **대칭 코루틴(symmetric coroutine)** 을 제공합니다.  
이 경우, 어떤 코루틴에서든 다른 코루틴으로 제어를 전환하는 **단일 함수**만 존재합니다.

일부 사람들은 비대칭 코루틴을 **반(半)코루틴(semi-coroutine)** 이라고 부르기도 합니다.  
(대칭적이지 않으므로 진정한 “co”(함께) 루틴이 아니라는 이유로.)  
하지만 또 다른 사람들은 **semi-coroutine**이라는 용어를,  
좀 더 제한된 형태의 코루틴 구현을 가리키는 데 사용합니다.  
즉, 코루틴이 **보조 함수 내부에서는 일시 중단할 수 없고**,  
**호출 스택에 남은 호출이 없을 때**, 즉 **메인 본문(main body)** 에서만 `yield`할 수 있는 형태입니다.  
Python의 **generator(제너레이터)** 가 바로 이러한 의미의 semi-coroutine의 예입니다.

---

대칭/비대칭 코루틴의 차이와는 달리,  
**코루틴과 제너레이터의 차이**는 훨씬 깊습니다.  
제너레이터는 **진짜 코루틴으로 구현할 수 있는 여러 흥미로운 구조들을 구현할 만큼 강력하지 않기 때문입니다.**

Lua는 **진정한 비대칭 코루틴(true, asymmetric coroutine)** 을 제공합니다.  
대칭 코루틴을 선호하는 사람이라면,  
이 비대칭 코루틴 기능 위에 손쉽게 대칭 코루틴을 구현할 수도 있습니다.  
그건 간단한 일입니다.  
(기본적으로 각 전환(transfer)은 `yield` 다음에 `resume`을 수행하면 됩니다.)

