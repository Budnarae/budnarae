
---

#language/JavaScript 

*temporal dead zone*

---

자바스크립트 언어는 코드를 해석하기 전 변수의 초기화에 관련된 코드를 변수의 **선언**과 **초기화**로 분리한 뒤, 변수의 선언 부분만 컨텍스트의 최상단 부분으로 끌어올린다. 그리고 일시적으로 **undefined**를 할당한다. 이러한 동작을 ==호이스팅 hoisting==이라고 한다.

이러한 특성 때문에 **var** 키워드로 선언된 변수는 변수의 초기화 이전에 사용해도 별다른 에러가 출력되지 않는다. 단지 undefined가 할당될 뿐이다.

```javascript

console.log(i);
var i = "I an a variable";

// undefined

console.log(j);
let j = "I an a let";

// ReferenceError: can't access lexical declaration `j' before initialization

```

하지만 **let, const**로 선언된 변수는 변수의 초기화 이전에 사용하면 에러를 출력한다.

호이스팅은 변수의 키워드와 상관없이 동일하게 동작한다.
하지만 let, const로 선언된 변수는 호이스팅 후 ==TDZ temporal dead zone 일시적 비활성 영역==이라는 영역으로 이동한다. TDZ는 변수의 선언 이전에 변수에 접근을 시도하면 에러가 발생시키는 역할을 한다..

> ## 요약
> var은 정의되기 전에 접근할 수 있지만, 그 값에는 접근할 수 없다. let과 const는 정의하기 전에 접근할 수 있다.

---

참고자료

#참고도서/모던_자바스크립트_핵심_가이드 

---
